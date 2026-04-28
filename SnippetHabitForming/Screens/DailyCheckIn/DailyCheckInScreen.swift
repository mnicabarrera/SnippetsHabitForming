import SwiftUI

struct DailyCheckInScreen: View {
    @Binding var route: AppRoute

    var body: some View {
        FigmaScaledCanvas(background: .soft) {
            IconButton(systemName: "house", action: { route = .home })
                .position(x: 818, y: 49)

            Text("How are you feeling today?")
                .figmaText(29, weight: .bold)
                .position(x: 437, y: 126)

            HStack(spacing: 88) {
                MoodOption(icon: .sleepy, title: "Sleepy")
                MoodOption(icon: .playful, title: "Playful", action: { route = .challengeSelection })
                MoodOption(icon: .quiet, title: "Quiet")
                MoodOption(icon: .wild, title: "Wild")
            }
            .position(x: 438, y: 250)
        }
    }
}

private enum MoodIcon {
    case sleepy
    case playful
    case quiet
    case wild
}

private struct MoodOption: View {
    let icon: MoodIcon
    let title: String
    var action: (() -> Void)?

    var body: some View {
        Group {
            if let action {
                Button(action: action) {
                    content
                }
                .buttonStyle(.plain)
            } else {
                content
            }
        }
    }

    private var content: some View {
        TornPaper(width: 196, height: 145) {
            VStack(spacing: 17) {
                MoodIconView(icon: icon)
                    .frame(width: 62, height: 54)
                Text(title)
                    .figmaText(22, weight: .bold)
            }
            .padding(.top, 27)
        }
    }
}

private struct TornPaper<Content: View>: View {
    let width: CGFloat
    let height: CGFloat
    @ViewBuilder var content: () -> Content

    var body: some View {
        ZStack {
            TornPaperShape()
                .fill(Color(red: 0.79, green: 0.75, blue: 0.67))
                .offset(x: 4, y: 4)
                .blur(radius: 0.4)
                .opacity(0.55)

            TornPaperShape()
                .fill(Color(red: 0.84, green: 0.80, blue: 0.72))
                .overlay(PaperTexture().clipShape(TornPaperShape()).opacity(0.55))
                .overlay(TornPaperShape().stroke(.white.opacity(0.36), lineWidth: 1.2))
                .shadow(color: .black.opacity(0.18), radius: 2, x: 3, y: 4)

            content()
        }
        .frame(width: width, height: height)
    }
}

private struct TornPaperShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let points: [CGPoint] = [
            CGPoint(x: 0.06, y: 0.22),
            CGPoint(x: 0.09, y: 0.08),
            CGPoint(x: 0.25, y: 0.03),
            CGPoint(x: 0.36, y: 0.07),
            CGPoint(x: 0.49, y: 0.04),
            CGPoint(x: 0.64, y: 0.06),
            CGPoint(x: 0.78, y: 0.04),
            CGPoint(x: 0.93, y: 0.10),
            CGPoint(x: 0.91, y: 0.26),
            CGPoint(x: 0.96, y: 0.41),
            CGPoint(x: 0.91, y: 0.57),
            CGPoint(x: 0.94, y: 0.78),
            CGPoint(x: 0.80, y: 0.88),
            CGPoint(x: 0.62, y: 0.86),
            CGPoint(x: 0.48, y: 0.93),
            CGPoint(x: 0.34, y: 0.86),
            CGPoint(x: 0.18, y: 0.90),
            CGPoint(x: 0.06, y: 0.82),
            CGPoint(x: 0.09, y: 0.63),
            CGPoint(x: 0.03, y: 0.48),
            CGPoint(x: 0.07, y: 0.35)
        ]

        guard let first = points.first else { return path }
        path.move(to: CGPoint(x: rect.minX + first.x * rect.width, y: rect.minY + first.y * rect.height))
        for point in points.dropFirst() {
            path.addLine(to: CGPoint(x: rect.minX + point.x * rect.width, y: rect.minY + point.y * rect.height))
        }
        path.closeSubpath()
        return path
    }
}

private struct MoodIconView: View {
    let icon: MoodIcon

    var body: some View {
        Canvas { context, size in
            let rect = CGRect(origin: .zero, size: size)
            let stroke = StrokeStyle(lineWidth: 3.2, lineCap: .round, lineJoin: .round)

            switch icon {
            case .sleepy:
                drawSleepy(in: rect, context: &context, stroke: stroke)
            case .playful:
                drawPlayful(in: rect, context: &context, stroke: stroke)
            case .quiet:
                drawQuiet(in: rect, context: &context, stroke: stroke)
            case .wild:
                drawWild(in: rect, context: &context, stroke: stroke)
            }
        }
    }

