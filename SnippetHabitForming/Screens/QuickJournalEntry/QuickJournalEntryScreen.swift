import SwiftUI

struct QuickJournalEntryScreen: View {
    @Binding var route: AppRoute
    let mode: QuickJournalEntryMode
    @State private var showsStreakPopup = false
    @State private var openProgress: CGFloat = 0
    @State private var showsChallengePhotos = false

    var body: some View {
        FigmaScaledCanvas(background: .blue, backgroundImageName: "Background 3", backgroundIgnoresSafeArea: true) {
            IconButton(systemName: "house", action: { route = .home })
                .position(x: 50, y: 27)

            JournalBook(openProgress: openProgress, showsPhotos: showsChallengePhotos)
                .position(x: 442, y: 205)

            VStack(spacing: 7.5) {
                ToolButton("arrow.uturn.backward")
                ToolButton("arrow.uturn.forward")
                ToolButton("square.and.arrow.down", action: { showsStreakPopup = true })
                ToolButton("camera") {
                    if mode == .challengeEveryday {
                        withAnimation(.easeOut(duration: 0.25)) {
                            showsChallengePhotos = true
                        }
                    }
                }
                ToolButton("pencil")
                ToolButton("star")
            }
            .position(x: 816, y: 118)

        }
        .overlay {
            if showsStreakPopup {
                StreakCelebrationOverlay(route: $route)
            }
        }
        .onAppear {
            openProgress = 0
            showsChallengePhotos = false
            withAnimation(.easeOut(duration: 0.85)) {
                openProgress = 1
            }
        }
    }
}

private struct StreakCelebrationOverlay: View {
    @Binding var route: AppRoute

    var body: some View {
        GeometryReader { proxy in
            let scale = min(proxy.size.width / HabitDesign.canvasSize.width, proxy.size.height / HabitDesign.canvasSize.height)
            let popupX = proxy.size.width / 2 + (437 - HabitDesign.canvasSize.width / 2) * scale
            let popupY = proxy.size.height / 2 + (207 - HabitDesign.canvasSize.height / 2) * scale

            ZStack {
                Rectangle()
                .fill(.black.opacity(0.55))
                    .ignoresSafeArea()

                Button {
                    route = .weeklyRecapOverview
                } label: {
                    Image("PopUp Streak")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 226 * scale, height: 244 * scale)
                }
                .buttonStyle(.plain)
                .contentShape(Rectangle())
                .position(x: popupX, y: popupY)
                .accessibilityLabel("Overview")
            }
        }
    }
}

struct JournalBook: View {
    var openProgress: CGFloat = 1
    var showsPhotos = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(red: 0.67, green: 0.61, blue: 0.50))
                .shadow(color: .black.opacity(0.35), radius: 5, x: 4, y: 5)
                .frame(width: 448, height: 332)
                .scaleEffect(x: 0.40 + (0.60 * openProgress), anchor: .center)
                .opacity(0.28 + (0.72 * openProgress))

            ForEach(0..<7, id: \.self) { index in
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color(red: 0.73, green: 0.68, blue: 0.58).opacity(0.55), lineWidth: 1)
                    .frame(width: 444 - CGFloat(index) * 3, height: 328 - CGFloat(index) * 2)
                    .offset(x: 0, y: CGFloat(index) * 0.65)
            }
            .scaleEffect(x: 0.40 + (0.60 * openProgress), anchor: .center)
            .opacity(openProgress)

            HStack(spacing: 0) {
                PageView(side: .left)
                PageView(side: .right)
            }
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .frame(width: 430, height: 320)
            .scaleEffect(x: max(0.05, openProgress), anchor: .center)
            .opacity(Double(openProgress))

            if showsPhotos {
                Image("Polaroids")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 385, height: 294)
                    .scaleEffect(x: max(0.05, openProgress), anchor: .center)
                    .opacity(Double(openProgress))
                    .allowsHitTesting(false)
            }

            LinearGradient(
                colors: [.clear, .black.opacity(0.17), .clear],
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(width: 36, height: 320)
            .opacity(Double(openProgress))

            Rectangle()
                .fill(Color(red: 0.45, green: 0.39, blue: 0.31).opacity(0.45))
                .frame(width: 6, height: 321)
                .blur(radius: 0.8)
                .opacity(Double(openProgress))

            Rectangle()
                .fill(Color(red: 0.40, green: 0.30, blue: 0.20))
                .frame(width: 8, height: 17)
                .offset(x: 4, y: 176)
                .opacity(Double(openProgress))

            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 0.79, green: 0.88, blue: 0.87))
                .overlay(CoverFabricLines().opacity(0.28))
                .frame(width: 215, height: 320)
                .shadow(color: .black.opacity(0.32), radius: 5, x: 4, y: 5)
                .scaleEffect(x: 1 - openProgress, anchor: .leading)
                .rotation3DEffect(.degrees(Double(-82 * openProgress)), axis: (x: 0, y: 1, z: 0), anchor: .leading, perspective: 0.45)
                .offset(x: 108 * (1 - openProgress))
                .opacity(Double(1 - openProgress))
        }
    }
}

private enum PageSide {
    case left
    case right
}

private struct PageView: View {
    let side: PageSide

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: pageCornerRadius)
                .fill(Color(red: 0.92, green: 0.91, blue: 0.85))
                .overlay(PaperTexture().opacity(0.16))
                .overlay(DotGrid().opacity(0.18))
                .shadow(color: pageShadowColor, radius: 8, x: pageShadowX, y: 0)
        }
        .frame(width: 215, height: 320)
    }

    private var pageCornerRadius: CGFloat {
        side == .left ? 12 : 14
    }

    private var pageShadowColor: Color {
        side == .left ? .black.opacity(0.10) : .white.opacity(0.32)
    }

    private var pageShadowX: CGFloat {
        side == .left ? -6 : 6
    }
}

private struct DotGrid: View {
    var body: some View {
        Canvas { context, size in
            for x in stride(from: 18.0, through: Double(size.width - 18), by: 10) {
                for y in stride(from: 16.0, through: Double(size.height - 16), by: 10) {
                    context.fill(
                        Path(ellipseIn: CGRect(x: x, y: y, width: 1.2, height: 1.2)),
                        with: .color(Color.black.opacity(0.22))
                    )
                }
            }
        }
    }
}

private struct CoverFabricLines: View {
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

private struct ToolButton: View {
    let name: String
    let action: () -> Void

    init(_ name: String, action: @escaping () -> Void = {}) {
        self.name = name
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Image(systemName: name)
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.black)
                .frame(width: 32, height: 27)
        }
        .buttonStyle(.plain)
    }
}
