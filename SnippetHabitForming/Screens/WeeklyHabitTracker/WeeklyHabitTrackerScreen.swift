import SwiftUI

struct WeeklyHabitTrackerScreen: View {
    @Binding var route: AppRoute
    @State private var habitSymbols: [String?] = [
        "sun.max.fill",
        "star.fill",
        "heart.fill",
        nil,
        nil,
        nil,
        nil
    ]

    private let extraHabitSymbols = [
        "face.smiling",
        "pawprint.fill",
        "sparkles",
        "moon.fill"
    ]

    var body: some View {
        FigmaScaledCanvas(background: .soft, backgroundImageName: "Background 2", backgroundIgnoresSafeArea: true) {
            Image("Weekly HT")
                .resizable()
                .scaledToFit()
                .frame(width: 760, height: 377)
                .position(x: 447, y: 204)
                .allowsHitTesting(false)

            IconButton(systemName: "arrow.left", action: { route = .back })
                .position(x: 44, y: 36)
            IconButton(systemName: "house", action: { route = .home })
                .position(x: 834, y: 36)

            VStack(alignment: .center, spacing: 0) {
                Spacer()
                    .frame(height: 88)
                LazyVGrid(columns: Array(repeating: GridItem(.fixed(64), spacing: 17), count: 4), spacing: 52) {
                    ForEach(habitSymbols.indices, id: \.self) { index in
                        HabitSquare(symbol: habitSymbols[index]) {
                            fillHabitSquare(at: index)
                        }
                    }
                }
                .frame(width: 307, alignment: .center)
            }
            .frame(width: 353, height: 286, alignment: .top)
            .position(x: 244, y: 201)
        }
    }

    private func fillHabitSquare(at index: Int) {
        guard habitSymbols[index] == nil else { return }

        let filledExtraCount = max(0, habitSymbols.compactMap { $0 }.count - 3)
        guard filledExtraCount < extraHabitSymbols.count else { return }

        habitSymbols[index] = extraHabitSymbols[filledExtraCount]
    }
}

private struct HabitSquare: View {
    let symbol: String?
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 0.98, green: 0.96, blue: 0.92))
                .frame(width: 64, height: 58)
                .shadow(color: .black.opacity(0.20), radius: 2, x: 2, y: 4)
                .overlay(alignment: .center) {
                    if let symbol {
                        Image(systemName: symbol)
                            .font(.system(size: 39, weight: .black))
                            .foregroundStyle(.black)
                            .frame(width: 64, height: 58, alignment: .center)
                    }
                }
        }
        .buttonStyle(.plain)
        .contentShape(RoundedRectangle(cornerRadius: 12))
    }
}

private struct ProgressSticker: View {
    var body: some View {
        Image("Progress")
            .resizable()
            .scaledToFit()
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
