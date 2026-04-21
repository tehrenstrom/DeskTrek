import Foundation

enum LegacyJourneyMigration {
    /// Move any legacy "journey preset" goals (AT, PCT, Camino, etc.) into the
    /// archive file. We do not auto-convert them into JourneyState — those goals
    /// are distance targets, not sessions, and silent conversion would misrepresent miles.
    static func run(goalManager: GoalManager, journeyStore: JourneyStore) {
        let matches = goalManager.goals.filter { goal in
            goal.timeframe == .custom && LegacyJourneyPresetNames.all.contains(goal.name)
        }
        guard !matches.isEmpty else { return }

        journeyStore.appendArchivedGoals(matches)
        for goal in matches {
            goalManager.deleteGoal(id: goal.id)
        }
    }
}
