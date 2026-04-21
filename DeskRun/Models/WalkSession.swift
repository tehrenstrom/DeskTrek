import Foundation
import Observation

/// Declares the intent of the current (or next-to-start) walk.
///
/// Surfaces call `markFreeWalk()` or `markJourneyWalk(id:)` when the user taps
/// Start on their walk card. `WorkoutRecorder` reads `journeyID` when stamping
/// a saved workout; `JourneyEngine` only accrues miles when `context == .journey`.
///
/// Default is `.freeWalk` so walks that start without UI intent — e.g. someone
/// hitting Start on the treadmill's own buttons — don't accidentally count
/// toward an active journey.
@Observable
final class WalkSession {
    enum Context {
        case freeWalk
        case journey
    }

    private(set) var context: Context = .freeWalk
    private(set) var journeyID: UUID? = nil

    func markFreeWalk() {
        context = .freeWalk
        journeyID = nil
    }

    func markJourneyWalk(id: UUID) {
        context = .journey
        journeyID = id
    }
}
