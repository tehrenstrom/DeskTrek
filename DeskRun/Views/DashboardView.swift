import SwiftUI
import Charts

struct DashboardView: View {
    let appState: AppState
    @State private var selectedPeriod: StatsPeriod = .day
    @State private var chartDays: Int = 7

    private var stats: PeriodStats { appState.statsCalculator.stats(for: selectedPeriod) }

    private var trailMessage: String {
        let dailyGoal = appState.goalManager.activeGoals.first(where: { $0.timeframe == .daily })
        let dailyProgress: Double = {
            if let goal = dailyGoal {
                return appState.goalManager.progress(
                    for: goal,
                    workouts: appState.workoutStore.todaysWorkouts,
                    settings: appState.settings
                ).percentage
            }
            return 0
        }()

        let journey = appState.goalManager.activeGoals.first(where: { $0.timeframe == .custom })
        let journeyProg: Double? = journey.map {
            appState.goalManager.progress(for: $0, workouts: appState.workoutStore.workouts, settings: appState.settings).percentage
        }

        return TrailMessages.statusMessage(
            todayWorkoutCount: appState.workoutStore.todaysWorkouts.count,
            dailyGoalProgress: dailyProgress,
            currentStreak: appState.statsCalculator.currentStreak,
            activeJourney: journey,
            journeyProgress: journeyProg
        )
    }

