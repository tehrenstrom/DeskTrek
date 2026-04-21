import Foundation

enum AppMode: String, Codable, CaseIterable {
    case freeWalk
    case journey

    var displayName: String {
        switch self {
        case .freeWalk: return "Free Walk"
        case .journey: return "Journeys"
        }
    }
}
