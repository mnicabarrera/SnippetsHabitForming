import SwiftUI

struct ContentView: View {
    @State private var route: AppRoute = .home

    var body: some View {
        ZStack {
            switch route {
            case .home:
                HomeScreen(route: $route)
            case .reminderPreferences:
                ReminderPreferencesScreen(route: $route)
            case .routineBuilder:
                RoutineBuilderScreen(route: $route)
            case .quickJournalEntry:
                QuickJournalEntryScreen(route: $route)
            case .streakPopup:
                StreakPopupScreen(route: $route)
            case .weeklyRecapOverview:
                WeeklyRecapOverviewScreen(route: $route)
            case .weeklyHabitTracker:
                WeeklyHabitTrackerScreen(route: $route)
            case .dailyCheckIn:
                DailyCheckInScreen(route: $route)
            case .challengeSelection:
                ChallengeSelectionScreen(route: $route)
            }
        }
        .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