    var body: some View {
        ZStack {
            RetroBackground()

            ScrollView {
                VStack(spacing: 16) {
                    // Trail banner
                    trailBanner
                        .padding(.horizontal)

                    // Trail status message
                    Text(trailMessage)
                        .font(.system(size: 12, weight: .medium, design: .monospaced))
                        .foregroundStyle(TrailColor.text.opacity(0.8))
                        .italic()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal)

                    // Trail Status panel (stats)
                    trailStatusPanel
                        .padding(.horizontal)

                    // Streak campfire
                    streakDisplay
                        .padding(.horizontal)

                    // Today's progress bar
                    todayGoalSection
                        .padding(.horizontal)

                    // Journey progress
                    journeyProgressSection
                        .padding(.horizontal)

                    // Period selector + stats cards
                    VStack(alignment: .leading, spacing: 12) {
                        Picker("Period", selection: $selectedPeriod) {
                            ForEach(StatsPeriod.allCases, id: \.self) { period in
                                Text(period.rawValue).tag(period)
                            }
                        }
                        .pickerStyle(.segmented)
                        .frame(maxWidth: 400)

                        statsCards
                    }
                    .padding(.horizontal)

                    // Chart
                    chartSection
                        .padding(.horizontal)

                    Spacer()
                }
                .padding(.vertical)
            }
        }
        .navigationTitle("Trail Status")
    }

    // MARK: - Trail Banner

    @ViewBuilder
    private var trailBanner: some View {
        VStack(spacing: 0) {
            // Earth-tone gradient "landscape"
            ZStack {
                LinearGradient(
                    colors: [TrailColor.sky.opacity(0.6), TrailColor.desertSand.opacity(0.4), TrailColor.forestGreen.opacity(0.3)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 4))

                Text("DESKRUN TRAIL CO.")
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .foregroundStyle(TrailColor.deepBrown)
                    .tracking(3)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .strokeBorder(TrailColor.darkEarth, lineWidth: 2)
        )
    }

    // MARK: - Trail Status Panel

    @ViewBuilder
    private var trailStatusPanel: some View {
        let todayStats = appState.statsCalculator.todayStats
        let useMetric = appState.settings.useMetric
        let distanceStr = appState.settings.distanceString(todayStats.distance)
        let speedStr: String = {
            let speed = todayStats.averageSpeed
            if useMetric {
                return String(format: "%.1f km/h", speed)
            } else {
                return String(format: "%.1f mph", speed / 1.60934)
            }
        }()

        VStack(spacing: 6) {
            RetroSectionHeader(title: "Trail Status")

            VStack(spacing: 4) {
                RetroStatRow(label: "Speed", value: speedStr)
                RetroStatRow(label: "Distance", value: distanceStr)
                RetroStatRow(label: "Time", value: todayStats.formattedDuration)
                RetroStatRow(label: "Calories", value: "\(todayStats.calories) kcal")
                RetroStatRow(label: "Steps", value: "\(todayStats.steps)")
            }
            .padding(.horizontal, 4)
        }
        .retroPanel()
    }

    // MARK: - Streak Display

    @ViewBuilder
    private var streakDisplay: some View {
        let current = appState.statsCalculator.currentStreak
        let best = appState.statsCalculator.bestStreak
        let message = TrailMessages.streakMessage(streak: current)

        HStack(spacing: 12) {
            // Campfire flames
            HStack(spacing: 2) {
                ForEach(0..<min(max(current, 1), 7), id: \.self) { _ in
                    Text("\u{1F525}")
                        .font(.system(size: 16))
                }
            }

            VStack(alignment: .leading, spacing: 2) {
                Text("\(current) day streak")
                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                    .foregroundStyle(TrailColor.text)
                Text(message)
                    .font(.system(size: 11, weight: .regular, design: .monospaced))
                    .foregroundStyle(TrailColor.text.opacity(0.7))
            }

            Spacer()

            if best > current {
                VStack(alignment: .trailing) {
                    Text("Best")
                        .font(.system(size: 10, weight: .regular, design: .monospaced))
                        .foregroundStyle(TrailColor.text.opacity(0.5))
                    Text("\(best)")
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .foregroundStyle(TrailColor.text.opacity(0.6))
                }
            }
        }
        .retroCard()
    }

    // MARK: - Today's Goal Section

    @ViewBuilder
    private var todayGoalSection: some View {
        let dailyGoal = appState.goalManager.activeGoals.first(where: { $0.timeframe == .daily })
        if let goal = dailyGoal {
            let prog = appState.goalManager.progress(
                for: goal,
                workouts: appState.workoutStore.todaysWorkouts,
                settings: appState.settings
            )

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("TODAY'S TRAIL")
                        .font(.system(size: 12, weight: .bold, design: .monospaced))
                        .foregroundStyle(TrailColor.text)
                        .tracking(1)
                    Spacer()
                    Text("\(prog.percentageInt)%")
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                        .foregroundStyle(prog.percentage >= 1.0 ? TrailColor.forestGreen : TrailColor.coral)
                }

                RetroProgressBar(
                    progress: prog.percentage,
                    fillColor: prog.percentage >= 1.0 ? TrailColor.forestGreen : TrailColor.coral
                )

                Text("\(prog.formattedCurrent) / \(prog.formattedTarget) \(goal.unit.symbol)")
                    .font(.system(size: 11, weight: .regular, design: .monospaced))
                    .foregroundStyle(TrailColor.text.opacity(0.6))
            }
            .retroCard()
        }
    }

    // MARK: - Journey Progress

    @ViewBuilder
    private var journeyProgressSection: some View {
        if let journey = appState.goalManager.activeGoals.first(where: { $0.timeframe == .custom }) {
            let prog = appState.goalManager.progress(
                for: journey,
                workouts: appState.workoutStore.workouts,
                settings: appState.settings
            )
            let journeyMsg = TrailMessages.journeyMessage(name: journey.name, progressPercent: prog.percentage)

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(journey.name.uppercased())
                        .font(.system(size: 12, weight: .bold, design: .monospaced))
                        .foregroundStyle(TrailColor.text)
                        .tracking(1)
                    Spacer()
                    Text("\(prog.formattedCurrent) / \(prog.formattedTarget) \(journey.unit.symbol)")
                        .font(.system(size: 11, weight: .regular, design: .monospaced))
                        .foregroundStyle(TrailColor.text.opacity(0.6))
                }

                RetroProgressBar(progress: prog.percentage, fillColor: TrailColor.desertSand)

                Text(journeyMsg)
                    .font(.system(size: 11, weight: .regular, design: .monospaced))
                    .foregroundStyle(TrailColor.text.opacity(0.7))
                    .italic()

                if let nudge = appState.goalManager.nudgeText(
                    for: journey,
                    workouts: appState.workoutStore.workouts,
                    settings: appState.settings
                ) {
                    Text(nudge)
                        .font(.system(size: 11, weight: .regular, design: .monospaced))
                        .foregroundStyle(TrailColor.text.opacity(0.5))
                }
            }
            .retroPanel()
        }
    }

    // MARK: - Stats Cards

    @ViewBuilder
    private var statsCards: some View {
        HStack(spacing: 12) {
            RetroStatCard(
                title: "Distance",
                value: appState.settings.distanceString(stats.distance),
                icon: "map",
                color: TrailColor.mountainBlue
            )
            RetroStatCard(
                title: "Time",
                value: stats.formattedDuration,
                icon: "clock",
                color: TrailColor.forestGreen
            )
            RetroStatCard(
                title: "Steps",
                value: "\(stats.steps)",
                icon: "shoeprints.fill",
                color: TrailColor.desertSand
            )
            RetroStatCard(
                title: "Calories",
                value: "\(stats.calories) kcal",
                icon: "flame",
                color: TrailColor.coral
            )
        }
    }

    // MARK: - Chart

    @ViewBuilder
    private var chartSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("TRAIL LOG")
                    .font(.system(size: 13, weight: .bold, design: .monospaced))
                    .foregroundStyle(TrailColor.text)
                    .tracking(1)
                Spacer()
                Picker("Days", selection: $chartDays) {
                    Text("7 days").tag(7)
                    Text("30 days").tag(30)
                }
                .pickerStyle(.segmented)
                .frame(width: 160)
            }

            let data = appState.statsCalculator.dailyDistances(last: chartDays)
            let useMetric = appState.settings.useMetric

            Chart(data) { item in
                BarMark(
                    x: .value("Date", item.date, unit: .day),
                    y: .value("Distance", useMetric ? item.distance : item.distance / 1.60934)
                )
                .foregroundStyle(
                    LinearGradient(
                        colors: [TrailColor.desertSand, TrailColor.coral],
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
                .cornerRadius(2)
            }
            .chartYAxisLabel(appState.settings.distanceUnitShort)
            .frame(height: 180)
        }
        .retroPanel()
    }
}

// MARK: - Retro StatCard

struct RetroStatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundStyle(color)
            Text(value)
                .font(.system(size: 14, weight: .bold, design: .monospaced))
                .monospacedDigit()
                .foregroundStyle(TrailColor.text)
            Text(title.uppercased())
                .font(.system(size: 9, weight: .medium, design: .monospaced))
                .foregroundStyle(TrailColor.text.opacity(0.6))
                .tracking(0.5)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(TrailColor.parchment.opacity(0.8))
        .overlay(
            RoundedRectangle(cornerRadius: 3)
                .strokeBorder(TrailColor.darkEarth.opacity(0.5), lineWidth: 1.5)
        )
        .clipShape(RoundedRectangle(cornerRadius: 3))
    }
}

// Keep the old StatCard name for MenuBarView compatibility
struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        RetroStatCard(title: title, value: value, icon: icon, color: color)
    }
}
