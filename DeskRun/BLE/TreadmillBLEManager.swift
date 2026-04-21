import Foundation
import CoreBluetooth

class TreadmillBLEManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    private var centralManager: CBCentralManager\!
    private var peripheral: CBPeripheral?
    private var writeCharacteristic: CBCharacteristic?
    private var notifyCharacteristic: CBCharacteristic?

    private let state: TreadmillState

    private let serviceUUID = CBUUID(string: "FBA0")
    private let writeCharUUID = CBUUID(string: "FBA1")
    private let notifyCharUUID = CBUUID(string: "FBA2")

    var discoveredDevices: [(peripheral: CBPeripheral, name: String, rssi: Int)] = []

    init(state: TreadmillState) {
        self.state = state
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func startScanning() {
        guard centralManager.state == .poweredOn else {
            state.connectionStatus = .error
            state.errorMessage = "Bluetooth is not available"
            return
        }
        discoveredDevices = []
        state.connectionStatus = .scanning
        centralManager.scanForPeripherals(withServices: nil, allowDuplicates: false)

        // Stop scanning after 10 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { [weak self] in
            if self?.state.connectionStatus == .scanning {
                self?.stopScanning()
            }
        }
    }

    func stopScanning() {
        centralManager.stopScan()
        if state.connectionStatus == .scanning {
            state.connectionStatus = .disconnected
        }
    }

    func connect(to peripheral: CBPeripheral) {
        self.peripheral = peripheral
        peripheral.delegate = self
        state.connectionStatus = .connecting
        centralManager.connect(peripheral, options: nil)
    }

    func disconnect() {
        if let peripheral = peripheral {
            centralManager.cancelPeripheralConnection(peripheral)
        }
        state.connectionStatus = .disconnected
        state.isRunning = false
    }

    func startTreadmill(speed: Double) {
        guard let char = writeCharacteristic else { return }
        let data = PitPatProtocol.buildStartCommand(speed: speed)
        peripheral?.writeValue(data, for: char, type: .withResponse)
        state.targetSpeed = speed
    }

    func stopTreadmill() {
        guard let char = writeCharacteristic else { return }
        let data = PitPatProtocol.buildStopCommand()
        peripheral?.writeValue(data, for: char, type: .withResponse)
        state.targetSpeed = 0
    }

    func pauseTreadmill() {
        guard let char = writeCharacteristic else { return }
        let data = PitPatProtocol.buildPauseCommand()
        peripheral?.writeValue(data, for: char, type: .withResponse)
    }

    func setSpeed(_ speed: Double) {
        guard let char = writeCharacteristic else { return }
        let data = PitPatProtocol.buildStartCommand(speed: speed)
        peripheral?.writeValue(data, for: char, type: .withResponse)
        state.targetSpeed = speed
    }

    // MARK: - CBCentralManagerDelegate

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state \!= .poweredOn {
            state.connectionStatus = .error
            state.errorMessage = "Bluetooth is not powered on"
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        let name = peripheral.name ?? advertisementData[CBAdvertisementDataLocalNameKey] as? String ?? "Unknown"

        // Only show PitPat devices, but also show all for debugging
        if name.contains("PitPat") || name.contains("DeerRun") {
            if \!discoveredDevices.contains(where: { $0.peripheral.identifier == peripheral.identifier }) {
                discoveredDevices.append((peripheral: peripheral, name: name, rssi: RSSI.intValue))
            }
        }
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        state.connectionStatus = .connected
        peripheral.discoverServices([serviceUUID])
    }

    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        state.connectionStatus = .error
        state.errorMessage = error?.localizedDescription ?? "Failed to connect"
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        state.connectionStatus = .disconnected
        state.isRunning = false
        writeCharacteristic = nil
        notifyCharacteristic = nil
    }

    // MARK: - CBPeripheralDelegate

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
            if service.uuid == serviceUUID {
                peripheral.discoverCharacteristics([writeCharUUID, notifyCharUUID], for: service)
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        for characteristic in characteristics {
            if characteristic.uuid == writeCharUUID {
                writeCharacteristic = characteristic
            } else if characteristic.uuid == notifyCharUUID {
                notifyCharacteristic = characteristic
                peripheral.setNotifyValue(true, for: characteristic)
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard characteristic.uuid == notifyCharUUID, let data = characteristic.value else { return }
        let status = PitPatProtocol.parseNotification(data)

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.state.currentSpeed = status.speed
            self.state.distance = status.distance
            self.state.steps = status.steps
            self.state.duration = status.duration
            self.state.calories = status.calories
            self.state.isRunning = status.isRunning
        }
    }
}
