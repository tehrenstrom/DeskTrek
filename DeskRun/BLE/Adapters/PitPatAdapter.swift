import Foundation
import CoreBluetooth

/// Adapter for DeerRun / PitPat treadmills (the "4D 00 …" wire protocol).
///
/// Reverse-engineered against azmke/pitpat-treadmill-control and verified
/// byte-for-byte against a DeerRun Q2 Urban Plus (firmware 37).
///
/// Wire format:
/// - **Service UUID:** FBA0 (also seen as FF00 on some units; we only bind
///   to FBA0 here since that's what this app's registry routes to us).
/// - **Write characteristic:** FBA1 (write without response).
/// - **Notify characteristic:** FBA2.
/// - **Every write is framed:** `4D 00 <counter> <inner_len> <inner_bytes>`,
///   where `<counter>` rolls over at 256 and is shared between commands and
///   heartbeats.
/// - **Commands** use a 23-byte inner packet starting with `0x6A`, ending
///   with `0x43`, carrying speed/ramp/incline/weight/userID and an XOR
///   checksum over bytes [1..20].
/// - **Heartbeats** use a fixed 5-byte inner packet `6A 05 FD F8 43`, and
///   the device expects one after every notification it sends — without
///   it, the firmware ignores command writes.
/// - **Notifications** are 52 or 53 bytes starting with `0x68` or `0x66`,
///   with an XOR checksum at `[-2]` covering `[1..-3]`.
///
/// Because the protocol requires a per-connection counter (stateful),
/// this adapter is a `final class` rather than a struct.
final class PitPatAdapter: TreadmillAdapter {

    // MARK: - Static Identity & Matching

    static var displayName: String { "DeerRun (PitPat)" }

    static var serviceUUIDs: [CBUUID] { [CBUUID(string: "FBA0")] }

    static func matches(peripheral: CBPeripheral, advertisementData: [String: Any]) -> Bool {
        // Primary signal: advertised service UUID FBA0. DeerRun/PitPat units
        // often ship with SKU-style names (e.g. "J-2088") that don't contain
        // "PitPat" or "DeerRun", but they still advertise the FBA0 service.
        if let serviceUUIDs = advertisementData[CBAdvertisementDataServiceUUIDsKey] as? [CBUUID],
           serviceUUIDs.contains(CBUUID(string: "FBA0")) {
            return true
        }

        // Fallback: name match for units where the service UUID isn't in the
        // advertisement packet (it may only appear after service discovery).
        let name = peripheral.name
            ?? advertisementData[CBAdvertisementDataLocalNameKey] as? String
            ?? ""
        return name.contains("PitPat") || name.contains("DeerRun")
    }

    // MARK: - Instance Properties

    var serviceUUID: CBUUID { CBUUID(string: "FBA0") }
    var writeCharacteristicUUID: CBUUID { CBUUID(string: "FBA1") }
    var notifyCharacteristicUUID: CBUUID { CBUUID(string: "FBA2") }
    // FBA1 on the Q2 Urban Plus advertises properties 0x0A (read + write-with-
    // response) and rejects response-less writes with a CoreBluetooth warning,
    // so we must use .withResponse even though the azmke reference happens to
    // run on a bleak stack that auto-picks.
    var writeType: CBCharacteristicWriteType { .withResponse }

    // MARK: - Stateful Session Data

    /// Rolls over every 256 writes. Shared by commands and heartbeats.
    private var counter: UInt8 = 0

    // MARK: - Protocol Constants

    private let startByte: UInt8 = 0x6A
    private let endByte: UInt8 = 0x43
    private let innerLength: UInt8 = 0x17      // 23 bytes
    private let defaultWeight: UInt8 = 0x50    // 80 kg
    private let defaultUserID: UInt64 = 58_965_456_623
    /// Heartbeat inner payload. Sent after every notification the device emits.
    private let heartbeatInner = Data([0x6A, 0x05, 0xFD, 0xF8, 0x43])

    private enum CommandType: UInt8 {
        case stop             = 0x00
        case pause            = 0x02
        case startOrSetSpeed  = 0x04
    }

    /// Acceleration ramp time (seconds). `start` ramps gently (1s), `setSpeed`
    /// ramps faster (5s) once already running. Mirrors the reference impl.
    private enum Ramp: UInt8 {
        case start   = 1
        case setSpeed = 5
    }

    // MARK: - Init

    init() {}

    // MARK: - Command Builders

    func buildStartCommand(speed: Double) -> Data {
        let inner = buildInner(rawSpeed: rawSpeed(speed),
                               ramp: .start,
                               cmd: .startOrSetSpeed)
        return wrap(inner)
    }

    func buildStopCommand() -> Data {
        let inner = buildInner(rawSpeed: 0, ramp: .start, cmd: .stop)
        return wrap(inner)
    }

    func buildPauseCommand() -> Data {
        let inner = buildInner(rawSpeed: 0, ramp: .start, cmd: .pause)
        return wrap(inner)
    }

