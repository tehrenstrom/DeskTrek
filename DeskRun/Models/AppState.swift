import Foundation
import Observation

@Observable
class AppState {
    let treadmillState: TreadmillState
    let bleManager: TreadmillBLEManager
    let dataManager: DataManager
    let goalManager: GoalManager
    let workoutStore: WorkoutStore
    let statsCalculator: StatsCalculator
    let workoutRecorder: WorkoutRecorder
    let notificationManager: DeskRunNotificationManager
    let journeyStore: JourneyStore
    let journeyEngine: JourneyEngine
    let walkSession: WalkSession
    var settings: AppSettings

    init() {
        let treadmillState = TreadmillState()
        let dataManager = DataManager()
        var settings = dataManager.loadSettings()
        let workoutStore = WorkoutStore(dataManager: dataManager)
        let goalManager = GoalManager(dataManager: dataManager)
        let statsCalculator = StatsCalculator(workoutStore: workoutStore)
        let journeyStore = JourneyStore(dataManager: dataManager)
        let walkSession = WalkSession()
        let journeyEngine = JourneyEngine(treadmillState: treadmillState, store: journeyStore, walkSession: walkSession)

        // Register all known treadmill adapters before creating the BLE manager.
        // Add new adapters here as they are implemented.
        TreadmillAdapterRegistry.shared.register(PitPatAdapter.self)
        TreadmillAdapterRegistry.shared.register(KingSmithAdapter.self)
        TreadmillAdapterRegistry.shared.register(FTMSAdapter.self)
        TreadmillAdapterRegistry.shared.register(FitShowAdapter.self)

        self.treadmillState = treadmillState
        self.bleManager = TreadmillBLEManager(state: treadmillState)
        self.dataManager = dataManager
        self.workoutStore = workoutStore
        self.goalManager = goalManager
        self.statsCalculator = statsCalculator
        self.workoutRecorder = WorkoutRecorder(
            treadmillState: treadmillState,
            workoutStore: workoutStore,
            journeyStore: journeyStore,
            walkSession: walkSession
        )
        self.journeyStore = journeyStore
        self.journeyEngine = journeyEngine
        self.walkSession = walkSession
        self.notificationManager = DeskRunNotificationManager(
            workoutStore: workoutStore,
            goalManager: goalManager,
            statsCalculator: statsCalculator,
            settings: settings
        )

        // Give workout recorder access to goal manager for achievement sounds
        self.workoutRecorder.goalManager = goalManager
        self.workoutRecorder.settings = settings

        // One-time migration of legacy journey-preset goals.
        if !settings.journeyMigrationCompleted {
            LegacyJourneyMigration.run(goalManager: goalManager, journeyStore: journeyStore)
            settings.journeyMigrationCompleted = true
            dataManager.saveSettings(settings)
        }

        if !settings.journeyWorkoutBackfillCompleted {
            JourneyWorkoutBackfillMigration.run(workoutStore: workoutStore, journeyStore: journeyStore)
            settings.journeyWorkoutBackfillCompleted = true
            dataManager.saveSettings(settings)
        }

        if !settings.portraitBackfillCompleted {
            PortraitBackfillMigration.run(journeyStore: journeyStore)
            settings.portraitBackfillCompleted = true
            dataManager.saveSettings(settings)
        }

        if !settings.workoutSpeedSanitizationCompleted {
            WorkoutSpeedSanitizationMigration.run(workoutStore: workoutStore)
            settings.workoutSpeedSanitizationCompleted = true
            dataManager.saveSettings(settings)
        }
        self.settings = settings

        // Wire up auto-recording AND journey tick
        self.bleManager.onStateUpdate = { [weak workoutRecorder, weak journeyEngine] in
            workoutRecorder?.handleStateUpdate()
            journeyEngine?.handleTick()
        }

        // Request notification permission
        notificationManager.requestPermission()
    }

    func saveSettings() {
        dataManager.saveSettings(settings)
        notificationManager.updateSettings(settings)
    }
}
