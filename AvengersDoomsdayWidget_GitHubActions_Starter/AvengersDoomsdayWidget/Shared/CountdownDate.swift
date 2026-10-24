import Foundation

enum CountdownDate {
    /// Month is 1-based here for readability. Update this if the official release date changes.
    static let target: Date = {
        var components = DateComponents()
        components.year = 2026
        components.month = 12
        components.day = 18
        components.hour = 0
        components.minute = 0
        components.second = 0
        return Calendar.current.date(from: components) ?? Date()
    }()

    static func parts(from now: Date = .now) -> (days: Int, hours: Int, minutes: Int, seconds: Int) {
        let secondsRemaining = max(0, Int(target.timeIntervalSince(now)))
        return (
            secondsRemaining / 86_400,
            (secondsRemaining % 86_400) / 3_600,
            (secondsRemaining % 3_600) / 60,
            secondsRemaining % 60
        )
    }
}
