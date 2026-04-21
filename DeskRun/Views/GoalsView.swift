import SwiftUI

struct GoalsView: View {
    let appState: AppState
    @State private var showingAddGoal = false

    private var modeFilteredGoals: [Goal] {
        appState.goalManager.goals.filter { $0.mode == .freeWalk }
    }

    private var activeGoals: [Goal] {
        modeFilteredGoals.filter { $0.isActive }
    }

    private var inactiveGoals: [Goal] {
        modeFilteredGoals.filter { !$0.isActive }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text("PROVISIONS")
                        .font(.system(size: 18, weight: .bold, design: .monospaced))
                        .foregroundStyle(TrailColor.text)
                        .tracking(2)
                    Spacer()
                    Button {
                        showingAddGoal = true
                    } label: {
                        Label("New Ration", systemImage: "plus")
                            .font(.system(size: 12, weight: .bold, design: .monospaced))
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(TrailColor.coral)
                    .controlSize(.small)
                }

                if activeGoals.isEmpty {
                    emptyState
                } else {
                    ForEach(activeGoals) { goal in
                        RetroGoalCard(goal: goal, appState: appState)
                    }
                }

                journeyNudgeCard

                if !inactiveGoals.isEmpty {
                    Text("ABANDONED TRAILS")
                        .font(.system(size: 13, weight: .bold, design: .monospaced))
                        .foregroundStyle(TrailColor.text.opacity(0.5))
                        .tracking(1)
                        .padding(.top, 8)

                    ForEach(inactiveGoals) { goal in
                        RetroGoalCard(goal: goal, appState: appState)
                            .opacity(0.6)
                    }
                }

                if !appState.journeyStore.archivedGoals.isEmpty {
                    archivedSection
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
    }

    @ViewBuilder
    private var emptyState: some View {
        VStack(spacing: 12) {
            Text("\u{1F3AF}")
                .font(.system(size: 36))
            Text("No provisions packed")
                .font(.system(size: 14, weight: .bold, design: .monospaced))
                .foregroundStyle(TrailColor.text.opacity(0.6))
            Text("Set a daily, weekly, or monthly ration to track your miles.")
                .font(.system(size: 11, weight: .regular, design: .monospaced))
                .foregroundStyle(TrailColor.text.opacity(0.4))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }

    private var journeyNudgeCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "mountain.2")
                    .font(.system(size: 22))
                    .foregroundStyle(TrailColor.coral)
                VStack(alignment: .leading, spacing: 2) {
                    Text("LOOKING FOR AN ADVENTURE?")
                        .font(.system(size: 12, weight: .bold, design: .monospaced))
                        .foregroundStyle(TrailColor.text)
                        .tracking(1)
                    Text("Try Journeys mode \u{2014} iconic trails with landmarks, encounters, and certificates.")
                        .font(.system(size: 11, design: .monospaced))
                        .foregroundStyle(TrailColor.text.opacity(0.7))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            HStack {
                Spacer()
                Button("Switch to Journeys") {
                    appState.settings.activeMode = .journey
                    appState.saveSettings()
                }
                .buttonStyle(RetroButtonStyle(tint: TrailColor.coral))
            }
        }
        .retroPanel()
    }

    private var archivedSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("ARCHIVED JOURNEY GOALS")
                .font(.system(size: 13, weight: .bold, design: .monospaced))
                .foregroundStyle(TrailColor.text.opacity(0.5))
                .tracking(1)
                .padding(.top, 8)

            Text("These long-distance goals moved when Journey Mode launched. They remain here for posterity.")
                .font(.system(size: 10, design: .monospaced))
                .foregroundStyle(TrailColor.text.opacity(0.5))

            ForEach(appState.journeyStore.archivedGoals) { goal in
                HStack {
                    Text(goal.name)
                        .font(.system(size: 12, weight: .medium, design: .monospaced))
                        .foregroundStyle(TrailColor.text.opacity(0.6))
                    Spacer()
                    Text("\(String(format: "%.0f", goal.target)) \(goal.unit.symbol)")
                        .font(.system(size: 10, design: .monospaced))
                        .foregroundStyle(TrailColor.text.opacity(0.5))
                }
                .padding(.vertical, 4)
            }
        }
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
                            timeframe: timeframe,
                            mode: .freeWalk
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
