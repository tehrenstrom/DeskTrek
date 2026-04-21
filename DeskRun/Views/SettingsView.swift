import SwiftUI

struct SettingsView: View {
    let appState: AppState

    var body: some View {
        Form {
                // Treadmill section
                Section {
                    HStack {
                        Text("Default Speed")
                            .font(.system(size: 13, weight: .medium, design: .monospaced))
                        Spacer()
                        TextField("", value: Binding(
                            get: { appState.settings.defaultSpeed },
                            set: { appState.settings.defaultSpeed = $0; appState.saveSettings() }
                        ), format: .number)
                        .frame(width: 60)
                        .textFieldStyle(.roundedBorder)
                        Text("km/h")
                            .font(.system(size: 11, design: .monospaced))
                            .foregroundStyle(.secondary)
                    }

                    Picker("Units", selection: Binding(
                        get: { appState.settings.useMetric },
                        set: { appState.settings.useMetric = $0; appState.saveSettings() }
                    )) {
                        Text("Kilometers").tag(true)
                        Text("Miles").tag(false)
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

                        HStack {
                            Text("Quiet Hours")
                                .font(.system(size: 12, design: .monospaced))
                            Spacer()
                            Picker("Start", selection: Binding(
                                get: { appState.settings.quietHoursStart },
                                set: { appState.settings.quietHoursStart = $0; appState.saveSettings() }
                            )) {
                                ForEach(0..<24, id: \.self) { hour in
                                    Text(formatHour(hour)).tag(hour)
                                }
                            }
                            .frame(width: 80)
                            Text("to")
                                .font(.system(size: 11, design: .monospaced))
                            Picker("End", selection: Binding(
                                get: { appState.settings.quietHoursEnd },
                                set: { appState.settings.quietHoursEnd = $0; appState.saveSettings() }
                            )) {
                                ForEach(0..<24, id: \.self) { hour in
                                    Text(formatHour(hour)).tag(hour)
                                }
                            }
                            .frame(width: 80)
                        }

                        HStack {
                            Text("Max dispatches per day")
                                .font(.system(size: 12, design: .monospaced))
                            Spacer()
                            Picker("", selection: Binding(
                                get: { appState.settings.maxNotificationsPerDay },
                                set: { appState.settings.maxNotificationsPerDay = $0; appState.saveSettings() }
                            )) {
                                ForEach([1, 2, 3, 4, 5], id: \.self) { n in
                                    Text("\(n)").tag(n)
                                }
                            }
                            .frame(width: 60)
                        }
                    }
                } header: {
                    Text("TRAIL DISPATCHES")
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
        .navigationTitle("Camp")
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
