import SwiftUI

struct QuickJournalEntryScreen: View {
    @Binding var route: AppRoute
    let mode: QuickJournalEntryMode
    @State private var showsStreakPopup = false
    @State private var openProgress: CGFloat = 0
    @State private var showsChallengePhotos = false

    var body: some View {
        FigmaScaledCanvas(background: .blue) {
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

                    Text("3 Days!")
                        .figmaText(31, weight: .bold)
                        .padding(.top, 8)

                    Text("Consistency Queen")
                        .figmaText(13)
                        .padding(.top, 3)

                    Button {
                        route = .weeklyRecapOverview
                    } label: {
                        Text("Overview")
                            .figmaText(8, weight: .bold)
                            .underline()
                            .padding(.top, 27)
                    }
                    .buttonStyle(.plain)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .position(x: 437, y: 220)
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
                PageView(side: .left, showsPhotos: showsPhotos)
                PageView(side: .right, showsPhotos: showsPhotos)
            }
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .frame(width: 430, height: 320)
            .scaleEffect(x: max(0.05, openProgress), anchor: .center)
            .opacity(Double(openProgress))

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
    let showsPhotos: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: pageCornerRadius)
                .fill(Color(red: 0.92, green: 0.91, blue: 0.85))
                .overlay(PaperTexture().opacity(0.16))
                .overlay(DotGrid().opacity(0.18))
                .shadow(color: pageShadowColor, radius: 8, x: pageShadowX, y: 0)

            if showsPhotos {
                if side == .left {
                    PhotoTile(kind: .lanterns)
                        .frame(width: 141, height: 118)
                        .position(x: 108, y: 78)
                    PhotoTile(kind: .dog)
                        .frame(width: 128, height: 151)
                        .rotationEffect(.degrees(1))
                        .position(x: 128, y: 229)
                } else {
                    PhotoTile(kind: .stage)
                        .frame(width: 117, height: 137)
                        .position(x: 123, y: 86)
                    PhotoTile(kind: .sky)
                        .frame(width: 151, height: 122)
                        .position(x: 95, y: 229)
                }
            }
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

struct PhotoTile: View {
    enum Kind {
        case lanterns
        case stage
        case dog
        case sky
        case custom([Color], String)
    }

    let kind: Kind

    init(kind: Kind) {
        self.kind = kind
    }

    init(colors: [Color], label: String = "") {
        self.kind = .custom(colors, label)
    }

    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size

            ZStack {
                Rectangle().fill(Color(red: 0.08, green: 0.015, blue: 0.01))

                PhotoImage(kind: kind)
                    .padding(12)

                FilmMarks()
                    .padding(4)
            }
            .shadow(color: .black.opacity(0.25), radius: 2, x: 2, y: 2)
            .overlay(alignment: .bottomLeading) {
                Text("KODAK PORTRA 400")
                    .font(.system(size: max(3.5, size.width * 0.035), weight: .bold, design: .monospaced))
                    .foregroundStyle(Color(red: 0.98, green: 0.75, blue: 0.52).opacity(0.75))
                    .rotationEffect(.degrees(-90))
                    .offset(x: 5, y: -14)
            }
        }
    }
}

private struct PhotoImage: View {
    let kind: PhotoTile.Kind

