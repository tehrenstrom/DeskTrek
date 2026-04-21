import SwiftUI

struct ConnectionView: View {
    let state: TreadmillState
    @ObservedObject var bleManager: TreadmillBLEManager
    let settings: AppSettings

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                    // Trailhead banner — the wink to trail metaphor lives in the title;
                    // the body copy stays plain and functional.
                    RetroSectionHeader(title: "Trailhead")

                    // Status
                    HStack(spacing: 8) {
                        Circle()
                            .fill(statusColor)
                            .frame(width: 10, height: 10)
                            .overlay(
                                Circle()
                                    .strokeBorder(TrailColor.darkEarth, lineWidth: 1)
                            )
                        Text(trailStatusText)
                            .font(.system(size: 14, weight: .bold, design: .monospaced))
                            .foregroundStyle(TrailColor.text)
                    }
                    .retroCard()

                    if let error = state.errorMessage {
                        Text(error)
                            .font(.system(size: 11, weight: .regular, design: .monospaced))
                            .foregroundStyle(TrailColor.coral)
                    }

                    // Scan / Controls
                    if state.connectionStatus == .disconnected || state.connectionStatus == .error {
                        Button("Find Treadmill") {
                            bleManager.startScanning()
                        }
                        .buttonStyle(RetroButtonStyle(tint: TrailColor.forestGreen))
                    } else if state.connectionStatus == .scanning {
                        VStack(spacing: 8) {
                            Text("Searching for treadmill...")
                                .font(.system(size: 12, weight: .medium, design: .monospaced))
                                .foregroundStyle(TrailColor.text.opacity(0.7))
                            Button("Stop Scanning") {
                                bleManager.stopScanning()
                            }
                            .buttonStyle(RetroSecondaryButtonStyle())
                        }
                    } else if state.connectionStatus == .connected {
                        // Quick controls
                        VStack(spacing: 12) {
                            RetroDivider()
                            Text("CONTROLS")
                                .font(.system(size: 12, weight: .bold, design: .monospaced))
                                .foregroundStyle(TrailColor.text)
                                .tracking(1)

                            if state.isRunning {
                                HStack(spacing: 12) {
                                    Button("Pause") {
                                        bleManager.pauseTreadmill()
                                    }
                                    .buttonStyle(RetroSecondaryButtonStyle())

                                    Button("Stop") {
                                        bleManager.stopTreadmill()
                                    }
                                    .buttonStyle(RetroButtonStyle(tint: TrailColor.coral))
                                }
                            } else {
                                Button("Start Walking (\(settings.speedString(settings.defaultSpeed)))") {
                                    bleManager.startTreadmill(speed: settings.defaultSpeed)
                                }
                                .buttonStyle(RetroButtonStyle(tint: TrailColor.forestGreen))
                            }

                            Text("Full speed controls on the Dashboard")
                                .font(.system(size: 10, weight: .regular, design: .monospaced))
                                .foregroundStyle(TrailColor.text.opacity(0.5))
                            RetroDivider()
                        }

                        Button("Disconnect") {
                            bleManager.disconnect()
                        }
                        .buttonStyle(RetroSecondaryButtonStyle())
                    }

                    // Discovered devices
                    if !bleManager.discoveredDevices.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("NEARBY TREADMILLS")
                                .font(.system(size: 12, weight: .bold, design: .monospaced))
                                .foregroundStyle(TrailColor.text)
                                .tracking(1)

                            ForEach(bleManager.discoveredDevices, id: \.peripheral.identifier) { device in
                                HStack {
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(device.name)
                                            .font(.system(size: 13, weight: .bold, design: .monospaced))
                                            .foregroundStyle(TrailColor.text)
                                        Text("\(device.brand) \u{00B7} Signal: \(device.rssi) dBm")
                                            .font(.system(size: 10, weight: .regular, design: .monospaced))
                                            .foregroundStyle(TrailColor.text.opacity(0.6))
                                    }
                                    Spacer()
                                    Button("Connect") {
                                        bleManager.connect(to: device.peripheral)
                                    }
                                    .buttonStyle(RetroButtonStyle(tint: TrailColor.mountainBlue))
                                }
                                .padding(.vertical, 4)
                            }
                        }
                        .retroPanel()
                    }

                    Spacer()

                    // Help text
                    VStack(spacing: 6) {
                        Text("Can't find your treadmill?")
                            .font(.system(size: 13, weight: .bold, design: .monospaced))
                            .foregroundStyle(TrailColor.text)
                        Text("Make sure it's powered on and not already paired with another app (e.g., PitPat on your phone).")
                            .font(.system(size: 11, weight: .regular, design: .monospaced))
                            .foregroundStyle(TrailColor.text.opacity(0.6))
                            .multilineTextAlignment(.center)
                    }
                    .retroCard()
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(TrailColor.parchment)
        .navigationTitle("Trailhead")
    }

    private var trailStatusText: String {
        switch state.connectionStatus {
        case .disconnected: return "Not connected"
        case .scanning: return "Searching for treadmill..."
        case .connecting: return "Connecting..."
        case .connected: return "Connected"
        case .error: return "Connection error"
        }
    }

    private var statusColor: Color {
        switch state.connectionStatus {
        case .disconnected: return TrailColor.desertSand
        case .scanning: return TrailColor.coral
        case .connecting: return TrailColor.desertSand
        case .connected: return TrailColor.forestGreen
        case .error: return TrailColor.coral
        }
    }
}
