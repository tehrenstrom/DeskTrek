import SwiftUI

struct GoalsView: View {
    let appState: AppState
    @State private var showingAddGoal = false
    @State private var showingJourneyPicker = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                    // Header
                    HStack {
                        Text("PROVISIONS")
                            .font(.system(size: 18, weight: .bold, design: .monospaced))
                            .foregroundStyle(TrailColor.text)
                            .tracking(2)
                        Spacer()
                        Menu {
                            Button("New Daily Ration") { showingAddGoal = true }
                            Button("Chart a Journey") { showingJourneyPicker = true }
                        } label: {
                            Label("Supply Up", systemImage: "plus")
                                .font(.system(size: 12, weight: .bold, design: .monospaced))
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(TrailColor.coral)
                        .controlSize(.small)
                    }

                    // Active Goals
                    if appState.goalManager.activeGoals.isEmpty {
                        emptyState
                    } else {
                        ForEach(appState.goalManager.activeGoals) { goal in
                            RetroGoalCard(goal: goal, appState: appState)
                        }
                    }

                    // Inactive goals
                    let inactive = appState.goalManager.goals.filter { !$0.isActive }
                    if !inactive.isEmpty {
                        Text("ABANDONED TRAILS")
                            .font(.system(size: 13, weight: .bold, design: .monospaced))
                            .foregroundStyle(TrailColor.text.opacity(0.5))
                            .tracking(1)
                            .padding(.top, 8)

                        ForEach(inactive) { goal in
                            RetroGoalCard(goal: goal, appState: appState)
                                .opacity(0.6)
                        }
                    }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(TrailColor.parchment)
        .navigationTitle("Provisions")
        .sheet(isPresented: $showingAddGoal) {
            AddGoalSheet(appState: appState)
        }
        .sheet(isPresented: $showingJourneyPicker) {
            JourneyPickerSheet(appState: appState)
        }
    }

    @ViewBuilder
    private var emptyState: some View {
        VStack(spacing: 12) {
            Text("\u{1F3AF}")
                .font(.system(size: 36))
            Text("No provisions packed")
                .font(.system(size: 14, weight: .bold, design: .monospaced))
                .foregroundStyle(TrailColor.text.opacity(0.6))
            Text("Set a daily ration or chart a journey to track your progress on the trail.")
                .font(.system(size: 11, weight: .regular, design: .monospaced))
                .foregroundStyle(TrailColor.text.opacity(0.4))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }
}

// MARK: - Retro Goal Card

struct RetroGoalCard: View {
    let goal: Goal
    let appState: AppState

    private var progress: GoalProgress {
        let workouts = goal.timeframe == .custom
            ? appState.workoutStore.workouts
            : appState.workoutStore.todaysWorkouts
        return appState.goalManager.progress(for: goal, workouts: workouts, settings: appState.settings)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(goal.name)
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                        .foregroundStyle(TrailColor.text)
                    Text("\(goal.timeframe.displayName) \u{00B7} \(goal.type.rawValue.capitalized)")
                        .font(.system(size: 10, weight: .regular, design: .monospaced))
                        .foregroundStyle(TrailColor.text.opacity(0.5))
                }
                Spacer()
                Text("\(progress.percentageInt)%")
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .foregroundStyle(progress.percentage >= 1.0 ? TrailColor.forestGreen : TrailColor.text)
            }

            RetroProgressBar(
                progress: progress.percentage,
                fillColor: progress.percentage >= 1.0 ? TrailColor.forestGreen : TrailColor.mountainBlue,
                height: 14
            )

            HStack {
                Text("\(progress.formattedCurrent) / \(progress.formattedTarget) \(goal.unit.symbol)")
                    .font(.system(size: 10, weight: .regular, design: .monospaced))
                    .foregroundStyle(TrailColor.text.opacity(0.5))
                Spacer()
                Button(goal.isActive ? "Rest" : "Resume") {
                    appState.goalManager.toggleGoal(id: goal.id)
                }
                .buttonStyle(RetroSecondaryButtonStyle())
                Button("Abandon") {
                    appState.goalManager.deleteGoal(id: goal.id)
                }
                .buttonStyle(RetroButtonStyle(tint: TrailColor.coral))
            }
        }
        .retroPanel()
    }
}

// MARK: - GoalCard compatibility wrapper

struct GoalCard: View {
    let goal: Goal
    let appState: AppState

    var body: some View {
        RetroGoalCard(goal: goal, appState: appState)
    }
}

// MARK: - Add Goal Sheet

struct AddGoalSheet: View {
    let appState: AppState
    @Environment(\.dismiss) private var dismiss

