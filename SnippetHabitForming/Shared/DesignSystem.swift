import SwiftUI

enum HabitDesign {
    static let canvasSize = CGSize(width: 874, height: 402)
    static let ink = Color.black
    static let paper = Color(red: 0.985, green: 0.958, blue: 0.91)
    static let blueFabric = Color(red: 0.61, green: 0.76, blue: 0.80)
    static let softBlueFabric = Color(red: 0.77, green: 0.86, blue: 0.87)
    static let pinkBook = Color(red: 0.94, green: 0.77, blue: 0.77)
    static let mintBook = Color(red: 0.79, green: 0.88, blue: 0.87)
    static let creamBook = Color(red: 0.93, green: 0.88, blue: 0.78)
}

extension View {
    func figmaText(_ size: CGFloat, weight: Font.Weight = .regular) -> some View {
        font(.system(size: size, weight: weight, design: .monospaced))
            .foregroundStyle(HabitDesign.ink)
    }
}

struct FigmaScaledCanvas<Content: View>: View {
    var background: FabricBackground.Kind = .soft
    var backgroundImageName: String?
    var backgroundIgnoresSafeArea = false
    @ViewBuilder var content: () -> Content

    var body: some View {
        ZStack {
            if backgroundIgnoresSafeArea {
                backgroundView
                    .ignoresSafeArea()
            }

            GeometryReader { proxy in
                let scale = min(proxy.size.width / HabitDesign.canvasSize.width, proxy.size.height / HabitDesign.canvasSize.height)

                ZStack {
                    if !backgroundIgnoresSafeArea {
                        backgroundView
                    }
                    ZStack {
                        content()
                    }
                    .frame(width: HabitDesign.canvasSize.width, height: HabitDesign.canvasSize.height)
                    .scaleEffect(scale)
                }
                .frame(width: proxy.size.width, height: proxy.size.height)
                .clipped()
            }
        }
    }

    @ViewBuilder
    private var backgroundView: some View {
        if let backgroundImageName {
            Image(backgroundImageName)
                .resizable()
                .scaledToFill()
        } else {
            FabricBackground(kind: background)
        }
    }
}

struct FabricBackground: View {
    enum Kind {
        case blue
        case soft
        case dimmed
    }

    var kind: Kind = .soft

