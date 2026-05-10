import SwiftUI

struct PhotoTile: View {
    let colors: [Color]
    let label: String

    init(colors: [Color], label: String = "") {
        self.colors = colors
        self.label = label
    }

    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size

            ZStack {
                Rectangle()
                    .fill(Color(red: 0.08, green: 0.015, blue: 0.01))

                LinearGradient(
                    colors: colors,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .padding(12)

                RecapFilmMarks()
                    .padding(4)
            }
            .shadow(color: .black.opacity(0.25), radius: 2, x: 2, y: 2)
            .overlay(alignment: .bottomLeading) {
                if !label.isEmpty {
                    Text(label)
                        .font(.system(size: max(5, size.width * 0.07), weight: .bold, design: .monospaced))
                        .foregroundStyle(Color(red: 0.98, green: 0.75, blue: 0.52).opacity(0.75))
                        .offset(x: 10, y: -8)
                }
            }
        }
    }
}

private struct RecapFilmMarks: View {
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
