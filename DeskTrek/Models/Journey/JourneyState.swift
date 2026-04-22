import Foundation

// MARK: - State types (mutable, JSON-persisted)

enum JourneyStatus: String, Codable {
    case active
    case completed
    case abandoned
}

struct JourneyState: Codable, Identifiable {
    let id: UUID
    let trailID: String
    var startedAt: Date
    var milesTraveled: Double
    var morale: Int                         // 0-100
    var energy: Int                         // 0-100
    var status: JourneyStatus
    var completedAt: Date?
    var targetCompletionDate: Date?
    var visitedLandmarkIDs: Set<String>
    var firedEncounterIDs: Set<String>
    var subquestProgress: [String: Int]     // subquestID -> next stage index (0 = not started, stages.count = complete)
    var choices: [JourneyChoice]
    var earnedBadgeIDs: Set<String>
    var baselineTreadmillKm: Double
    var lastSeenTreadmillKm: Double
    var isTrackingEnabled: Bool             // false = walk counts as free walk, not toward journey

    init(
        id: UUID = UUID(),
        trailID: String,
        startedAt: Date = Date(),
        milesTraveled: Double = 0,
        morale: Int = 75,
        energy: Int = 100,
        status: JourneyStatus = .active,
        completedAt: Date? = nil,
        targetCompletionDate: Date? = nil,
        baselineTreadmillKm: Double,
        lastSeenTreadmillKm: Double,
        isTrackingEnabled: Bool = true
    ) {
        self.id = id
        self.trailID = trailID
        self.startedAt = startedAt
        self.milesTraveled = milesTraveled
        self.morale = morale
        self.energy = energy
        self.status = status
        self.completedAt = completedAt
        self.targetCompletionDate = targetCompletionDate
        self.visitedLandmarkIDs = []
        self.firedEncounterIDs = []
        self.subquestProgress = [:]
        self.choices = []
        self.earnedBadgeIDs = []
        self.baselineTreadmillKm = baselineTreadmillKm
        self.lastSeenTreadmillKm = lastSeenTreadmillKm
        self.isTrackingEnabled = isTrackingEnabled
    }

    // Decode with default `true` so journeys saved before this field still load.
    enum CodingKeys: String, CodingKey {
        case id, trailID, startedAt, milesTraveled, morale, energy, status, completedAt, targetCompletionDate, visitedLandmarkIDs, firedEncounterIDs, subquestProgress, choices, earnedBadgeIDs, baselineTreadmillKm, lastSeenTreadmillKm, isTrackingEnabled
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id = try c.decode(UUID.self, forKey: .id)
        trailID = try c.decode(String.self, forKey: .trailID)
        startedAt = try c.decode(Date.self, forKey: .startedAt)
        milesTraveled = try c.decode(Double.self, forKey: .milesTraveled)
        morale = try c.decode(Int.self, forKey: .morale)
        energy = try c.decode(Int.self, forKey: .energy)
        status = try c.decode(JourneyStatus.self, forKey: .status)
        completedAt = try c.decodeIfPresent(Date.self, forKey: .completedAt)
        targetCompletionDate = try c.decodeIfPresent(Date.self, forKey: .targetCompletionDate)
        visitedLandmarkIDs = try c.decode(Set<String>.self, forKey: .visitedLandmarkIDs)
        firedEncounterIDs = try c.decode(Set<String>.self, forKey: .firedEncounterIDs)
        subquestProgress = try c.decode([String: Int].self, forKey: .subquestProgress)
        choices = try c.decode([JourneyChoice].self, forKey: .choices)
        earnedBadgeIDs = try c.decode(Set<String>.self, forKey: .earnedBadgeIDs)
        baselineTreadmillKm = try c.decode(Double.self, forKey: .baselineTreadmillKm)
        lastSeenTreadmillKm = try c.decode(Double.self, forKey: .lastSeenTreadmillKm)
        isTrackingEnabled = try c.decodeIfPresent(Bool.self, forKey: .isTrackingEnabled) ?? true
    }

    var progressPercentage: Double {
        guard let trail = TrailCatalog.trail(for: trailID) else { return 0 }
        return min(1.0, milesTraveled / trail.totalMiles)
    }

    var isOverdue: Bool {
        guard status == .active, let target = targetCompletionDate else { return false }
        return Date() > target
    }
}

struct JourneyChoice: Codable, Hashable {
    let encounterID: String
    let choiceID: String
    let decidedAt: Date
    let wasDefault: Bool
    let milesAtDecision: Double
}

/// A souvenir captured the first time the hiker crosses a landmark. Earned
/// automatically during a journey and displayed in the Trophy Wall alongside
/// completion certificates. Lifetime-scoped — deduped per (trail, landmark).
struct TrailPortrait: Codable, Identifiable, Hashable {
    let id: UUID
    let trailID: String
    let landmarkID: String
    let collectedAt: Date
    let journeyID: UUID

    init(
        id: UUID = UUID(),
        trailID: String,
        landmarkID: String,
        collectedAt: Date = Date(),
        journeyID: UUID
    ) {
        self.id = id
        self.trailID = trailID
        self.landmarkID = landmarkID
        self.collectedAt = collectedAt
        self.journeyID = journeyID
    }
}

struct Certificate: Codable, Identifiable {
    let id: UUID
    let trailID: String
    let journeyID: UUID
    let completedAt: Date
    let totalMiles: Double
    let totalDays: Int
    let finalMorale: Int
    let earnedBadgeIDs: [String]
    var pdfFileName: String?

    init(
        id: UUID = UUID(),
        trailID: String,
        journeyID: UUID,
        completedAt: Date,
        totalMiles: Double,
        totalDays: Int,
        finalMorale: Int,
        earnedBadgeIDs: [String],
        pdfFileName: String? = nil
    ) {
        self.id = id
        self.trailID = trailID
        self.journeyID = journeyID
        self.completedAt = completedAt
        self.totalMiles = totalMiles
        self.totalDays = totalDays
        self.finalMorale = finalMorale
        self.earnedBadgeIDs = earnedBadgeIDs
        self.pdfFileName = pdfFileName
    }
}
