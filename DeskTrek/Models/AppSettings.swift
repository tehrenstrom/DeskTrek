import Foundation

struct AppSettings: Codable {
    private static let kilometersPerMile = 1.60934
    private static let defaultMilesPerHour = 2.0

    var defaultSpeed: Double = Self.defaultMilesPerHour * Self.kilometersPerMile  // km/h
    var useMetric: Bool = false             // true = km, false = miles
    var notificationsEnabled: Bool = true
    var morningMotivation: Bool = true
    var goalNudges: Bool = true
    var streakAlerts: Bool = true
    var milestoneAlerts: Bool = true
    var weeklySummary: Bool = true
    var idleNudges: Bool = true
    var quietHoursStart: Int = 22           // 10 PM
    var quietHoursEnd: Int = 8              // 8 AM
    var maxNotificationsPerDay: Int = 3
    var journeyMigrationCompleted: Bool = false
    var journeyWorkoutBackfillCompleted: Bool = false
    var portraitBackfillCompleted: Bool = false
    var workoutSpeedSanitizationCompleted: Bool = false

    // Convenience

    func distanceString(_ km: Double, decimals: Int = 1) -> String {
        "\(distanceValueString(km, decimals: decimals)) \(distanceUnitShort)"
    }

    func distanceString(miles: Double, decimals: Int = 1) -> String {
        "\(distanceValueString(miles: miles, decimals: decimals)) \(distanceUnitShort)"
    }

    func distanceValue(_ km: Double) -> Double {
        useMetric ? km : km / Self.kilometersPerMile
    }

    func distanceValue(miles: Double) -> Double {
        useMetric ? miles * Self.kilometersPerMile : miles
    }

    func distanceValueString(_ km: Double, decimals: Int = 1) -> String {
        formattedNumber(distanceValue(km), decimals: decimals)
    }

    func distanceValueString(miles: Double, decimals: Int = 1) -> String {
        formattedNumber(distanceValue(miles: miles), decimals: decimals)
    }

    var distanceUnitShort: String {
        useMetric ? "km" : "mi"
    }

    var distanceUnitLong: String {
        useMetric ? "Kilometers" : "Miles"
    }

    var speedUnitShort: String {
        useMetric ? "km/h" : "mph"
    }

    func speedValue(_ kmh: Double) -> Double {
        useMetric ? kmh : kmh / Self.kilometersPerMile
    }

    func speedValueString(_ kmh: Double, decimals: Int = 1) -> String {
        formattedNumber(speedValue(kmh), decimals: decimals)
    }

    func speedString(_ kmh: Double, decimals: Int = 1) -> String {
        "\(speedValueString(kmh, decimals: decimals)) \(speedUnitShort)"
    }

    func kilometersPerHour(fromDisplaySpeed displaySpeed: Double) -> Double {
        useMetric ? displaySpeed : displaySpeed * Self.kilometersPerMile
    }

    var speedPresets: [Double] {
        useMetric ? [2.0, 3.0, 4.0, 5.0] : [1.5, 2.0, 2.5, 3.0]
    }

    var speedIncrement: Double {
        0.5
    }

    var minimumControlSpeed: Double {
        0.5
    }

    var maximumControlSpeed: Double {
        useMetric ? 6.0 : 3.5
    }

    func speedPresetLabel(_ displaySpeed: Double) -> String {
        formattedNumber(displaySpeed, decimals: useMetric ? 0 : 1)
    }

    func isSelectedSpeedPreset(_ kmh: Double, displayPreset: Double) -> Bool {
        abs(kmh - kilometersPerHour(fromDisplaySpeed: displayPreset)) < 0.05
    }

    private func formattedNumber(_ value: Double, decimals: Int) -> String {
        String(format: "%.*f", decimals, value)
    }
}
