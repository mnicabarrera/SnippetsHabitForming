import Foundation

enum AppRoute: Equatable {
    case back
    case home
    case reminderPreferences
    case routineBuilder
    case quickJournalEntry(QuickJournalEntryMode = .plain)
    case streakPopup
    case weeklyRecapOverview
    case weeklyHabitTracker
    case dailyCheckIn
    case challengeSelection
}

enum QuickJournalEntryMode: Equatable {
    case plain
    case challengeEveryday
}
