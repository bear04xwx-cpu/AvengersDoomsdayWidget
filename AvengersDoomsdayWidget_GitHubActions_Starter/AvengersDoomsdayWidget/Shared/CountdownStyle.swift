import SwiftUI

enum CountdownStyle {
    static let background = Color(red: 0.035, green: 0.04, blue: 0.06)
    static let panel = Color(red: 0.09, green: 0.095, blue: 0.12)
    static let gold = Color(red: 0.91, green: 0.72, blue: 0.36)
    static let paleGold = Color(red: 1.0, green: 0.91, blue: 0.69)
    static let muted = Color(red: 0.68, green: 0.69, blue: 0.73)
    static let red = Color(red: 0.56, green: 0.08, blue: 0.13)
}

struct AvengersEmblem: View {
    var size: CGFloat = 54

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.08, to: 0.91)
                .stroke(
                    AngularGradient(colors: [CountdownStyle.paleGold, CountdownStyle.gold, CountdownStyle.paleGold],
                                    center: .center),
                    style: StrokeStyle(lineWidth: size * 0.045, lineCap: .square)
                )
                .rotationEffect(.degrees(-42))
            Image(systemName: "arrow.up.right")
                .font(.system(size: size * 0.30, weight: .black))
                .foregroundStyle(CountdownStyle.paleGold)
                .offset(x: size * 0.22, y: -size * 0.22)
            Text("A")
                .font(.system(size: size * 0.76, weight: .black, design: .rounded))
                .italic()
                .foregroundStyle(
                    LinearGradient(colors: [CountdownStyle.paleGold, CountdownStyle.gold],
                                   startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .offset(x: -size * 0.02, y: size * 0.035)
        }
        .frame(width: size, height: size)
        .accessibilityLabel("复仇者风格 A 标志")
    }
}

struct WidgetBackdrop: View {
    var body: some View {
        ZStack {
            CountdownStyle.background
            RadialGradient(colors: [CountdownStyle.red.opacity(0.35), .clear],
                           center: .topTrailing, startRadius: 2, endRadius: 220)
            LinearGradient(colors: [.white.opacity(0.045), .clear],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}

struct CountdownNumber: View {
    let value: String
    let label: String
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 29, weight: .semibold, design: .rounded))
                .monospacedDigit()
                .foregroundStyle(CountdownStyle.paleGold)
                .minimumScaleFactor(0.6)
                .lineLimit(1)
            Text(label)
                .font(.system(size: 10, weight: .medium))
                .foregroundStyle(CountdownStyle.muted)
        }
        .frame(maxWidth: .infinity)
    }
}
