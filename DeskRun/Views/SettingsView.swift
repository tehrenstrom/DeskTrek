import SwiftUI

struct SettingsView: View {
    let appState: AppState
    var onOpenTrail: (() -> Void)? = nil
    private let speedFormat = FloatingPointFormatStyle<Double>.number.precision(.fractionLength(1))

    @State private var showAbandonConfirm = false

    var body: some View {
        Form {
                // Treadmill section
                Section {
                    HStack {
                        Text("Default Speed")
                            .font(.system(size: 13, weight: .medium, design: .monospaced))
                        Spacer()
                        TextField("", value: Binding(
                            get: { appState.settings.speedValue(appState.settings.defaultSpeed) },
                            set: {
                                appState.settings.defaultSpeed = appState.settings.kilometersPerHour(fromDisplaySpeed: $0)
                                appState.saveSettings()
                            }
                        ), format: speedFormat)
                        .frame(width: 70)
                        .textFieldStyle(.roundedBorder)
                        Text(appState.settings.speedUnitShort)
                            .font(.system(size: 11, design: .monospaced))
                            .foregroundStyle(.secondary)
                    }

                    Picker("Display Units", selection: Binding(
                        get: { appState.settings.useMetric },
                        set: { appState.settings.useMetric = $0; appState.saveSettings() }
                    )) {
                        Text("Miles / MPH").tag(false)
                        Text("Kilometers / km/h").tag(true)
                    }

                    HStack {
                        Circle()
                            .fill(appState.treadmillState.connectionStatus == .connected ? TrailColor.forestGreen : TrailColor.desertSand)
                            .frame(width: 8, height: 8)
                        Text(appState.treadmillState.connectionStatus.rawValue)
                            .font(.system(size: 12, weight: .medium, design: .monospaced))
                    }
                } header: {
                    Text("WAGON SETTINGS")
                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                        .foregroundStyle(TrailColor.text)
                        .tracking(1)
                }

                // Notifications section
                Section {
                    Toggle("Trail Dispatches", isOn: Binding(
                        get: { appState.settings.notificationsEnabled },
                        set: { appState.settings.notificationsEnabled = $0; appState.saveSettings() }
                    ))

                    if appState.settings.notificationsEnabled {
                        Toggle("Morning Bugle", isOn: Binding(
                            get: { appState.settings.morningMotivation },
                            set: { appState.settings.morningMotivation = $0; appState.saveSettings() }
                        ))

                        Toggle("Trail Nudges", isOn: Binding(
                            get: { appState.settings.goalNudges },
                            set: { appState.settings.goalNudges = $0; appState.saveSettings() }
                        ))

                        Toggle("Streak Smoke Signals", isOn: Binding(
                            get: { appState.settings.streakAlerts },
                            set: { appState.settings.streakAlerts = $0; appState.saveSettings() }
                        ))

                        Toggle("Milestone Celebrations", isOn: Binding(
                            get: { appState.settings.milestoneAlerts },
                            set: { appState.settings.milestoneAlerts = $0; appState.saveSettings() }
                        ))

                        Toggle("Weekly Dispatch", isOn: Binding(
                            get: { appState.settings.weeklySummary },
                            set: { appState.settings.weeklySummary = $0; appState.saveSettings() }
                        ))

                        Toggle("Idle Camp Nudges", isOn: Binding(
                            get: { appState.settings.idleNudges },
                            set: { appState.settings.idleNudges = $0; appState.saveSettings() }
                        ))

                        HStack(spacing: 8) {
                            Text("Quiet Hours")
                                .font(.system(size: 12, design: .monospaced))
                            Spacer()
                            Picker("Quiet Hours Start", selection: Binding(
                                get: { appState.settings.quietHoursStart },
                                set: { appState.settings.quietHoursStart = $0; appState.saveSettings() }
                            )) {
                                ForEach(0..<24, id: \.self) { hour in
                                    Text(formatHour(hour)).tag(hour)
                                }
                            }
                            .labelsHidden()
                            .pickerStyle(.menu)
                            .frame(width: 96)
                            Text("to")
                                .font(.system(size: 11, design: .monospaced))
                                .foregroundStyle(.secondary)
                            Picker("Quiet Hours End", selection: Binding(
                                get: { appState.settings.quietHoursEnd },
                                set: { appState.settings.quietHoursEnd = $0; appState.saveSettings() }
                            )) {
                                ForEach(0..<24, id: \.self) { hour in
                                    Text(formatHour(hour)).tag(hour)
                                }
                            }
                            .labelsHidden()
                            .pickerStyle(.menu)
                            .frame(width: 96)
                        }

                        HStack {
                            Text("Max notifications per day")
                                .font(.system(size: 12, design: .monospaced))
                            Spacer()
                            Picker("Max notifications per day", selection: Binding(
                                get: { appState.settings.maxNotificationsPerDay },
                                set: { appState.settings.maxNotificationsPerDay = $0; appState.saveSettings() }
                            )) {
                                ForEach([1, 2, 3, 4, 5], id: \.self) { n in
                                    Text("\(n)").tag(n)
                                }
                            }
                            .labelsHidden()
                            .pickerStyle(.menu)
                            .frame(width: 72)
                        }
                    }
                } header: {
                    Text("TRAIL DISPATCHES")
                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                        .foregroundStyle(TrailColor.text)
                        .tracking(1)
                }

                // Adventure Mode section — active-journey lifecycle controls.
                Section {
                    adventureModeRows
                } header: {
                    Text("ADVENTURE MODE")
                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                        .foregroundStyle(TrailColor.text)
                        .tracking(1)
                }

                // About section
                Section {
                    HStack {
                        Text("DeskRun Trail Co.")
                            .font(.system(size: 13, weight: .medium, design: .monospaced))
                        Spacer()
                        Text("v1.0")
                            .font(.system(size: 11, design: .monospaced))
                            .foregroundStyle(.secondary)
                    }
                    HStack {
                        Text("Camp location")
                            .font(.system(size: 12, design: .monospaced))
                        Spacer()
                        Text("~/Library/Application Support/DeskRun/")
                            .font(.system(size: 10, design: .monospaced))
                            .foregroundStyle(.secondary)
                    }
                } header: {
                    Text("ABOUT THE TRAIL")
                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                        .foregroundStyle(TrailColor.text)
                        .tracking(1)
                }
        }
        .formStyle(.grouped)
        .scrollContentBackground(.hidden)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(TrailColor.parchment)
        .navigationTitle("Settings")
        .confirmationDialog(
            "Abandon this journey? Progress moves to history.",
            isPresented: $showAbandonConfirm
        ) {
            Button("Abandon", role: .destructive) {
                appState.journeyEngine.abandon()
            }
            Button("Keep hiking", role: .cancel) {}
        }
    }

