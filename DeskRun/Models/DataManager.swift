import Foundation
import Observation

@Observable
class DataManager {
    private let fileManager = FileManager.default

    private var appSupportDir: URL {
        let dir = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
            .appendingPathComponent("DeskRun", isDirectory: true)
        try? fileManager.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir
    }

    private var goalsURL: URL { appSupportDir.appendingPathComponent("goals.json") }
    private var workoutsURL: URL { appSupportDir.appendingPathComponent("workouts.json") }
    private var settingsURL: URL { appSupportDir.appendingPathComponent("settings.json") }

    private var journeysDir: URL {
        let dir = appSupportDir.appendingPathComponent("journeys", isDirectory: true)
        try? fileManager.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir
    }
    private var activeJourneyURL: URL { journeysDir.appendingPathComponent("active.json") }
    private var journeyHistoryURL: URL { journeysDir.appendingPathComponent("history.json") }
    private var trophiesURL: URL { journeysDir.appendingPathComponent("trophies.json") }
    private var lifetimeBadgesURL: URL { journeysDir.appendingPathComponent("badges.json") }
    private var portraitsURL: URL { journeysDir.appendingPathComponent("portraits.json") }
    private var archivedGoalsURL: URL { journeysDir.appendingPathComponent("archive.json") }

    var certificatesDir: URL {
        let dir = appSupportDir.appendingPathComponent("certificates", isDirectory: true)
        try? fileManager.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir
    }

    private let encoder: JSONEncoder = {
        let e = JSONEncoder()
        e.dateEncodingStrategy = .iso8601
        e.outputFormatting = [.prettyPrinted, .sortedKeys]
        return e
    }()

    private let decoder: JSONDecoder = {
        let d = JSONDecoder()
        d.dateDecodingStrategy = .iso8601
        return d
    }()

    // MARK: - Goals

    func loadGoals() -> [Goal] {
        load(from: goalsURL) ?? []
    }

    func saveGoals(_ goals: [Goal]) {
        save(goals, to: goalsURL)
    }

    // MARK: - Workouts

    func loadWorkouts() -> [WorkoutRecord] {
        load(from: workoutsURL) ?? []
    }

    func saveWorkouts(_ workouts: [WorkoutRecord]) {
        save(workouts, to: workoutsURL)
    }

    // MARK: - Settings

    func loadSettings() -> AppSettings {
        load(from: settingsURL) ?? AppSettings()
    }

    func saveSettings(_ settings: AppSettings) {
        save(settings, to: settingsURL)
    }

    // MARK: - Journey

    func loadActiveJourney() -> JourneyState? {
        load(from: activeJourneyURL)
    }

    func saveActiveJourney(_ state: JourneyState) {
        save(state, to: activeJourneyURL)
    }

    func clearActiveJourney() {
        try? fileManager.removeItem(at: activeJourneyURL)
    }

    func loadJourneyHistory() -> [JourneyState] {
        load(from: journeyHistoryURL) ?? []
    }

    func saveJourneyHistory(_ states: [JourneyState]) {
        save(states, to: journeyHistoryURL)
    }

    func loadTrophies() -> [Certificate] {
        load(from: trophiesURL) ?? []
    }

    func saveTrophies(_ certs: [Certificate]) {
        save(certs, to: trophiesURL)
    }

    func loadLifetimeBadges() -> Set<String> {
        load(from: lifetimeBadgesURL) ?? []
    }

    func saveLifetimeBadges(_ badgeIDs: Set<String>) {
        save(badgeIDs, to: lifetimeBadgesURL)
    }

    func loadPortraits() -> [TrailPortrait] {
        load(from: portraitsURL) ?? []
    }

    func savePortraits(_ portraits: [TrailPortrait]) {
        save(portraits, to: portraitsURL)
    }

    func loadArchivedGoals() -> [Goal] {
        load(from: archivedGoalsURL) ?? []
    }

    func saveArchivedGoals(_ goals: [Goal]) {
        save(goals, to: archivedGoalsURL)
    }

    // MARK: - Generic

    private func load<T: Decodable>(from url: URL) -> T? {
        guard let data = try? Data(contentsOf: url) else { return nil }
        return try? decoder.decode(T.self, from: data)
    }

    private func save<T: Encodable>(_ value: T, to url: URL) {
        guard let data = try? encoder.encode(value) else { return }
        try? data.write(to: url, options: .atomic)
    }
}
