import SwiftUI

struct ConnectionView: View {
    let state: TreadmillState
    @ObservedObject var bleManager: TreadmillBLEManager

    var body: some View {
        ZStack {
            RetroBackground()

            ScrollView {
                VStack(spacing: 20) {
                    // Outfitter banner
                    RetroSectionHeader(title: "Outfitter")

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
                        Button("Scout for Wagon") {
                            bleManager.startScanning()
                        }
                        .buttonStyle(RetroButtonStyle(tint: TrailColor.forestGreen))
                    } else if state.connectionStatus == .scanning {
                        VStack(spacing: 8) {
                            Text("Preparing your wagon...")
                                .font(.system(size: 12, weight: .medium, design: .monospaced))
                                .foregroundStyle(TrailColor.text.opacity(0.7))
                                .italic()
                            Button("Stop Scouting") {
                                bleManager.stopScanning()
                            }
                            .buttonStyle(RetroSecondaryButtonStyle())
                        }
                    } else if state.connectionStatus == .connected {
                        // Quick controls
                        VStack(spacing: 12) {
                            RetroDivider()
                            Text("TRAIL CONTROLS")
                                .font(.system(size: 12, weight: .bold, design: .monospaced))
                                .foregroundStyle(TrailColor.text)
                                .tracking(1)

                            if state.isRunning {
                                HStack(spacing: 12) {
                                    Button("Rest") {
                                        bleManager.pauseTreadmill()
                                    }
                                    .buttonStyle(RetroSecondaryButtonStyle())

                                    Button("Make Camp") {
                                        bleManager.stopTreadmill()
                                    }
                                    .buttonStyle(RetroButtonStyle(tint: TrailColor.coral))
                                }
                            } else {
                                Button("Set Out (3.0 km/h)") {
                                    bleManager.startTreadmill(speed: 3.0)
                                }
                                .buttonStyle(RetroButtonStyle(tint: TrailColor.forestGreen))
                            }

                            Text("Use Trail Status for full speed controls")
                                .font(.system(size: 10, weight: .regular, design: .monospaced))
                                .foregroundStyle(TrailColor.text.opacity(0.5))
                            RetroDivider()
                        }

                        Button("Unhitch Wagon") {
                            bleManager.disconnect()
                        }
                        .buttonStyle(RetroSecondaryButtonStyle())
                    }

                    // Discovered devices
                    if !bleManager.discoveredDevices.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("TRAIL ENCOUNTERS")
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
                                    Button("Hitch Up") {
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
                        Text("Looking for your wagon?")
                            .font(.system(size: 13, weight: .bold, design: .monospaced))
                            .foregroundStyle(TrailColor.text)
                        Text("Make sure your treadmill is powered on and not connected to the PitPat app on your phone.")
                            .font(.system(size: 11, weight: .regular, design: .monospaced))
                            .foregroundStyle(TrailColor.text.opacity(0.6))
                            .multilineTextAlignment(.center)
                    }
                    .retroCard()
                }
                .padding()
            }
        }
        .navigationTitle("Outfitter")
    }

    private var trailStatusText: String {
        switch state.connectionStatus {
        case .disconnected: return "No wagon in sight"
        case .scanning: return "Scouting the trail..."
        case .connecting: return "Hitching the wagon..."
        case .connected: return "Wagon hitched!"
        case .error: return "Lost on the trail"
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
