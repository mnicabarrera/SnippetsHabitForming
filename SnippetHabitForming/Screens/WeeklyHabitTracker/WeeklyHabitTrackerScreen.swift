import SwiftUI

struct WeeklyHabitTrackerScreen: View {
    @Binding var route: AppRoute

    var body: some View {
        FigmaScaledCanvas(background: .soft) {
            IconButton(systemName: "arrow.left", action: { route = .back })
                .position(x: 44, y: 36)
            IconButton(systemName: "house", action: { route = .home })
                .position(x: 834, y: 36)

            PaperCard(width: 353, height: 286, radius: 28) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("March 2026")
                        .figmaText(10, weight: .bold)
                        .padding(.top, 25)
                    Text("Habit Tracker")
                        .figmaText(17, weight: .bold)
                        .padding(.top, 4)

                    LazyVGrid(columns: Array(repeating: GridItem(.fixed(64), spacing: 17), count: 4), spacing: 52) {
                        HabitSquare(symbol: "sun.max.fill")
                        HabitSquare(symbol: "star.fill")
                        HabitSquare(symbol: "heart.fill")
                        HabitSquare(symbol: nil)
                        HabitSquare(symbol: nil)
                        HabitSquare(symbol: nil)
                        HabitSquare(symbol: nil)
                    }
                    .padding(.top, 27)
                }
                .padding(.leading, 25)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            .position(x: 244, y: 201)

            ProgressSticker()
                .position(x: 390, y: 318)

            ZStack {
                PaperCard(width: 168, height: 118, radius: 2, rotation: 6) {
                    Text("Weekly goal")
                        .figmaText(17, weight: .bold)
                        .position(x: 83, y: 28)
                    Text("Reconnect with\nmy inner child\nthrough 5 small\nmoments of play.")
                        .figmaText(10)
                        .multilineTextAlignment(.leading)
                        .position(x: 85, y: 74)
                }
                .position(x: 0, y: 0)
                Tape(color: Color(red: 0.82, green: 0.78, blue: 0.62), width: 75, height: 28, rotation: -22)
                    .position(x: -67, y: -51)
                Tape(color: Color(red: 0.82, green: 0.78, blue: 0.62), width: 75, height: 28, rotation: 25)
                    .position(x: -5, y: 75)

                LinedNote()
                    .position(x: 143, y: 37)
            }
            .position(x: 610, y: 147)

            PaperCard(width: 252, height: 65, radius: 2, rotation: -9) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Playful Insight")
                        .figmaText(17, weight: .bold)
                    Text("You seem to be most creative\non Wednesday mornings.")
                        .figmaText(12)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 18)
            }
            .position(x: 658, y: 300)
        }
    }
}

private struct HabitSquare: View {
    let symbol: String?

    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color(red: 0.98, green: 0.96, blue: 0.92))
            .frame(width: 64, height: 58)
            .shadow(color: .black.opacity(0.20), radius: 2, x: 2, y: 4)
            .overlay {
                if let symbol {
                    Image(systemName: symbol)
                        .font(.system(size: 39, weight: .black))
                        .foregroundStyle(.black)
                }
            }
    }
}

private struct ProgressSticker: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 0.88, green: 0.98, blue: 0.89))
                .overlay(GridTexture().opacity(0.8))
                .frame(width: 118, height: 86)
                .rotationEffect(.degrees(8))
                .shadow(color: .black.opacity(0.16), radius: 2, x: 2, y: 2)
            Text("Progress")
                .figmaText(16, weight: .bold)
                .rotationEffect(.degrees(8))
                .position(x: 61, y: 27)
            Text("40%")
                .figmaText(48)
                .rotationEffect(.degrees(8))
                .position(x: 61, y: 58)
        }
        .frame(width: 136, height: 96)
    }
}

private struct GridTexture: View {
    var body: some View {
        Canvas { context, size in
            for x in stride(from: 0, through: size.width, by: 11) {
                var path = Path()
                path.move(to: CGPoint(x: x, y: 0))
                path.addLine(to: CGPoint(x: x, y: size.height))
                context.stroke(path, with: .color(.green.opacity(0.45)), lineWidth: 0.8)
            }
            for y in stride(from: 0, through: size.height, by: 11) {
                var path = Path()
                path.move(to: CGPoint(x: 0, y: y))
                path.addLine(to: CGPoint(x: size.width, y: y))
                context.stroke(path, with: .color(.green.opacity(0.45)), lineWidth: 0.8)
            }
        }
    }
}

private struct LinedNote: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 0.78, green: 0.72, blue: 0.58))
            VStack(spacing: 10) {
                ForEach(0..<5) { _ in
                    Rectangle()
                        .fill(.black.opacity(0.22))
                        .frame(height: 1)
                }
            }
            Text("3 days of\nwild energy")
                .figmaText(15)
                .rotationEffect(.degrees(-9))
        }
        .frame(width: 124, height: 104)
        .rotationEffect(.degrees(-7))
        .shadow(color: .black.opacity(0.20), radius: 2, x: 2, y: 3)
        .overlay(Circle().fill(Color(red: 0.56, green: 0.34, blue: 0.22)).frame(width: 30, height: 30).offset(x: -4, y: -52))
    }
}
