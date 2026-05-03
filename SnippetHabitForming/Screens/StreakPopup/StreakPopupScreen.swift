import SwiftUI

struct StreakPopupScreen: View {
    @Binding var route: AppRoute

    var body: some View {
        FigmaScaledCanvas(background: .soft, backgroundImageName: "Background 2", backgroundIgnoresSafeArea: true) {
            IconButton(systemName: "house", action: { route = .home })
                .position(x: 48, y: 30)

            JournalBook()
                .position(x: 440, y: 211)

            VStack(spacing: 7) {
                Image(systemName: "arrow.uturn.backward")
                Image(systemName: "arrow.uturn.forward")
                Image(systemName: "square.and.arrow.down")
                Image(systemName: "camera")
                Image(systemName: "pencil")
                Image(systemName: "star")
            }
            .font(.system(size: 22, weight: .bold))
            .foregroundStyle(.black)
            .frame(width: 32)
            .position(x: 815, y: 116)

        }
        .overlay {
            StreakOverlay(route: $route)
        }
    }
}

private struct StreakOverlay: View {
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
