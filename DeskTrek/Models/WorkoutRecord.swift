import Foundation

/// Physical-plausibility bounds used to sanitize treadmill readings and saved
/// workouts. A desk treadmill tops out well under 10 km/h; anything above that
/// is BLE noise, a replayed odometer, or a migration artifact.
enum WorkoutSanity {
    /// Upper bound on walking speed we'll trust. Values above this are clamped.
    static let maxPlausibleSpeedKmh: Double = 10.0
}

struct WorkoutRecord: Codable, Identifiable {
    let id: UUID
    let startDate: Date
    var endDate: Date
    var distance: Double       // km
    var steps: Int
    var calories: Int
    var duration: TimeInterval // seconds
    var averageSpeed: Double   // km/h
    var journeyID: UUID?       // optional: set if recorded during an active journey

    init(
        id: UUID = UUID(),
        startDate: Date,
        endDate: Date = Date(),
        distance: Double = 0,
        steps: Int = 0,
        calories: Int = 0,
        duration: TimeInterval = 0,
        averageSpeed: Double = 0,
        journeyID: UUID? = nil
    ) {
        self.id = id
        self.startDate = startDate
        self.endDate = endDate
        self.distance = distance
        self.steps = steps
        self.calories = calories
        self.duration = duration
        self.averageSpeed = averageSpeed
        self.journeyID = journeyID
    }

    var formattedDuration: String {
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        }
        return "\(minutes)m"
    }

    var formattedDistance: String {
        String(format: "%.2f km", distance)
    }

    func distanceInMiles() -> Double {
        distance / 1.60934
    }
}