    private func drawSleepy(in rect: CGRect, context: inout GraphicsContext, stroke: StrokeStyle) {
        let color = Color.black
        context.stroke(Path(ellipseIn: CGRect(x: rect.midX - 22, y: rect.midY - 13, width: 44, height: 35)), with: .color(color), style: stroke)
        context.stroke(line(from: CGPoint(x: rect.midX - 12, y: rect.midY - 1), to: CGPoint(x: rect.midX - 7, y: rect.midY - 1)), with: .color(color), style: stroke)
        context.stroke(line(from: CGPoint(x: rect.midX + 7, y: rect.midY - 1), to: CGPoint(x: rect.midX + 12, y: rect.midY - 1)), with: .color(color), style: stroke)
        context.stroke(curve(from: CGPoint(x: rect.midX - 7, y: rect.midY + 9), c1: CGPoint(x: rect.midX - 2, y: rect.midY + 13), c2: CGPoint(x: rect.midX + 2, y: rect.midY + 13), to: CGPoint(x: rect.midX + 7, y: rect.midY + 9)), with: .color(color), style: stroke)
        context.stroke(line(from: CGPoint(x: rect.midX - 27, y: rect.midY + 5), to: CGPoint(x: rect.midX - 20, y: rect.midY + 5)), with: .color(color), style: stroke)
        context.stroke(line(from: CGPoint(x: rect.midX + 20, y: rect.midY + 5), to: CGPoint(x: rect.midX + 27, y: rect.midY + 5)), with: .color(color), style: stroke)

        context.draw(
            Text("z")
                .font(.system(size: 13, weight: .bold, design: .rounded))
                .foregroundStyle(color),
            at: CGPoint(x: rect.midX + 23, y: rect.midY - 22)
        )
        context.draw(
            Text("z")
                .font(.system(size: 9, weight: .bold, design: .rounded))
                .foregroundStyle(color),
            at: CGPoint(x: rect.midX + 34, y: rect.midY - 27)
        )
    }

    private func drawPlayful(in rect: CGRect, context: inout GraphicsContext, stroke: StrokeStyle) {
        let color = Color.black
        for angle in stride(from: 205.0, through: 335.0, by: 26.0) {
            let radians = angle * .pi / 180
            let start = CGPoint(x: rect.midX + cos(radians) * 13, y: rect.midY + sin(radians) * 13)
            let end = CGPoint(x: rect.midX + cos(radians) * 29, y: rect.midY + sin(radians) * 29)
            context.stroke(line(from: start, to: end), with: .color(color), style: stroke)
        }
        for offset in [-18.0, -6.0, 6.0, 18.0] {
            context.stroke(curve(from: CGPoint(x: rect.midX, y: rect.midY + 24), c1: CGPoint(x: rect.midX + offset, y: rect.midY + 8), c2: CGPoint(x: rect.midX + offset, y: rect.midY - 5), to: CGPoint(x: rect.midX + offset / 1.8, y: rect.midY - 18)), with: .color(color), style: stroke)
        }
        context.fill(Path(ellipseIn: CGRect(x: rect.midX - 4, y: rect.midY + 22, width: 8, height: 8)), with: .color(color))
    }

    private func drawQuiet(in rect: CGRect, context: inout GraphicsContext, stroke: StrokeStyle) {
        let color = Color.black
        context.stroke(Path(ellipseIn: CGRect(x: rect.midX - 22, y: rect.midY - 22, width: 44, height: 44)), with: .color(color), style: stroke)
        context.stroke(line(from: CGPoint(x: rect.midX - 10, y: rect.midY - 4), to: CGPoint(x: rect.midX - 5, y: rect.midY - 1)), with: .color(color), style: stroke)
        context.stroke(line(from: CGPoint(x: rect.midX + 10, y: rect.midY - 4), to: CGPoint(x: rect.midX + 5, y: rect.midY - 1)), with: .color(color), style: stroke)
        context.stroke(line(from: CGPoint(x: rect.midX - 7, y: rect.midY + 11), to: CGPoint(x: rect.midX + 7, y: rect.midY + 11)), with: .color(color), style: stroke)
    }

    private func drawWild(in rect: CGRect, context: inout GraphicsContext, stroke: StrokeStyle) {
        let color = Color.black
        var head = Path()
        head.move(to: CGPoint(x: rect.midX - 22, y: rect.midY - 12))
        head.addLine(to: CGPoint(x: rect.midX - 26, y: rect.midY - 25))
        head.addLine(to: CGPoint(x: rect.midX - 12, y: rect.midY - 20))
        head.addQuadCurve(to: CGPoint(x: rect.midX + 12, y: rect.midY - 20), control: CGPoint(x: rect.midX, y: rect.midY - 26))
        head.addLine(to: CGPoint(x: rect.midX + 26, y: rect.midY - 25))
        head.addLine(to: CGPoint(x: rect.midX + 22, y: rect.midY - 12))
        head.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.midY + 24), control: CGPoint(x: rect.midX + 26, y: rect.midY + 16))
        head.addQuadCurve(to: CGPoint(x: rect.midX - 22, y: rect.midY - 12), control: CGPoint(x: rect.midX - 26, y: rect.midY + 16))
        context.stroke(head, with: .color(color), style: stroke)
        context.fill(Path(ellipseIn: CGRect(x: rect.midX - 10, y: rect.midY - 2, width: 4, height: 4)), with: .color(color))
        context.fill(Path(ellipseIn: CGRect(x: rect.midX + 6, y: rect.midY - 2, width: 4, height: 4)), with: .color(color))
        context.stroke(line(from: CGPoint(x: rect.midX, y: rect.midY + 7), to: CGPoint(x: rect.midX, y: rect.midY + 10)), with: .color(color), style: stroke)
    }

    private func line(from start: CGPoint, to end: CGPoint) -> Path {
        var path = Path()
        path.move(to: start)
        path.addLine(to: end)
        return path
    }

    private func curve(from start: CGPoint, c1: CGPoint, c2: CGPoint, to end: CGPoint) -> Path {
        var path = Path()
        path.move(to: start)
        path.addCurve(to: end, control1: c1, control2: c2)
        return path
    }
}
