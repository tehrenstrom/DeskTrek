import Foundation
import Observation

@Observable
final class JourneyStore {
    private let dataManager: DataManager

    private(set) var active: JourneyState?
    private(set) var history: [JourneyState] = []
    private(set) var trophies: [Certificate] = []
    private(set) var lifetimeBadgeIDs: Set<String> = []
    private(set) var archivedGoals: [Goal] = []

    init(dataManager: DataManager) {
        self.dataManager = dataManager
        self.active = dataManager.loadActiveJourney()
        self.history = dataManager.loadJourneyHistory()
        self.trophies = dataManager.loadTrophies()
        self.lifetimeBadgeIDs = dataManager.loadLifetimeBadges()
        self.archivedGoals = dataManager.loadArchivedGoals()
    }

    // MARK: - Active journey

    func saveActive(_ state: JourneyState) {
        active = state
        dataManager.saveActiveJourney(state)
    }

    func clearActive() {
        active = nil
        dataManager.clearActiveJourney()
    }

    // MARK: - History

    func appendToHistory(_ state: JourneyState) {
        history.append(state)
        dataManager.saveJourneyHistory(history)
    }

    // MARK: - Trophies

    func appendTrophy(_ cert: Certificate) {
        trophies.append(cert)
        dataManager.saveTrophies(trophies)
    }

    // MARK: - Badges

    func addEarnedBadges(_ ids: Set<String>) {
        lifetimeBadgeIDs.formUnion(ids)
        dataManager.saveLifetimeBadges(lifetimeBadgeIDs)
    }

    // MARK: - Archived goals

    func appendArchivedGoals(_ goals: [Goal]) {
        archivedGoals.append(contentsOf: goals)
        dataManager.saveArchivedGoals(archivedGoals)
    }
}
