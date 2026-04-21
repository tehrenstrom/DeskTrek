import Foundation

struct TreadmillStatus {
    var speed: Double = 0.0
    var distance: Double = 0.0
    var steps: Int = 0
    var duration: TimeInterval = 0
    var calories: Int = 0
    var isRunning: Bool = false
}

enum PitPatProtocol {
    static let startByte: UInt8 = 0x6A
    static let packetLength = 23

    enum CommandType: UInt8 {
        case stop = 0x00
        case pause = 0x02
        case startOrSetSpeed = 0x04
    }

    // Byte offsets in notification data (approximate — adjust after testing with real hardware)
    enum NotificationOffsets {
        static let startByte = 0
        static let stateIndicator = 1
        static let speedHigh = 2
        static let speedLow = 3
        static let distanceStart = 4    // 4 bytes
        static let stepsHigh = 8
        static let stepsLow = 9
        static let durationHigh = 10
        static let durationLow = 11
        static let caloriesHigh = 12
        static let caloriesLow = 13
    }

    static func buildStartCommand(speed: Double) -> Data {
        var packet = [UInt8](repeating: 0, count: packetLength)
        packet[0] = startByte
        packet[1] = CommandType.startOrSetSpeed.rawValue

        let speedValue = UInt16(speed * 10)
        packet[2] = UInt8(speedValue >> 8)
        packet[3] = UInt8(speedValue & 0xFF)

        // XOR checksum
        var checksum: UInt8 = 0
        for i in 0..<(packetLength - 1) {
            checksum ^= packet[i]
        }
        packet[packetLength - 1] = checksum

        return Data(packet)
    }

    static func buildStopCommand() -> Data {
        var packet = [UInt8](repeating: 0, count: packetLength)
        packet[0] = startByte
        packet[1] = CommandType.stop.rawValue

        var checksum: UInt8 = 0
        for i in 0..<(packetLength - 1) {
            checksum ^= packet[i]
        }
        packet[packetLength - 1] = checksum

        return Data(packet)
    }

    static func buildPauseCommand() -> Data {
        var packet = [UInt8](repeating: 0, count: packetLength)
        packet[0] = startByte
        packet[1] = CommandType.pause.rawValue

        var checksum: UInt8 = 0
        for i in 0..<(packetLength - 1) {
            checksum ^= packet[i]
        }
        packet[packetLength - 1] = checksum

        return Data(packet)
    }

    static func parseNotification(_ data: Data) -> TreadmillStatus {
        var status = TreadmillStatus()
        guard data.count >= 14 else { return status }

        let bytes = [UInt8](data)

        // Verify start byte
        guard bytes[NotificationOffsets.startByte] == startByte else { return status }

        // Speed (divide by 10 for km/h)
        let rawSpeed = (UInt16(bytes[NotificationOffsets.speedHigh]) << 8) | UInt16(bytes[NotificationOffsets.speedLow])
        status.speed = Double(rawSpeed) / 10.0

        // Distance (4 bytes, interpretation may need adjustment)
        var rawDistance: UInt32 = 0
        for i in 0..<4 {
            rawDistance = (rawDistance << 8) | UInt32(bytes[NotificationOffsets.distanceStart + i])
        }
        status.distance = Double(rawDistance) / 100.0  // Assuming centimeters to km

        // Steps
        let rawSteps = (UInt16(bytes[NotificationOffsets.stepsHigh]) << 8) | UInt16(bytes[NotificationOffsets.stepsLow])
        status.steps = Int(rawSteps)

        // Duration in seconds
        let rawDuration = (UInt16(bytes[NotificationOffsets.durationHigh]) << 8) | UInt16(bytes[NotificationOffsets.durationLow])
        status.duration = TimeInterval(rawDuration)

        // Calories
        let rawCalories = (UInt16(bytes[NotificationOffsets.caloriesHigh]) << 8) | UInt16(bytes[NotificationOffsets.caloriesLow])
        status.calories = Int(rawCalories)

        // Running state
        status.isRunning = status.speed > 0

        return status
    }
}
