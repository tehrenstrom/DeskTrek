import Foundation

struct TrailMessages {

    // MARK: - Trail Status Message (main dashboard greeting)

    static func statusMessage(
        todayWorkoutCount: Int,
        dailyGoalProgress: Double,
        currentStreak: Int,
        activeJourney: Goal?,
        journeyProgress: Double?
    ) -> String {
        let hour = Calendar.current.component(.hour, from: Date())

        // Goal achieved
        if dailyGoalProgress >= 1.0 {
            return "You have reached your destination! Rest well, traveler."
        }

        // Morning, no walks
        if hour < 12 && todayWorkoutCount == 0 {
            if currentStreak > 0 {
                return "The trail awaits, pioneer. Your \(currentStreak)-day streak depends on you."
            }
            return "The trail awaits, pioneer."
        }

        // Afternoon, no walks
        if hour >= 12 && hour < 18 && todayWorkoutCount == 0 {
            return "The sun is high. Best get moving before nightfall."
        }

        // Evening, no walks
        if hour >= 18 && todayWorkoutCount == 0 {
            if currentStreak > 0 {
                return "Night approaches. Walk now or lose your \(currentStreak)-day streak."
            }
            return "The campfire burns low. There is still time for a walk."
        }

        // Mid-goal progress
        if dailyGoalProgress > 0 && dailyGoalProgress < 1.0 {
            let pct = Int(dailyGoalProgress * 100)
            if pct < 25 {
                return "The trail stretches before you..."
            } else if pct < 50 {
                return "You've forded \(pct)% of today's river."
            } else if pct < 75 {
                return "More than halfway! The trading post is in sight."
            } else {
                return "Almost there! \(pct)% of the day's journey complete."
            }
        }

        // Journey behind pace
        if let journey = activeJourney, let prog = journeyProgress, prog < expectedJourneyProgress(journey) {
            return "Winter is coming. You may need to pick up the pace."
        }

        return "The trail continues. One step at a time."
    }

    // MARK: - Streak Messages

    static func streakMessage(streak: Int) -> String {
        switch streak {
        case 0:
            return "No streak yet. Start your journey today."
        case 1:
            return "1 day on the trail. Every journey starts here."
        case 2...4:
            return "\(streak) days on the trail. Your party grows stronger."
        case 5...9:
            return "\(streak) days on the trail. Your party's morale is high."
        case 10...29:
            return "\(streak) days on the trail. You are a seasoned traveler."
        case 30...99:
            return "\(streak) days on the trail. Legends speak of your endurance."
        default:
            return "\(streak) days on the trail. You have conquered the frontier."
        }
    }

    // MARK: - Journey Milestone Messages

    static let milestoneMessages: [String: String] = [
        "Camino de Santiago": "Buen Camino! The pilgrim's path unfolds before you.",
        "Appalachian Trail": "The green tunnel beckons. Watch for white blazes.",
        "Pacific Crest Trail": "You've set out from Campo. The Sierra awaits.",
        "Walk Across America": "Coast to coast — one step at a time.",
        "Around the World": "An epic undertaking. The world is your trail."
    ]

    static func journeyMessage(name: String, progressPercent: Double) -> String {
        let pct = Int(progressPercent * 100)

        if pct < 5 {
            return milestoneMessages[name] ?? "Your journey begins."
        } else if pct < 25 {
            return "The early miles test your resolve. Keep walking."
        } else if pct < 50 {
            return "Quarter of the way! The hardest part is behind you."
        } else if pct == 50 {
            return "Halfway point reached! Celebrate at the next outpost."
        } else if pct < 75 {
            return "The end is closer than the beginning now."
        } else if pct < 90 {
            return "The final stretch! Your destination is within reach."
        } else if pct < 100 {
            return "So close! Just a few more miles to glory."
        } else {
            return "Journey complete! You have reached the end of the trail."
        }
    }

    // MARK: - Goal Achieved Messages

    static let goalAchievedMessages: [String] = [
        "You have reached your destination!",
        "The wagon train celebrates!",
        "Well done, pioneer. You've earned your rest.",
        "Trail complete! Time to make camp.",
        "Your party has arrived safely.",
    ]

    static func randomGoalAchieved() -> String {
        goalAchievedMessages.randomElement() ?? goalAchievedMessages[0]
    }

    // MARK: - Private

    private static func expectedJourneyProgress(_ journey: Goal) -> Double {
        guard let endDate = journey.endDate else { return 0.5 }
        let totalDuration = endDate.timeIntervalSince(journey.startDate)
        guard totalDuration > 0 else { return 1.0 }
        let elapsed = Date().timeIntervalSince(journey.startDate)
        return max(0, min(elapsed / totalDuration, 1.0))
    }
}
