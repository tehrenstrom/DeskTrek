import Foundation

// MARK: - Content types (immutable, defined in code)

struct Trail: Identifiable, Hashable {
    let id: String
    let name: String
    let subtitle: String
    let totalMiles: Double
    let landmarks: [Landmark]
    let encounters: [EncounterEvent]
    let subquests: [Subquest]
    let badges: [Badge]
    let mapArt: TrailMapArt
    let finaleArt: String
    let certificateCopy: String
}

struct Landmark: Identifiable, Hashable {
    let id: String
    let name: String
    let flavorText: String
    let spriteAsset: String
    let mileMarker: Double
    let isMajor: Bool
}

struct EncounterEvent: Identifiable, Hashable {
    let id: String
    let triggerMile: Double
    let title: String
    let body: String
    let choices: [Choice]
    let defaultChoiceID: String
    let timeoutSeconds: TimeInterval
    let subquestID: String?

    static let defaultTimeout: TimeInterval = 20
}

struct Choice: Identifiable, Hashable, Codable {
    let id: String
    let label: String
    let moraleDelta: Int
    let energyDelta: Int
    let badgeAwarded: String?
    let followupEncounterID: String?
    let resultText: String
}

struct Subquest: Identifiable, Hashable {
    let id: String
    let title: String
    let description: String
    let stageEncounterIDs: [String]
    let completionBadgeID: String?
}

struct Badge: Identifiable, Hashable, Codable {
    let id: String
    let name: String
    let description: String
    let iconAsset: String
}

struct TrailMapArt: Hashable {
    let skyAsset: String
    let mountainAsset: String
    let hillAsset: String
    let groundAsset: String
}
