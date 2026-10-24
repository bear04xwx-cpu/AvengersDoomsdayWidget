import SwiftUI

struct CountdownHomeView: View {
    private var parts: (days: Int, hours: Int, minutes: Int, seconds: Int) {
        CountdownDate.parts()
    }

    var body: some View {
        ZStack {
            WidgetBackdrop().ignoresSafeArea()
            VStack(spacing: 26) {
                HStack {
                    Text("MARVEL STUDIOS")
                        .font(.system(size: 10, weight: .heavy))
                        .tracking(2)
                        .padding(7)
                        .overlay(Rectangle().stroke(CountdownStyle.gold.opacity(0.65), lineWidth: 1))
                    Spacer()
                    Circle().fill(CountdownStyle.gold).frame(width: 7, height: 7)
                        .shadow(color: CountdownStyle.gold, radius: 8)
                }
                Spacer()
                AvengersEmblem(size: 92)
                Text("AVENGERS")
                    .font(.system(size: 38, weight: .black, design: .rounded))
                    .tracking(2)
                    .foregroundStyle(.white)
                Text("DOOMSDAY")
                    .font(.system(size: 23, weight: .heavy))
                    .tracking(7)
                    .foregroundStyle(CountdownStyle.gold)
                Text("复仇者联盟5：毁灭日")
                    .font(.system(size: 14, weight: .medium))
                    .tracking(2)
                    .foregroundStyle(CountdownStyle.muted)
                VStack(spacing: 20) {
                    Text(Date.now < CountdownDate.target ? "距离上映还有" : "上映日期已到")
                        .font(.system(size: 12, weight: .medium))
                        .tracking(2)
                        .foregroundStyle(CountdownStyle.muted)
                    HStack(spacing: 2) {
                        CountdownNumber(value: "\(parts.days)", label: "天")
                        Text(":").foregroundStyle(CountdownStyle.gold.opacity(0.6))
                        CountdownNumber(value: String(format: "%02d", parts.hours), label: "小时")
                        Text(":").foregroundStyle(CountdownStyle.gold.opacity(0.6))
                        CountdownNumber(value: String(format: "%02d", parts.minutes), label: "分钟")
                        Text(":").foregroundStyle(CountdownStyle.gold.opacity(0.6))
                        CountdownNumber(value: String(format: "%02d", parts.seconds), label: "秒")
                    }
                    Text("DECEMBER 18, 2026")
                        .font(.system(size: 11, weight: .bold))
                        .tracking(2)
                        .foregroundStyle(CountdownStyle.paleGold)
                }
                .padding(20)
                .background(.white.opacity(0.045), in: RoundedRectangle(cornerRadius: 22))
                .overlay(RoundedRectangle(cornerRadius: 22).stroke(CountdownStyle.gold.opacity(0.3), lineWidth: 1))
                Spacer()
                Text("WHATEVER IT TAKES.")
                    .font(.system(size: 10, weight: .semibold))
                    .tracking(3)
                    .foregroundStyle(CountdownStyle.gold)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 18)
        }
    }
}
