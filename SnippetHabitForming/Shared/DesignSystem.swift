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
    @ViewBuilder var content: () -> Content

    var body: some View {
        GeometryReader { proxy in
            let scale = min(proxy.size.width / HabitDesign.canvasSize.width, proxy.size.height / HabitDesign.canvasSize.height)

            ZStack {
                FabricBackground(kind: background)
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

struct FabricBackground: View {
    enum Kind {
        case blue
        case soft
        case dimmed
    }

    var kind: Kind = .soft

    var body: some View {
        Canvas { context, size in
            let base: Color = switch kind {
            case .blue: HabitDesign.blueFabric
            case .soft, .dimmed: HabitDesign.softBlueFabric
            }

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
