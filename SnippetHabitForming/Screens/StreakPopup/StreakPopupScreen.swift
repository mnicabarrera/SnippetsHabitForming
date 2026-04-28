import SwiftUI

struct StreakPopupScreen: View {
    @Binding var route: AppRoute

    var body: some View {
        FigmaScaledCanvas(background: .soft) {
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

            Rectangle()
                .fill(.black.opacity(0.55))
                .frame(width: HabitDesign.canvasSize.width, height: HabitDesign.canvasSize.height)
                .position(x: HabitDesign.canvasSize.width / 2, y: HabitDesign.canvasSize.height / 2)

            PaperCard(width: 226, height: 234, radius: 30) {
                VStack(spacing: 8) {
                    Image(systemName: "star")
                        .font(.system(size: 82, weight: .black))
                        .foregroundStyle(.black.opacity(0.82))
                        .shadow(color: .white.opacity(0.9), radius: 1, x: -2, y: -2)
                    Text("3 Days!")
                        .figmaText(31, weight: .bold)
                    Text("Consistency Queen")
                        .figmaText(13)
                    Button {
                        route = .weeklyRecapOverview
                    } label: {
                        Text("Overview")
                            .figmaText(8, weight: .bold)
                            .padding(.top, 10)
                    }
                    .buttonStyle(.plain)
                }
            }
            .position(x: 437, y: 207)
        }
    }
}
