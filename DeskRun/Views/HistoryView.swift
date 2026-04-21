import SwiftUI

struct HistoryView: View {
    let appState: AppState

    private var groupedWorkouts: [(date: Date, workouts: [WorkoutRecord])] {
        appState.workoutStore.groupedByDay
    }

    var body: some View {
        ZStack {
            RetroBackground()

            Group {
                if groupedWorkouts.isEmpty {
                    emptyState
                } else {
                    List {
                        ForEach(groupedWorkouts, id: \.date) { group in
                            Section {
                                ForEach(group.workouts) { workout in
                                    TrailJournalRow(workout: workout, settings: appState.settings)
                                        .listRowBackground(TrailColor.parchment.opacity(0.5))
                                }
                                .onDelete { indexSet in
                                    for index in indexSet {
                                        appState.workoutStore.deleteWorkout(id: group.workouts[index].id)
                                    }
                                }
                            } header: {
                                HStack {
                                    Text(group.date, style: .date)
                                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                                        .foregroundStyle(TrailColor.text)
                                    Spacer()
                                    let dayTotal = group.workouts.reduce(0.0) { $0 + $1.distance }
                                    Text(appState.settings.distanceString(dayTotal))
                                        .font(.system(size: 11, weight: .medium, design: .monospaced))
                                        .foregroundStyle(TrailColor.text.opacity(0.6))
                                }
                            }
                        }
                    }
                    .listStyle(.inset(alternatesRowBackgrounds: true))
                    .scrollContentBackground(.hidden)
                }
            }
        }
        .navigationTitle("Trail Journal")
    }

    @ViewBuilder
    private var emptyState: some View {
        VStack(spacing: 12) {
            Text("\u{1F4D6}")
                .font(.system(size: 48))
            Text("The journal is empty")
                .font(.system(size: 15, weight: .bold, design: .monospaced))
                .foregroundStyle(TrailColor.text.opacity(0.6))
            Text("Your trail entries will appear here when your wagon is hitched and rolling.")
                .font(.system(size: 11, weight: .regular, design: .monospaced))
                .foregroundStyle(TrailColor.text.opacity(0.4))
                .multilineTextAlignment(.center)
                .frame(maxWidth: 300)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Trail Journal Row

struct TrailJournalRow: View {
    let workout: WorkoutRecord
    let settings: AppSettings

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(workout.startDate, style: .time)
                    .font(.system(size: 13, weight: .bold, design: .monospaced))
                    .foregroundStyle(TrailColor.text)
                Text(workout.formattedDuration)
                    .font(.system(size: 10, weight: .regular, design: .monospaced))
                    .foregroundStyle(TrailColor.text.opacity(0.5))
            }

            Spacer()

            HStack(spacing: 14) {
                journalStat(settings.distanceString(workout.distance), icon: "map")
                journalStat("\(workout.steps)", icon: "shoeprints.fill")
                journalStat(String(format: "%.1f km/h", workout.averageSpeed), icon: "speedometer")
                journalStat("\(workout.calories) kcal", icon: "flame")
            }
        }
        .padding(.vertical, 4)
    }

    private func journalStat(_ value: String, icon: String) -> some View {
        HStack(spacing: 3) {
            Image(systemName: icon)
                .font(.system(size: 10))
                .foregroundStyle(TrailColor.text.opacity(0.4))
                .frame(width: 14)
            Text(value)
                .font(.system(size: 11, weight: .medium, design: .monospaced))
                .foregroundStyle(TrailColor.text.opacity(0.7))
                .monospacedDigit()
        }
    }
}

// Keep WorkoutRow for MenuBarView compatibility
struct WorkoutRow: View {
    let workout: WorkoutRecord
    let settings: AppSettings

    var body: some View {
        TrailJournalRow(workout: workout, settings: settings)
    }
}