    var body: some View {
        Canvas { context, size in
            let rect = CGRect(origin: .zero, size: size)

            switch kind {
            case .lanterns:
                context.fill(Path(rect), with: .linearGradient(
                    Gradient(colors: [
                        Color(red: 0.04, green: 0.08, blue: 0.10),
                        Color(red: 0.95, green: 0.16, blue: 0.08),
                        Color(red: 0.02, green: 0.02, blue: 0.03)
                    ]),
                    startPoint: CGPoint(x: 0, y: 0),
                    endPoint: CGPoint(x: size.width, y: size.height)
                ))
                for index in 0..<22 {
                    let row = CGFloat(index % 4)
                    let column = CGFloat(index / 4)
                    let x = 13 + column * 19 + row * 7
                    let y = 11 + row * 17 + column * 4
                    let lantern = CGRect(x: x, y: y, width: 15, height: 17)
                    context.fill(Path(ellipseIn: lantern), with: .color(Color(red: 1, green: 0.29, blue: 0.12)))
                    context.stroke(Path(ellipseIn: lantern), with: .color(.yellow.opacity(0.32)), lineWidth: 1)
                }
                for index in 0..<5 {
                    var path = Path()
                    path.move(to: CGPoint(x: 0, y: 20 + CGFloat(index) * 13))
                    path.addLine(to: CGPoint(x: size.width, y: 8 + CGFloat(index) * 17))
                    context.stroke(path, with: .color(.white.opacity(0.28)), lineWidth: 1)
                }

            case .stage:
                context.fill(Path(rect), with: .linearGradient(
                    Gradient(colors: [
                        Color(red: 0.95, green: 0.06, blue: 0.03),
                        Color(red: 0.40, green: 0.02, blue: 0.02),
                        .black
                    ]),
                    startPoint: CGPoint(x: 0, y: 0),
                    endPoint: CGPoint(x: size.width, y: size.height)
                ))
                var beam = Path()
                beam.move(to: CGPoint(x: 18, y: 0))
                beam.addLine(to: CGPoint(x: 64, y: size.height))
                beam.addLine(to: CGPoint(x: 15, y: size.height))
                beam.closeSubpath()
                context.fill(beam, with: .color(.white.opacity(0.22)))
                context.fill(Path(ellipseIn: CGRect(x: size.width * 0.50, y: size.height * 0.48, width: 28, height: 24)), with: .color(.black.opacity(0.8)))
                context.fill(Path(CGRect(x: size.width * 0.59, y: size.height * 0.60, width: 11, height: 35)), with: .color(.black.opacity(0.9)))
                context.stroke(Path { path in
                    path.move(to: CGPoint(x: size.width * 0.47, y: size.height * 0.70))
                    path.addLine(to: CGPoint(x: size.width * 0.72, y: size.height * 0.70))
                }, with: .color(.white.opacity(0.45)), lineWidth: 2)

            case .dog:
                context.fill(Path(rect), with: .color(Color(red: 0.70, green: 0.10, blue: 0.18)))
                for x in stride(from: 8.0, through: Double(size.width), by: 18) {
                    for y in stride(from: 8.0, through: Double(size.height), by: 20) {
                        let mark = CGRect(x: x, y: y, width: 8, height: 5)
                        context.stroke(Path(ellipseIn: mark), with: .color(.cyan.opacity(0.35)), lineWidth: 1)
                    }
                }
                context.fill(Path(ellipseIn: CGRect(x: size.width * 0.08, y: size.height * 0.34, width: size.width * 0.62, height: size.height * 0.44)), with: .color(Color(red: 0.93, green: 0.90, blue: 0.82)))
                context.fill(Path(ellipseIn: CGRect(x: size.width * 0.43, y: size.height * 0.18, width: size.width * 0.30, height: size.height * 0.27)), with: .color(Color(red: 0.90, green: 0.86, blue: 0.75)))
                context.fill(Path(ellipseIn: CGRect(x: size.width * 0.51, y: size.height * 0.22, width: size.width * 0.10, height: size.height * 0.08)), with: .color(.black.opacity(0.70)))
                context.fill(Path(ellipseIn: CGRect(x: size.width * 0.60, y: size.height * 0.32, width: size.width * 0.09, height: size.height * 0.06)), with: .color(.black.opacity(0.75)))

            case .sky:
                context.fill(Path(rect), with: .linearGradient(
                    Gradient(colors: [
                        Color(red: 0.18, green: 0.04, blue: 0.22),
                        Color(red: 0.93, green: 0.25, blue: 0.11),
                        Color(red: 1.0, green: 0.66, blue: 0.22)
                    ]),
                    startPoint: CGPoint(x: 0, y: 0),
                    endPoint: CGPoint(x: 0, y: size.height)
                ))
                for index in 0..<10 {
                    var cloud = Path()
                    let y = CGFloat(index) * size.height / 10 + 8
                    cloud.move(to: CGPoint(x: 0, y: y))
                    for x in stride(from: 0, through: size.width, by: 10) {
                        cloud.addLine(to: CGPoint(x: x, y: y + sin((x + CGFloat(index) * 11) / 10) * 4))
                    }
                    context.stroke(cloud, with: .color(Color(red: 0.15, green: 0.05, blue: 0.20).opacity(0.75)), lineWidth: 5)
                }
                context.fill(Path(CGRect(x: 0, y: size.height * 0.82, width: size.width, height: size.height * 0.18)), with: .color(.black.opacity(0.25)))

            case .custom(let colors, let label):
                context.fill(Path(rect), with: .linearGradient(
                    Gradient(colors: colors),
                    startPoint: CGPoint(x: 0, y: 0),
                    endPoint: CGPoint(x: size.width, y: size.height)
                ))
                if !label.isEmpty {
                    context.draw(
                        Text(label)
                            .font(.system(size: 8, weight: .bold, design: .monospaced))
                            .foregroundStyle(.white.opacity(0.75)),
                        at: CGPoint(x: 25, y: 14)
                    )
                }
            }
        }
        .clipped()
    }
}

private struct FilmMarks: View {
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let height = proxy.size.height

            ZStack {
                ForEach(0..<4, id: \.self) { index in
                    Circle()
                        .fill(Color(red: 0.98, green: 0.75, blue: 0.52).opacity(0.75))
                        .frame(width: 2, height: 2)
                        .position(x: 11 + CGFloat(index) * (width - 22) / 3, y: 6)

                    Circle()
                        .fill(Color(red: 0.98, green: 0.75, blue: 0.52).opacity(0.75))
                        .frame(width: 2, height: 2)
                        .position(x: 11 + CGFloat(index) * (width - 22) / 3, y: height - 6)
                }
            }
        }
        .allowsHitTesting(false)
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