    @State private var name = "Daily Walking Ration"
    @State private var type: GoalType = .distance
    @State private var target: Double = 5.0
    @State private var timeframe: GoalTimeframe = .daily

    private var unit: GoalUnit {
        GoalUnit.defaultUnit(for: type, metric: appState.settings.useMetric)
    }

    var body: some View {
        ZStack {
            TrailColor.parchment.ignoresSafeArea()

            VStack(spacing: 20) {
                Text("NEW PROVISION")
                    .font(.system(size: 18, weight: .bold, design: .monospaced))
                    .foregroundStyle(TrailColor.text)
                    .tracking(2)

                Form {
                    TextField("Name", text: $name)

                    Picker("Type", selection: $type) {
                        ForEach(GoalType.allCases, id: \.self) { t in
                            Text(t.rawValue.capitalized).tag(t)
                        }
                    }

                    Picker("Timeframe", selection: $timeframe) {
                        ForEach(GoalTimeframe.allCases.filter { $0 != .custom }, id: \.self) { t in
                            Text(t.displayName).tag(t)
                        }
                    }

                    HStack {
                        Text("Target")
                        Spacer()
                        TextField("", value: $target, format: .number)
                            .frame(width: 80)
                            .textFieldStyle(.roundedBorder)
                        Text(unit.symbol)
                            .foregroundStyle(.secondary)
                    }
                }
                .formStyle(.grouped)

                HStack {
                    Button("Turn Back") { dismiss() }
                        .buttonStyle(RetroSecondaryButtonStyle())
                    Spacer()
                    Button("Pack It") {
                        let goal = Goal(
                            name: name,
                            type: type,
                            target: target,
                            unit: unit,
                            timeframe: timeframe
                        )
                        appState.goalManager.addGoal(goal)
                        dismiss()
                    }
                    .buttonStyle(RetroButtonStyle(tint: TrailColor.forestGreen))
                }
            }
            .padding()
        }
        .frame(width: 400, height: 350)
    }
}

// MARK: - Journey Picker

struct JourneyPickerSheet: View {
    let appState: AppState
    @Environment(\.dismiss) private var dismiss
    @State private var months: Int = 4

    var body: some View {
        ZStack {
            TrailColor.parchment.ignoresSafeArea()

            VStack(spacing: 16) {
                Text("CHART A JOURNEY")
                    .font(.system(size: 18, weight: .bold, design: .monospaced))
                    .foregroundStyle(TrailColor.text)
                    .tracking(2)

                Text("Pick a real-world trail to walk from your desk. Track your progress across the miles.")
                    .font(.system(size: 11, weight: .regular, design: .monospaced))
                    .foregroundStyle(TrailColor.text.opacity(0.6))
                    .multilineTextAlignment(.center)

                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(JourneyPreset.allPresets) { preset in
                            Button(action: {
                                let goal = appState.goalManager.createJourneyGoal(
                                    from: preset,
                                    useMetric: appState.settings.useMetric,
                                    months: months
                                )
                                appState.goalManager.addGoal(goal)
                                dismiss()
                            }) {
                                HStack {
                                    Text(preset.emoji)
                                        .font(.title2)
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(preset.name)
                                            .font(.system(size: 13, weight: .bold, design: .monospaced))
                                            .foregroundStyle(TrailColor.text)
                                        Text("\(String(format: "%.0f", preset.distanceMiles)) mi \u{00B7} \(preset.description)")
                                            .font(.system(size: 10, weight: .regular, design: .monospaced))
                                            .foregroundStyle(TrailColor.text.opacity(0.6))
                                    }
                                    Spacer()
                                    Text("\u{25B6}")
                                        .font(.system(size: 12, design: .monospaced))
                                        .foregroundStyle(TrailColor.text.opacity(0.4))
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .background(TrailColor.parchment.opacity(0.6))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 3)
                                        .strokeBorder(TrailColor.darkEarth.opacity(0.3), lineWidth: 1)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 3))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }

                HStack {
                    Text("Complete in")
                        .font(.system(size: 11, weight: .regular, design: .monospaced))
                        .foregroundStyle(TrailColor.text.opacity(0.7))
                    Picker("Months", selection: $months) {
                        ForEach([2, 3, 4, 6, 8, 12], id: \.self) { m in
                            Text("\(m) months").tag(m)
                        }
                    }
                    .frame(width: 120)
                }

                Button("Turn Back") { dismiss() }
                    .buttonStyle(RetroSecondaryButtonStyle())
            }
            .padding()
        }
        .frame(width: 420, height: 480)
    }
}
