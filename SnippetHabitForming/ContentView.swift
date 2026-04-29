import SwiftUI

struct ContentView: View {
    @State private var route: AppRoute = .home
    @State private var routeHistory: [AppRoute] = []

    var body: some View {
        ZStack {
            switch route {
            case .back:
                HomeScreen(route: navigationRoute)
            case .home:
                HomeScreen(route: navigationRoute)
            case .reminderPreferences:
                ReminderPreferencesScreen(route: navigationRoute)
            case .routineBuilder:
                RoutineBuilderScreen(route: navigationRoute)
            case .quickJournalEntry(let mode):
                QuickJournalEntryScreen(route: navigationRoute, mode: mode)
            case .streakPopup:
                StreakPopupScreen(route: navigationRoute)
            case .weeklyRecapOverview:
                WeeklyRecapOverviewScreen(route: navigationRoute)
            case .weeklyHabitTracker:
                WeeklyHabitTrackerScreen(route: navigationRoute)
            case .dailyCheckIn:
                DailyCheckInScreen(route: navigationRoute)
            case .challengeSelection:
                ChallengeSelectionScreen(route: navigationRoute)
            }
        }
        .preferredColorScheme(.light)
    }

    private var navigationRoute: Binding<AppRoute> {
        Binding {
            route
        } set: { nextRoute in
            if nextRoute == .back {
                route = routeHistory.popLast() ?? .home
                return
            }

            if nextRoute == .home {
                routeHistory.removeAll()
                route = .home
                return
            }

            if nextRoute != route {
                routeHistory.append(route)
                route = nextRoute
            }
        }
    }
}

#Preview {
    ContentView()
}
