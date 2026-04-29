import SwiftUI

struct HomeScreen: View {
    @Binding var route: AppRoute

    var body: some View {
        FigmaScaledCanvas(background: .blue) {
            IconButton(systemName: "gearshape", action: { route = .reminderPreferences })
                .position(x: 42, y: 44)
            IconButton(systemName: "plus.circle", action: { route = .quickJournalEntry() })
                .position(x: 832, y: 46)

            Text("Snippets")
                .font(.system(size: 30, weight: .bold, design: .default))
                .foregroundStyle(.black)
                .position(x: 437, y: 46)

            IconButton(systemName: "chevron.left")
                .position(x: 70, y: 202)
            IconButton(systemName: "chevron.right", action: { route = .routineBuilder })
                .position(x: 805, y: 202)

            Button {
                route = .quickJournalEntry()
            } label: {
                NotebookView(
                    title: "Vacation\nJournal",
                    location: "Bogota, Colombia",
                    date: "Jan, 2026",
                    grid: "A4/GRID",
                    color: HabitDesign.mintBook,
                    width: 160,
                    height: 228
                )
            }
            .buttonStyle(.plain)
            .position(x: 213, y: 217)

            Button {
                route = .dailyCheckIn
            } label: {
                NotebookView(
                    title: "Everyday\nSnippets",
                    location: "Sydney, Australia",
                    date: "March, 2026",
                    grid: "A4/PLAIN",
                    color: HabitDesign.creamBook,
                    width: 164,
                    height: 228
                )
            }
            .buttonStyle(.plain)
            .position(x: 435, y: 217)

            Button {
                route = .quickJournalEntry()
            } label: {
                NotebookView(
                    title: "Diary &\nSketches",
                    location: "Sydney, Australia",
                    date: "March, 2026",
                    grid: "A4/DOTS",
                    color: HabitDesign.pinkBook,
                    width: 160,
                    height: 228
                )
            }
            .buttonStyle(.plain)
            .position(x: 657, y: 217)
        }
    }
}

private struct NotebookView: View {
    let title: String
    let location: String
    let date: String
    let grid: String
    let color: Color
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 3)
                .fill(color)
                .shadow(color: .black.opacity(0.25), radius: 4, x: 3, y: 4)
                .overlay(FabricLines().opacity(0.35))

            Rectangle()
                .fill(.black.opacity(0.1))
                .frame(width: 4)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(title)
                .figmaText(17, weight: .bold)
                .multilineTextAlignment(.leading)
                .position(x: width * 0.34, y: 58)

            Text(location)
                .figmaText(7)
                .position(x: width * 0.33, y: height - 24)

            Text(date)
                .figmaText(7)
                .rotationEffect(.degrees(-90))
                .position(x: width - 24, y: height - 58)

            Text(grid)
                .figmaText(7)
                .rotationEffect(.degrees(-90))
                .position(x: width - 21, y: 54)
        }
        .frame(width: width, height: height)
    }
}

private struct FabricLines: View {
    var body: some View {
        Canvas { context, size in
            for x in stride(from: 0, through: size.width, by: 4) {
                var path = Path()
                path.move(to: CGPoint(x: x, y: 0))
                path.addLine(to: CGPoint(x: x + 8, y: size.height))
                context.stroke(path, with: .color(.white.opacity(0.18)), lineWidth: 0.6)
            }
            for y in stride(from: 0, through: size.height, by: 5) {
                var path = Path()
                path.move(to: CGPoint(x: 0, y: y))
                path.addLine(to: CGPoint(x: size.width, y: y))
                context.stroke(path, with: .color(.black.opacity(0.05)), lineWidth: 0.5)
            }
        }
    }
}