    func buildSetSpeedCommand(speed: Double) -> Data {
        let inner = buildInner(rawSpeed: rawSpeed(speed),
                               ramp: .setSpeed,
                               cmd: .startOrSetSpeed)
        return wrap(inner)
    }

    // MARK: - Keep-Alive

    func onNotificationReceived() -> Data? {
        return wrap(heartbeatInner)
    }

    // MARK: - Notification Parser

    func parseNotification(_ data: Data) -> TreadmillStatus {
        var status = TreadmillStatus()
        guard data.count >= 31 else { return status }

        let bytes = [UInt8](data)

        // Accept either SOF variant we've seen in the wild.
        guard bytes[0] == 0x66 || bytes[0] == 0x68 else { return status }

        // Length sanity (byte [1] should equal the frame size).
        let framed = Int(bytes[1])
        guard framed == data.count else { return status }

        // XOR checksum: payload[1] XOR payload[2..count-3], compared to payload[count-2].
        var cs: UInt8 = bytes[1]
        for i in 2..<(data.count - 2) { cs ^= bytes[i] }
        guard cs == bytes[data.count - 2] else { return status }

        // Speed (0.001 km/h units).
        let curSpeedRaw = (UInt16(bytes[3]) << 8) | UInt16(bytes[4])
        status.speed = Double(curSpeedRaw) / 1000.0

        // Distance (0.001 km units = meters).
        let distRaw: UInt32 =
            (UInt32(bytes[7]) << 24) |
            (UInt32(bytes[8]) << 16) |
            (UInt32(bytes[9]) << 8)  |
            UInt32(bytes[10])
        status.distance = Double(distRaw) / 1000.0

        // Steps (32-bit big-endian).
        let stepsRaw: UInt32 =
            (UInt32(bytes[14]) << 24) |
            (UInt32(bytes[15]) << 16) |
            (UInt32(bytes[16]) << 8)  |
            UInt32(bytes[17])
        status.steps = Int(stepsRaw)

        // Calories (16-bit big-endian).
        let calRaw = (UInt16(bytes[18]) << 8) | UInt16(bytes[19])
        status.calories = Int(calRaw)

        // Duration — unit depends on firmware version at [25]:
        // fw > 19 → milliseconds; else → seconds.
        let durRaw: UInt32 =
            (UInt32(bytes[20]) << 24) |
            (UInt32(bytes[21]) << 16) |
            (UInt32(bytes[22]) << 8)  |
            UInt32(bytes[23])
        let firmwareVersion = bytes[25]
        status.duration = firmwareVersion > 19
            ? TimeInterval(durRaw) / 1000.0
            : TimeInterval(durRaw)

        // Running state: flags byte at [26] encodes state in bits 3-4 (0x18).
        // 0x08 means "running"; everything else (stopped, paused, finished) we
        // treat as not-running. Also fall back to speed>0 for robustness.
        let flags = bytes[26]
        let stateBits = flags & 0x18
        status.isRunning = (stateBits == 0x08) || status.speed > 0

        return status
    }

    // MARK: - Private Helpers

    /// Convert a km/h speed to the protocol's 0.001 km/h units.
    private func rawSpeed(_ speed: Double) -> UInt16 {
        let raw = Int((speed * 1000.0).rounded())
        return UInt16(clamping: max(0, raw))
    }

    /// Wrap an inner packet in the `4D 00 <counter> <len> …` envelope and
    /// advance the counter. All writes — commands and heartbeats — go through
    /// this so the counter stays monotonic per session.
    private func wrap(_ inner: Data) -> Data {
        var out = Data([0x4D, 0x00, counter, UInt8(inner.count)])
        out.append(inner)
        counter = counter &+ 1
        return out
    }

    /// Build the 23-byte inner command packet.
    private func buildInner(rawSpeed: UInt16,
                            ramp: Ramp,
                            cmd: CommandType,
                            incline: UInt8 = 0,
                            isKph: Bool = true) -> Data {
        var p = [UInt8](repeating: 0, count: 23)
        p[0] = startByte
        p[1] = innerLength
        // p[2..5] stay zero.
        p[6] = UInt8((rawSpeed >> 8) & 0xFF)
        p[7] = UInt8(rawSpeed & 0xFF)
        p[8] = ramp.rawValue
        p[9] = incline
        p[10] = defaultWeight
        p[11] = 0
        // Unit bit: kph clears 0x08, mph sets it.
        p[12] = isKph ? (cmd.rawValue & 0xF7) : (cmd.rawValue | 0x08)
        // 8-byte big-endian user ID.
        for i in 0..<8 {
            p[13 + i] = UInt8((defaultUserID >> UInt64(56 - i * 8)) & 0xFF)
        }
        // XOR checksum over bytes [1..20] inclusive.
        var cs: UInt8 = 0
        for i in 1...20 { cs ^= p[i] }
        p[21] = cs
        p[22] = endByte
        return Data(p)
    }
}