    var body: some View {
        Canvas { context, size in
            if kind == .blue {
                drawPaintedBlueFabric(in: &context, size: size)
                return
            }

            let base: Color = HabitDesign.softBlueFabric
            context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(base))

            for x in stride(from: -size.height, through: size.width + size.height, by: 18) {
                var path = Path()
                path.move(to: CGPoint(x: x, y: 0))
                path.addLine(to: CGPoint(x: x + size.height, y: size.height))
                context.stroke(path, with: .color(.white.opacity(0.17)), lineWidth: 1)
            }

            for y in stride(from: 0, through: size.height, by: 9) {
                var path = Path()
                path.move(to: CGPoint(x: 0, y: y))
                path.addLine(to: CGPoint(x: size.width, y: y + sin(y / 18) * 5))
                context.stroke(path, with: .color(.black.opacity(0.05)), lineWidth: 1)
            }

            for x in stride(from: 0, through: size.width, by: 11) {
                var path = Path()
                path.move(to: CGPoint(x: x, y: 0))
                path.addLine(to: CGPoint(x: x + cos(x / 22) * 4, y: size.height))
                context.stroke(path, with: .color(.white.opacity(0.08)), lineWidth: 1)
            }

            if kind == .dimmed {
                context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(.black.opacity(0.55)))
            }
        }
        .ignoresSafeArea()
    }

    private func drawPaintedBlueFabric(in context: inout GraphicsContext, size: CGSize) {
        let rect = CGRect(origin: .zero, size: size)
        let base = Color(red: 0.31, green: 0.56, blue: 0.65)
        let dark = Color(red: 0.18, green: 0.42, blue: 0.52)
        let light = Color(red: 0.65, green: 0.83, blue: 0.87)

        context.fill(Path(rect), with: .color(base))

        for x in stride(from: -size.height, through: size.width + size.height, by: 9) {
            var path = Path()
            path.move(to: CGPoint(x: x, y: 0))
            path.addLine(to: CGPoint(x: x + size.height * 0.72, y: size.height))
            context.stroke(path, with: .color(.white.opacity(0.10)), lineWidth: 1.1)
        }

        for x in stride(from: 0, through: size.width, by: 5) {
            var path = Path()
            path.move(to: CGPoint(x: x, y: 0))
            path.addLine(to: CGPoint(x: x + sin(x / 15) * 3, y: size.height))
            context.stroke(path, with: .color(.black.opacity(0.045)), lineWidth: 0.8)
        }

        for y in stride(from: 0, through: size.height, by: 6) {
            var path = Path()
            path.move(to: CGPoint(x: 0, y: y))
            path.addLine(to: CGPoint(x: size.width, y: y + cos(y / 18) * 3))
            context.stroke(path, with: .color(.white.opacity(0.07)), lineWidth: 0.8)
        }

        let patches: [(CGRect, Double, Double)] = [
            (CGRect(x: -20, y: 0, width: size.width * 0.30, height: size.height * 0.68), -7, 0.22),
            (CGRect(x: size.width * 0.18, y: -14, width: size.width * 0.18, height: size.height * 0.95), 4, 0.12),
            (CGRect(x: size.width * 0.38, y: -22, width: size.width * 0.22, height: size.height * 1.10), -3, 0.16),
            (CGRect(x: size.width * 0.58, y: -10, width: size.width * 0.16, height: size.height * 0.82), 6, 0.10),
            (CGRect(x: size.width * 0.72, y: 0, width: size.width * 0.22, height: size.height), -4, 0.14),
            (CGRect(x: size.width * 0.88, y: -8, width: size.width * 0.18, height: size.height * 1.04), 5, 0.18)
        ]

        for (patchRect, rotation, opacity) in patches {
            var copy = context
            copy.translateBy(x: patchRect.midX, y: patchRect.midY)
            copy.rotate(by: .degrees(rotation))
            copy.translateBy(x: -patchRect.midX, y: -patchRect.midY)
            copy.fill(Path(roundedRect: patchRect, cornerRadius: 8), with: .color(light.opacity(opacity)))
            copy.stroke(Path(roundedRect: patchRect, cornerRadius: 8), with: .color(dark.opacity(0.12)), lineWidth: 2)
        }

        let foldLines: [(CGPoint, CGPoint, CGFloat, Double)] = [
            (CGPoint(x: size.width * 0.03, y: 0), CGPoint(x: size.width * 0.18, y: size.height), 5, 0.16),
            (CGPoint(x: size.width * 0.32, y: 0), CGPoint(x: size.width * 0.35, y: size.height), 7, 0.18),
            (CGPoint(x: size.width * 0.48, y: 0), CGPoint(x: size.width * 0.51, y: size.height), 8, 0.17),
            (CGPoint(x: size.width * 0.69, y: 0), CGPoint(x: size.width * 0.73, y: size.height), 4, 0.14),
            (CGPoint(x: size.width * 0.92, y: 0), CGPoint(x: size.width * 0.96, y: size.height), 5, 0.20)
        ]

        for (start, end, width, opacity) in foldLines {
            var shadow = Path()
            shadow.move(to: start)
            shadow.addLine(to: end)
            context.stroke(shadow, with: .color(.black.opacity(opacity)), lineWidth: width)

            var highlight = Path()
            highlight.move(to: CGPoint(x: start.x + 4, y: start.y))
            highlight.addLine(to: CGPoint(x: end.x + 4, y: end.y))
            context.stroke(highlight, with: .color(.white.opacity(0.16)), lineWidth: max(1, width * 0.35))
        }

        let scratchPoints: [[CGPoint]] = [
            [CGPoint(x: size.width * 0.80, y: size.height * 0.08), CGPoint(x: size.width * 0.83, y: size.height * 0.17), CGPoint(x: size.width * 0.81, y: size.height * 0.26)],
            [CGPoint(x: size.width * 0.91, y: size.height * 0.11), CGPoint(x: size.width * 0.94, y: size.height * 0.22), CGPoint(x: size.width * 0.92, y: size.height * 0.35)],
            [CGPoint(x: size.width * 0.67, y: size.height * 0.42), CGPoint(x: size.width * 0.71, y: size.height * 0.45), CGPoint(x: size.width * 0.73, y: size.height * 0.52)],
            [CGPoint(x: size.width * 0.08, y: size.height * 0.68), CGPoint(x: size.width * 0.04, y: size.height * 0.82), CGPoint(x: size.width * 0.02, y: size.height * 0.96)]
        ]

        for points in scratchPoints {
            guard let first = points.first else { continue }
            var path = Path()
            path.move(to: first)
            for point in points.dropFirst() {
                path.addLine(to: point)
            }
            context.stroke(path, with: .color(.white.opacity(0.24)), lineWidth: 2)
            context.stroke(path, with: .color(.black.opacity(0.06)), lineWidth: 5)
        }

        context.fill(Path(CGRect(x: 0, y: size.height * 0.91, width: size.width * 0.18, height: size.height * 0.16)), with: .color(.white.opacity(0.16)))
        context.stroke(Path(rect), with: .color(.black.opacity(0.05)), lineWidth: 1)
    }
}

struct IconButton: View {
    let systemName: String
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.black)
                .frame(width: 44, height: 44)
        }
        .buttonStyle(.plain)
    }
}

struct PaperCard<Content: View>: View {
    var width: CGFloat
    var height: CGFloat
    var radius: CGFloat = 18
    var rotation: Double = 0
    @ViewBuilder var content: () -> Content

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: radius)
                .fill(HabitDesign.paper)
                .shadow(color: .black.opacity(0.28), radius: 4, x: 3, y: 5)
                .overlay(PaperTexture().clipShape(RoundedRectangle(cornerRadius: radius)).opacity(0.32))
            content()
        }
        .frame(width: width, height: height)
        .rotationEffect(.degrees(rotation))
    }
}

struct PaperTexture: View {
    var body: some View {
        Canvas { context, size in
            context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(.white.opacity(0.18)))
            for y in stride(from: 0, through: size.height, by: 7) {
                var path = Path()
                path.move(to: CGPoint(x: 0, y: y))
                path.addLine(to: CGPoint(x: size.width, y: y + sin(y) * 2))
                context.stroke(path, with: .color(.black.opacity(0.035)), lineWidth: 1)
            }
        }
    }
}

struct Tape: View {
    var color = Color(red: 0.94, green: 0.76, blue: 0.50)
    var width: CGFloat = 70
    var height: CGFloat = 28
    var rotation: Double = -20

    var body: some View {
        Rectangle()
            .fill(color.opacity(0.78))
            .overlay(
                LinearGradient(colors: [.white.opacity(0.18), .clear, .white.opacity(0.14)], startPoint: .leading, endPoint: .trailing)
            )
            .frame(width: width, height: height)
            .rotationEffect(.degrees(rotation))
            .shadow(color: .black.opacity(0.12), radius: 1, x: 1, y: 1)
    }
}
