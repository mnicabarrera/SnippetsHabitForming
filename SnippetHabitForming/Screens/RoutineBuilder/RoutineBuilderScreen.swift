import SwiftUI

struct RoutineBuilderScreen: View {
    @Binding var route: AppRoute
    @State private var showsConfirmation = false
    private let days = [("M", "29"), ("T", "30"), ("W", "01"), ("T", "02"), ("F", "03"), ("S", "04"), ("S", "05")]

    var body: some View {
        FigmaScaledCanvas(background: .soft) {
            IconButton(systemName: "arrow.left", action: { route = .home })
                .position(x: 40, y: 52)
            IconButton(systemName: "checkmark", action: { showsConfirmation = true })
                .position(x: 825, y: 52)

            HStack(spacing: 3) {
                ForEach(days, id: \.1) { day in
                    DayColumn(day: day.0, number: day.1, highlighted: showsConfirmation && ["29", "01", "03"].contains(day.1))
                }
            }
            .position(x: 436, y: 92)

            VStack(alignment: .leading, spacing: 24) {
                Text("Daily Goal")
                    .figmaText(17, weight: .bold)
                    .padding(.top, 18)

                GoalChoice(title: "1 playful moment", selected: false)
                GoalChoice(title: "2 playful moment", selected: true)
                GoalChoice(title: "3 playful moment", selected: false)
            }
            .padding(.horizontal, 16)
            .frame(width: 434, height: 195, alignment: .topLeading)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(HabitDesign.paper)
                    .shadow(color: .black.opacity(0.20), radius: 4, x: 3, y: 5)
            )
            .position(x: 437, y: 248)

            if showsConfirmation {
                ConfirmationOverlay(route: $route)
            }
        }
    }
}

private struct DayColumn: View {
    let day: String
    let number: String
    let highlighted: Bool

    var body: some View {
        VStack(spacing: 16) {
            Text(day).figmaText(14)
            Text(number).figmaText(17, weight: .bold)
        }
        .frame(width: 60, height: 103)
        .background {
            if highlighted {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.black, lineWidth: 2)
            }
        }
    }
}

private struct GoalChoice: View {
    let title: String
    let selected: Bool

    var body: some View {
        HStack {
            Text(title)
                .figmaText(14)
            Spacer()
            Circle()
                .fill(selected ? Color.black : Color.clear)
                .overlay(Circle().stroke(.black, lineWidth: 1))
                .frame(width: 19, height: 19)
        }
        .padding(.leading, 22)
        .padding(.trailing, 6)
    }
}

private struct ConfirmationOverlay: View {
    @Binding var route: AppRoute

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black.opacity(0.55))
                .frame(width: HabitDesign.canvasSize.width, height: HabitDesign.canvasSize.height)
                .position(x: HabitDesign.canvasSize.width / 2, y: HabitDesign.canvasSize.height / 2)

            PaperCard(width: 226, height: 234, radius: 30) {
                VStack(spacing: 0) {
                    Image(systemName: "star")
                        .font(.system(size: 86, weight: .black))
                        .foregroundStyle(.black.opacity(0.82))
                        .shadow(color: .white.opacity(0.95), radius: 1, x: -2, y: -2)
                        .padding(.top, 24)

                    VStack(spacing: 0) {
                        Text("You’re all set")
                            .figmaText(23)
                        Text("Let’s play!")
                            .figmaText(34, weight: .bold)
                    }
                    .padding(.top, 14)

                    Button {
                        route = .home
                    } label: {
                        Text("Choose a Journal")
                            .figmaText(10, weight: .bold)
                            .underline()
                            .padding(.top, 28)
                    }
                    .buttonStyle(.plain)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .position(x: 437, y: 248)
        }
    }
}
