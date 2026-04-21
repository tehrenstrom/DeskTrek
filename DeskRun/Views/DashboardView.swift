import SwiftUI

struct DashboardView: View {
    @Bindable var state: TreadmillState
    let bleManager: TreadmillBLEManager

    var body: some View {
        VStack(spacing: 24) {
            // Speed display
            VStack(spacing: 4) {
                Text(state.formattedSpeed)
                    .font(.system(size: 72, weight: .bold, design: .rounded))
                    .monospacedDigit()
                Text("CURRENT SPEED")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            // Stats grid
            HStack(spacing: 40) {
                StatView(title: "Distance", value: state.formattedDistance, icon: "map")
                StatView(title: "Steps", value: "\(state.steps)", icon: "shoeprints.fill")
                StatView(title: "Time", value: state.formattedDuration, icon: "clock")
                StatView(title: "Calories", value: "\(state.calories) kcal", icon: "flame")
            }
            .padding()

            Divider()

            // Speed control
            VStack(spacing: 12) {
                Text("Target Speed: \(String(format: "%.1f", state.targetSpeed)) km/h")
                    .font(.headline)

                Slider(value: $state.targetSpeed, in: 0...6, step: 0.5) {
                    Text("Speed")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("6")
                }
                .frame(maxWidth: 400)

                // Quick speed buttons
                HStack(spacing: 12) {
                    ForEach([2.0, 3.0, 4.0, 5.0, 6.0], id: \.self) { speed in
                        Button("\(String(format: "%.0f", speed))") {
                            state.targetSpeed = speed
                            bleManager.setSpeed(speed)
                        }
                        .buttonStyle(.bordered)
                    }
                }
            }

            // Control buttons
            HStack(spacing: 16) {
                if state.isRunning {
                    Button("Pause") {
                        bleManager.pauseTreadmill()
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)

                    Button("Stop") {
                        bleManager.stopTreadmill()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    .controlSize(.large)
                } else {
                    Button("Start Walking") {
                        let speed = state.targetSpeed > 0 ? state.targetSpeed : 3.0
                        bleManager.startTreadmill(speed: speed)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .controlSize(.large)
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Dashboard")
    }
}

struct StatView: View {
    let title: String
    let value: String
    let icon: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.blue)
            Text(value)
                .font(.title3)
                .fontWeight(.semibold)
                .monospacedDigit()
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(minWidth: 80)
    }
}
