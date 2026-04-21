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

/// Seed Trail Portraits for landmarks visited before the portrait feature existed.
/// Runs once. Safe to re-run because `JourneyStore.addPortrait` dedupes by
/// `(trailID, landmarkID)`. Uses the journey's `startedAt` as the collected
/// timestamp — we don't know the exact pass-by moment, but "sometime during
/// the journey" is a reasonable anchor.
enum PortraitBackfillMigration {
    static func run(journeyStore: JourneyStore) {
        let allJourneys = ([journeyStore.active].compactMap { $0 } + journeyStore.history)
        var seeded = 0
        for journey in allJourneys {
            guard let trail = TrailCatalog.trail(for: journey.trailID) else { continue }
            for landmark in trail.landmarks where journey.visitedLandmarkIDs.contains(landmark.id) {
                let before = journeyStore.portraits.count
                journeyStore.addPortrait(TrailPortrait(
                    trailID: journey.trailID,
                    landmarkID: landmark.id,
                    collectedAt: journey.startedAt,
                    journeyID: journey.id
                ))
                if journeyStore.portraits.count > before { seeded += 1 }
            }
        }
        if seeded > 0 {
            print("🖼  Backfilled \(seeded) trail portrait(s) from already-visited landmarks")
        }
    }
}

enum JourneyWorkoutBackfillMigration {
    private static let distanceToleranceKm = 0.05

    static func run(workoutStore: WorkoutStore, journeyStore: JourneyStore) {
        let journeys = ([journeyStore.active].compactMap { $0 } + journeyStore.history)
            .filter { $0.isTrackingEnabled && $0.milesTraveled > 0 }

        guard !journeys.isEmpty else { return }

        var workouts = workoutStore.workouts
        let now = Date()
        var didChange = false

        for journey in journeys {
            let journeyDistanceKm = journey.milesTraveled * 1.60934
            let journeyEnd = journey.completedAt ?? now

            let relatedIndices = workouts.indices.filter { index in
                let workout = workouts[index]
                if workout.journeyID == journey.id {
                    return true
                }
                return workout.endDate >= journey.startedAt && workout.startDate <= journeyEnd
            }

            guard !relatedIndices.isEmpty else { continue }

            for index in relatedIndices where workouts[index].journeyID == nil {
                workouts[index].journeyID = journey.id
                didChange = true
            }

            let suspiciousIndices = relatedIndices.filter { index in
                let workout = workouts[index]
                return workout.distance > 0
                    && workout.duration == 0
                    && workout.averageSpeed == 0
                    && workout.steps == 0
                    && workout.calories == 0
            }

            guard !suspiciousIndices.isEmpty else { continue }

            let recordedDistanceKm = relatedIndices.reduce(0.0) { partial, index in
                partial + workouts[index].distance
            }
            let missingDistanceKm = journeyDistanceKm - recordedDistanceKm

            guard missingDistanceKm > distanceToleranceKm else { continue }

            if suspiciousIndices.count == 1 {
                let index = suspiciousIndices[0]
                workouts[index].distance += missingDistanceKm
                if workouts[index].duration > 0 {
                    workouts[index].averageSpeed = workouts[index].distance / (workouts[index].duration / 3600)
                }
                didChange = true
                print("🧰 Backfilled journey workout distance by \(String(format: "%.2f", missingDistanceKm)) km for journey \(journey.id)")
                continue
            }

            let anchorDate = suspiciousIndices
                .map { workouts[$0].endDate }
                .max() ?? journeyEnd
            let recoveredWorkout = WorkoutRecord(
                startDate: anchorDate,
                endDate: anchorDate,
                distance: missingDistanceKm,
                steps: 0,
                calories: 0,
                duration: 0,
                averageSpeed: 0,
                journeyID: journey.id
            )
            workouts.append(recoveredWorkout)
            didChange = true
            print("🧰 Added recovered workout with \(String(format: "%.2f", missingDistanceKm)) km for journey \(journey.id)")
        }

        guard didChange else { return }
        workoutStore.replaceWorkouts(workouts)
    }
}
