import SwiftUI

struct ChallengeSelectionScreen: View {
    @Binding var route: AppRoute

    var body: some View {
        FigmaScaledCanvas(background: .soft, backgroundImageName: "Background 2", backgroundIgnoresSafeArea: true) {
            IconButton(systemName: "arrow.left", action: { route = .back })
                .position(x: 61, y: 48)
            IconButton(systemName: "house", action: { route = .home })
                .position(x: 819, y: 49)

            Button {
                route = .quickJournalEntry(.challengeEveryday)
            } label: {
                PaperStack()
            }
            .buttonStyle(.plain)
            .contentShape(Rectangle())
            .position(x: 437, y: 222)
        }
    }
}

private struct PaperStack: View {
    var body: some View {
        Image("Post it")
            .resizable()
            .scaledToFit()
            .frame(width: 460, height: 390)
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
