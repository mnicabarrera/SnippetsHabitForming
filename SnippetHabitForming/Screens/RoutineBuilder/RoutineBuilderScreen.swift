import SwiftUI

struct RoutineBuilderScreen: View {
    @Binding var route: AppRoute
    @State private var showsConfirmation = false
    @State private var selectedDates: Set<Date> = []
    @State private var selectedDailyGoal = 2

    private let calendar: Calendar = {
        var calendar = Calendar.current
        calendar.firstWeekday = 2
        return calendar
    }()

    private var weekDays: [RoutineDay] {
        guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: Date()) else {
            return []
        }

        return (0..<7).compactMap { offset in
            guard let date = calendar.date(byAdding: .day, value: offset, to: weekInterval.start) else {
                return nil
            }

            return RoutineDay(
                date: calendar.startOfDay(for: date),
                weekday: weekdayLetter(for: date),
                dayNumber: dayNumber(for: date)
            )
        }
    }

    var body: some View {
        FigmaScaledCanvas(background: .soft, backgroundImageName: "Background 2", backgroundIgnoresSafeArea: true) {
            IconButton(systemName: "arrow.left", action: { route = .back })
                .position(x: 40, y: 52)
            IconButton(systemName: "checkmark", action: { showsConfirmation = true })
                .position(x: 825, y: 52)

            HStack(spacing: 3) {
                ForEach(weekDays) { day in
                    DayColumn(
                        day: day.weekday,
                        number: day.dayNumber,
                        highlighted: selectedDates.contains(day.date)
                    ) {
                        toggleDate(day.date)
                    }
                }
            }
            .position(x: 436, y: 92)

            VStack(alignment: .leading, spacing: 24) {
                Text("Daily Goal")
                    .figmaText(17, weight: .bold)
                    .padding(.top, 18)

                ForEach(1...3, id: \.self) { goal in
                    GoalChoice(
                        title: "\(goal) playful moment",
                        selected: selectedDailyGoal == goal
                    ) {
                        selectedDailyGoal = goal
                    }
                }
            }
            .padding(.horizontal, 16)
            .frame(width: 434, height: 195, alignment: .topLeading)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(HabitDesign.paper)
                    .shadow(color: .black.opacity(0.20), radius: 4, x: 3, y: 5)
            )
            .position(x: 437, y: 248)

        }
        .overlay {
            if showsConfirmation {
                ConfirmationOverlay(route: $route)
            }
        }
    }

    private func toggleDate(_ date: Date) {
        if selectedDates.contains(date) {
            selectedDates.remove(date)
        } else {
            selectedDates.insert(date)
        }
    }

    private func weekdayLetter(for date: Date) -> String {
        let weekday = calendar.component(.weekday, from: date)
        return switch weekday {
        case 2: "M"
        case 3, 5: "T"
        case 4: "W"
        case 6: "F"
        case 7, 1: "S"
        default: ""
        }
    }

    private func dayNumber(for date: Date) -> String {
        let day = calendar.component(.day, from: date)
        return String(format: "%02d", day)
    }
}

private struct RoutineDay: Identifiable {
    let date: Date
    let weekday: String
    let dayNumber: String

    var id: Date { date }
}

private struct DayColumn: View {
    let day: String
    let number: String
    let highlighted: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 16) {
                Text(day).figmaText(14)
                Text(number).figmaText(17, weight: .bold)
            }
            .frame(width: 60, height: 103)
            .contentShape(RoundedRectangle(cornerRadius: 10))
            .background {
                if highlighted {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 2)
                }
            }
        }
        .buttonStyle(.plain)
    }
}

private struct GoalChoice: View {
    let title: String
    let selected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .figmaText(14)
                Spacer()
                Circle()
                    .fill(selected ? Color.black : Color.clear)
                    .overlay(Circle().stroke(.black, lineWidth: 1))
                    .frame(width: 19, height: 19)
            }
            .contentShape(Rectangle())
        }
        .padding(.leading, 22)
        .padding(.trailing, 6)
        .buttonStyle(.plain)
    }
}

private struct ConfirmationOverlay: View {
    @Binding var route: AppRoute

    var body: some View {
        GeometryReader { proxy in
            let scale = min(proxy.size.width / HabitDesign.canvasSize.width, proxy.size.height / HabitDesign.canvasSize.height)

            ZStack {
                Rectangle()
                    .fill(.black.opacity(0.55))
                    .ignoresSafeArea()

                Button {
                    route = .home
                } label: {
                    Image("PopUp")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 226 * scale, height: 244 * scale)
                }
                .buttonStyle(.plain)
                .contentShape(Rectangle())
                .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
                .accessibilityLabel("Choose a Journal")
            }
        }
    }
}
