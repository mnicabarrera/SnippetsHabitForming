import SwiftUI

struct ChallengeSelectionScreen: View {
    @Binding var route: AppRoute

    var body: some View {
        FigmaScaledCanvas(background: .soft) {
            IconButton(systemName: "arrow.left", action: { route = .dailyCheckIn })
                .position(x: 61, y: 48)
            IconButton(systemName: "house", action: { route = .home })
                .position(x: 819, y: 49)

            PaperStack {
                VStack(spacing: 0) {
                    Text("Go on a red hunt and\ncreate four Polaroids")
                        .figmaText(23)
                        .multilineTextAlignment(.center)
                        .lineSpacing(2)
                        .padding(.top, 175)

                    Spacer()

                    Button {
                        route = .quickJournalEntry
                    } label: {
                        Text("Tap to start")
                            .figmaText(11, weight: .bold)
                            .underline()
                    }
                    .buttonStyle(.plain)
                    .padding(.bottom, 41)
                }
                .frame(width: 400, height: 350)
            }
            .position(x: 437, y: 222)
        }
    }
}

private struct PaperStack<Content: View>: View {
    @ViewBuilder var content: () -> Content

    var body: some View {
        ZStack {
            ChallengePaperShape()
                .fill(Color(red: 0.82, green: 0.48, blue: 0.44))
                .frame(width: 400, height: 350)
                .rotationEffect(.degrees(-2.5))
                .offset(x: -18, y: 6)
                .shadow(color: .black.opacity(0.28), radius: 3, x: 5, y: 7)

            ChallengePaperShape()
                .fill(Color(red: 0.88, green: 0.54, blue: 0.50))
                .frame(width: 400, height: 350)
                .rotationEffect(.degrees(2.5))
                .offset(x: 17, y: 5)
                .shadow(color: .black.opacity(0.16), radius: 2, x: 3, y: 5)

            ChallengePaperShape()
                .fill(Color(red: 0.94, green: 0.61, blue: 0.58))
                .overlay(PaperTexture().clipShape(ChallengePaperShape()).opacity(0.24))
                .frame(width: 400, height: 350)
                .rotationEffect(.degrees(3))
                .offset(x: 0, y: -3)
                .shadow(color: .black.opacity(0.20), radius: 3, x: 4, y: 6)

            Tape(color: Color(red: 1.0, green: 0.78, blue: 0.84), width: 165, height: 58, rotation: 7)
                .position(x: 201, y: 45)
                .opacity(0.82)

            content()
                .rotationEffect(.degrees(3))
                .offset(x: 0, y: -3)
        }
        .frame(width: 460, height: 390)
    }
}

private struct ChallengePaperShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let points: [CGPoint] = [
            CGPoint(x: 0.02, y: 0.06),
            CGPoint(x: 0.23, y: 0.01),
            CGPoint(x: 0.48, y: 0.03),
            CGPoint(x: 0.75, y: 0.04),
            CGPoint(x: 0.98, y: 0.07),
            CGPoint(x: 0.94, y: 0.98),
            CGPoint(x: 0.72, y: 0.94),
            CGPoint(x: 0.50, y: 0.97),
            CGPoint(x: 0.26, y: 0.93),
            CGPoint(x: 0.00, y: 0.96)
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
