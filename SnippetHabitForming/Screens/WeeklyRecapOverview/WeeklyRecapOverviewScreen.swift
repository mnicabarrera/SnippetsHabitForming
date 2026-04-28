import SwiftUI

struct WeeklyRecapOverviewScreen: View {
    @Binding var route: AppRoute

    var body: some View {
        FigmaScaledCanvas(background: .soft) {
            IconButton(systemName: "arrow.left", action: { route = .quickJournalEntry })
                .position(x: 44, y: 36)
            IconButton(systemName: "house", action: { route = .home })
                .position(x: 830, y: 36)

            ZStack {
                PaperCard(width: 335, height: 275, radius: 12) {
                    Text("Your Playful Recap")
                        .figmaText(17, weight: .bold)
                        .position(x: 156, y: 37)
                    PhotoCollage()
                        .position(x: 178, y: 158)
                }
                Tape(width: 62, height: 28, rotation: -31)
                    .position(x: 20, y: 15)
                Tape(color: Color(red: 0.98, green: 0.69, blue: 0.45), width: 116, height: 42, rotation: -25)
                    .position(x: 281, y: 258)
            }
            .position(x: 258, y: 216)

            VStack(spacing: 13) {
                MetricPill(title: "Top Mood", value: "Wild & Playful")
                MetricPill(title: "Total Play", value: "45 minutes")
                MetricPill(title: "Moments", value: "12")
            }
            .position(x: 622, y: 151)

            Button {
                route = .weeklyHabitTracker
            } label: {
                HStack(spacing: 12) {
                    Text("Habit tracker")
                        .figmaText(17, weight: .bold)
                    Image(systemName: "arrow.right")
                        .font(.system(size: 23, weight: .bold))
                        .foregroundStyle(.black)
                }
                .frame(width: 220, height: 44)
            }
            .buttonStyle(.plain)
            .position(x: 706, y: 345)
        }
    }
}

private struct MetricPill: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .figmaText(17, weight: .bold)
            Spacer()
            Text(value)
                .figmaText(12)
        }
        .padding(.horizontal, 16)
        .frame(width: 345, height: 40)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(HabitDesign.paper)
                .shadow(color: .black.opacity(0.18), radius: 3, x: 2, y: 4)
        )
    }
}

private struct PhotoCollage: View {
    var body: some View {
        ZStack {
            PhotoTile(colors: [.blue, .cyan, .white], label: "SEA")
                .frame(width: 145, height: 98)
                .rotationEffect(.degrees(-4))
                .position(x: 98, y: 66)
            PhotoTile(colors: [.pink, .brown, .black], label: "DOG")
                .frame(width: 126, height: 92)
                .rotationEffect(.degrees(7))
                .position(x: 198, y: 75)
            PhotoTile(colors: [.purple, .orange, .black], label: "DUSK")
                .frame(width: 150, height: 94)
                .rotationEffect(.degrees(5))
                .position(x: 104, y: 151)
            PhotoTile(colors: [.blue, .orange, .yellow], label: "DINNER")
                .frame(width: 150, height: 98)
                .rotationEffect(.degrees(1))
                .position(x: 206, y: 157)
        }
        .frame(width: 285, height: 205)
    }
}
