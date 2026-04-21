import Foundation
import Observation

@Observable
class WorkoutRecorder {
    private let treadmillState: TreadmillState
    private let workoutStore: WorkoutStore
    private let journeyStore: JourneyStore?
    private let walkSession: WalkSession?
    var goalManager: GoalManager?
    var settings: AppSettings?

    var isRecording: Bool = false
    var showSavedToast: Bool = false

    private var currentWorkoutStart: Date?
    private var lastNonZeroSpeed: Date?
    private var zeroSpeedTimer: Timer?
    private var sessionDistance: Double = 0
    private var sessionSteps: Int = 0
    private var sessionCalories: Int = 0
    private var sessionDuration: TimeInterval = 0
    private var lastObservedDistance: Double?
    private var lastObservedSteps: Int?
    private var lastObservedCalories: Int?
    private var lastObservedDuration: TimeInterval?

    private static let stopDelay: TimeInterval = 30  // seconds of zero speed before auto-stop
    private static let minimumActiveSpeed = 0.05

    init(
        treadmillState: TreadmillState,
        workoutStore: WorkoutStore,
        journeyStore: JourneyStore? = nil,
        walkSession: WalkSession? = nil
    ) {
        self.treadmillState = treadmillState
        self.workoutStore = workoutStore
        self.journeyStore = journeyStore
        self.walkSession = walkSession
    }

    /// Call this on every BLE state update
    func handleStateUpdate() {
        let sessionAdvanced = isRecording ? accumulateSessionMetrics() : false
        let hasActivitySignal = treadmillState.isRunning
            || treadmillState.currentSpeed > Self.minimumActiveSpeed
            || sessionAdvanced

        if hasActivitySignal {
            lastNonZeroSpeed = Date()
            zeroSpeedTimer?.invalidate()
            zeroSpeedTimer = nil

            if !isRecording {
                startRecording()
            }
        } else if isRecording {
            // Speed is zero while recording — start countdown
            if zeroSpeedTimer == nil {
                zeroSpeedTimer = Timer.scheduledTimer(withTimeInterval: Self.stopDelay, repeats: false) { [weak self] _ in
                    self?.stopRecording()
                }
            }
        }
    }

    func startRecording() {
        guard !isRecording else { return }
        isRecording = true
        currentWorkoutStart = Date()
        lastNonZeroSpeed = currentWorkoutStart
        sessionDistance = 0
        sessionSteps = 0
        sessionCalories = 0
        sessionDuration = 0
        lastObservedDistance = treadmillState.distance
        lastObservedSteps = treadmillState.steps
        lastObservedCalories = treadmillState.calories
        lastObservedDuration = treadmillState.duration
        SoundManager.shared.playWorkoutStarted()
        print("🏃 Workout recording started")
    }

    func stopRecording() {
        guard isRecording, let startDate = currentWorkoutStart else { return }

        _ = accumulateSessionMetrics()

        zeroSpeedTimer?.invalidate()
        zeroSpeedTimer = nil
        let endDate = lastNonZeroSpeed ?? Date()
        let fallbackDuration = max(0, endDate.timeIntervalSince(startDate))
        let recordedDuration = max(sessionDuration, fallbackDuration)

        let workout = WorkoutRecord(
            startDate: startDate,
            endDate: endDate,
            distance: sessionDistance,
            steps: sessionSteps,
            calories: sessionCalories,
            duration: recordedDuration,
            averageSpeed: recordedDuration > 0
                ? sessionDistance / (recordedDuration / 3600)
                : 0,
            journeyID: activeJourneyID
        )

        // Only save if meaningful (at least 1 minute or 0.01 km)
        if workout.duration >= 60 || workout.distance >= 0.01 {
            workoutStore.addWorkout(workout)
            SoundManager.shared.playWorkoutEnded()
            print("💾 Workout saved: \(workout.formattedDistance) in \(workout.formattedDuration)")

            // Check if daily goal was just hit
            if let gm = goalManager, let s = settings {
                gm.checkGoalAchievement(workouts: workoutStore.todaysWorkouts, settings: s)
            }

            // Show toast
            showSavedToast = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                self?.showSavedToast = false
            }
        }

        isRecording = false
        currentWorkoutStart = nil
        lastNonZeroSpeed = nil
        sessionDistance = 0
        sessionSteps = 0
        sessionCalories = 0
        sessionDuration = 0
        lastObservedDistance = nil
        lastObservedSteps = nil
        lastObservedCalories = nil
        lastObservedDuration = nil

        // Clear walk context so the next auto-start defaults to a free walk.
        walkSession?.markFreeWalk()
    }

    /// A workout is attributed to the active journey only when the walk was
    /// intentionally started as a journey walk (via `JourneyWalkCard`) AND that
    /// journey is still active. Free walks and device-initiated sessions fall
    /// through to `nil`.
    private var activeJourneyID: UUID? {
        guard
            let session = walkSession,
            session.context == .journey,
            let sessionJourneyID = session.journeyID,
            let active = journeyStore?.active,
            active.id == sessionJourneyID
        else {
            return nil
        }
        return active.id
    }

    @discardableResult
    private func accumulateSessionMetrics() -> Bool {
        var advanced = false

        if let lastObservedDistance {
            let distanceDelta = treadmillState.distance - lastObservedDistance
            if distanceDelta >= 0 {
                sessionDistance += distanceDelta
                advanced = advanced || distanceDelta > 0.0001
            }
        }
        lastObservedDistance = treadmillState.distance

        if let lastObservedSteps {
            let stepDelta = treadmillState.steps - lastObservedSteps
            if stepDelta >= 0 {
                sessionSteps += stepDelta
                advanced = advanced || stepDelta > 0
            }
        }
        lastObservedSteps = treadmillState.steps

        if let lastObservedCalories {
            let calorieDelta = treadmillState.calories - lastObservedCalories
            if calorieDelta >= 0 {
                sessionCalories += calorieDelta
                advanced = advanced || calorieDelta > 0
            }
        }
        lastObservedCalories = treadmillState.calories

        if let lastObservedDuration {
            let durationDelta = treadmillState.duration - lastObservedDuration
            if durationDelta >= 0 {
                sessionDuration += durationDelta
                advanced = advanced || durationDelta > 0
            }
        }
        lastObservedDuration = treadmillState.duration

        return advanced
    }
}
