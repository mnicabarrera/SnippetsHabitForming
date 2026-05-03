import SwiftUI

struct DailyCheckInScreen: View {
    @Binding var route: AppRoute

    var body: some View {
        FigmaScaledCanvas(background: .soft, backgroundImageName: "Background 2", backgroundIgnoresSafeArea: true) {
            IconButton(systemName: "house", action: { route = .home })
                .position(x: 818, y: 49)

            Text("How are you feeling today?")
                .figmaText(29, weight: .bold)
                .position(x: 437, y: 126)

            HStack(spacing: 48) {
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
        MoodIconView(icon: icon)
            .frame(width: 170, height: 170)
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
        Image(imageName)
            .resizable()
            .scaledToFit()
    }

    private var imageName: String {
        switch icon {
        case .sleepy:
            "Sleepy"
        case .playful:
            "Playful"
        case .quiet:
            "Quiet"
        case .wild:
            "Wild"
        }
    }
}
