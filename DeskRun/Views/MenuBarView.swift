import SwiftUI

struct MenuBarView: View {
    @Bindable var state: TreadmillState
    let bleManager: TreadmillBLEManager

    var body: some View {
        VStack(spacing: 12) {
            // Connection status
            HStack {
                Circle()
                    .fill(state.connectionStatus == .connected ? .green : .gray)
                    .frame(width: 8, height: 8)
                Text(state.connectionStatus.rawValue)
                    .font(.caption)
                Spacer()
            }

            if state.connectionStatus == .connected {
                Divider()

                // Speed
                HStack {
                    Text(state.formattedSpeed)
                        .font(.title2)
                        .fontWeight(.bold)
                        .monospacedDigit()
                    Spacer()
                    if state.isRunning {
                        Image(systemName: "figure.walk")
                            .foregroundStyle(.green)
                    }
                }

                // Stats
                HStack {
                    Label(state.formattedDistance, systemImage: "map")
                    Spacer()
                    Label("\(state.steps)", systemImage: "shoeprints.fill")
                    Spacer()
                    Label(state.formattedDuration, systemImage: "clock")
                }
                .font(.caption)

                Divider()

                // Quick controls
                HStack(spacing: 8) {
                    if state.isRunning {
                        Button("Pause") { bleManager.pauseTreadmill() }
                        Button("Stop") { bleManager.stopTreadmill() }
                            .tint(.red)
                    } else {
                        Button("Start") {
                            let speed = state.targetSpeed > 0 ? state.targetSpeed : 3.0
                            bleManager.startTreadmill(speed: speed)
                        }
                        .tint(.green)
                    }
                }
                .buttonStyle(.bordered)
                .controlSize(.small)

                // Speed adjustment
                HStack {
                    Button("-") {
                        let newSpeed = max(0.5, state.targetSpeed - 0.5)
                        state.targetSpeed = newSpeed
                        bleManager.setSpeed(newSpeed)
                    }
                    Text("\(String(format: "%.1f", state.targetSpeed)) km/h")
                        .font(.caption)
                        .monospacedDigit()
                        .frame(width: 70)
                    Button("+") {
                        let newSpeed = min(6.0, state.targetSpeed + 0.5)
                        state.targetSpeed = newSpeed
                        bleManager.setSpeed(newSpeed)
                    }
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
            } else {
                Button("Scan for Treadmill") {
                    bleManager.startScanning()
                }
                .buttonStyle(.bordered)
            }

            Divider()

            Button("Quit DeskRun") {
                NSApplication.shared.terminate(nil)
            }
        }
        .padding(12)
        .frame(width: 240)
    }
}
