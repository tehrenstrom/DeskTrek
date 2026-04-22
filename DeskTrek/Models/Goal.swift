import Foundation

// MARK: - Goal Types

enum GoalType: String, Codable, CaseIterable {
    case distance
    case time
    case steps
}

enum GoalUnit: String, Codable, CaseIterable {
    case miles
    case km
    case minutes
    case hours
    case steps

    var symbol: String {
        switch self {
        case .miles: return "mi"
        case .km: return "km"
        case .minutes: return "min"
        case .hours: return "hr"
        case .steps: return "steps"
        }
    }

    static func defaultUnit(for type: GoalType, metric: Bool) -> GoalUnit {
        switch type {
        case .distance: return metric ? .km : .miles
        case .time: return .minutes
        case .steps: return .steps
        }
    }
}

enum GoalTimeframe: String, Codable, CaseIterable {
    case daily
    case weekly
    case monthly
    case yearly
    case custom  // journey goals

    var displayName: String {
        switch self {
        case .daily: return "Daily"
        case .weekly: return "Weekly"
        case .monthly: return "Monthly"
        case .yearly: return "Yearly"
        case .custom: return "Journey"
        }
    }
}

// MARK: - Goal

struct Goal: Codable, Identifiable {
    let id: UUID
    var name: String
    var type: GoalType
    var target: Double
    var unit: GoalUnit
    var timeframe: GoalTimeframe
    var startDate: Date
    var endDate: Date?
    var isActive: Bool

    init(
        id: UUID = UUID(),
        name: String,
        type: GoalType,
        target: Double,
        unit: GoalUnit,
        timeframe: GoalTimeframe,
        startDate: Date = Date(),
        endDate: Date? = nil,
        isActive: Bool = true
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.target = target
        self.unit = unit
        self.timeframe = timeframe
        self.startDate = startDate
        self.endDate = endDate
        self.isActive = isActive
    }
}

// MARK: - Legacy journey preset names (used only for one-time migration detection)

enum LegacyJourneyPresetNames {
    static let all: Set<String> = [
        "Camino de Santiago",
        "Appalachian Trail",
        "Pacific Crest Trail",
        "Walk Across America",
        "Around the World"
    ]
}