    // MARK: - Adventure Mode rows

    @ViewBuilder
    private var adventureModeRows: some View {
        if let journey = appState.journeyStore.active,
           let trail = TrailCatalog.trail(for: journey.trailID) {
            let paused = !journey.isTrackingEnabled
            let progressPct = Int((journey.progressPercentage * 100).rounded())

            HStack {
                Text("Active Trail")
                    .font(.system(size: 12, design: .monospaced))
                Spacer()
                Text(trail.name.uppercased())
                    .font(.system(size: 12, weight: .bold, design: .monospaced))
                    .foregroundStyle(TrailColor.coral)
            }

            HStack {
                Text("Progress")
                    .font(.system(size: 12, design: .monospaced))
                Spacer()
                Text("\(progressPct)% · \(appState.settings.distanceValueString(miles: journey.milesTraveled)) / \(appState.settings.distanceValueString(miles: trail.totalMiles, decimals: 0)) \(appState.settings.distanceUnitShort)")
                    .font(.system(size: 11, weight: .medium, design: .monospaced))
                    .foregroundStyle(TrailColor.text.opacity(0.7))
            }

            HStack {
                Text("Status")
                    .font(.system(size: 12, design: .monospaced))
                Spacer()
                Text(paused ? "PAUSED" : "HIKING")
                    .font(.system(size: 11, weight: .bold, design: .monospaced))
                    .foregroundStyle(paused ? TrailColor.desertSand : TrailColor.forestGreen)
                    .tracking(1)
            }

            HStack(spacing: 10) {
                Button(paused ? "Resume Journey" : "Pause Journey") {
                    appState.journeyEngine.setTrackingEnabled(paused)
                }
                .buttonStyle(RetroSecondaryButtonStyle())

                Button("Abandon Journey") {
                    showAbandonConfirm = true
                }
                .buttonStyle(RetroButtonStyle(tint: TrailColor.coral))
            }
        } else {
            HStack {
                Text("No active trail.")
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundStyle(TrailColor.text.opacity(0.7))
                Spacer()
                if let onOpenTrail {
                    Button("Start a Journey") { onOpenTrail() }
                        .buttonStyle(RetroButtonStyle(tint: TrailColor.coral))
                }
            }
        }
    }

    private func formatHour(_ hour: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        var components = DateComponents()
        components.hour = hour
        let date = Calendar.current.date(from: components) ?? Date()
        return formatter.string(from: date)
    }
}
