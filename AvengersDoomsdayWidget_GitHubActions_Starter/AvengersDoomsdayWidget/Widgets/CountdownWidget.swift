import WidgetKit
import SwiftUI

struct CountdownEntry: TimelineEntry {
    let date: Date
}

struct CountdownProvider: TimelineProvider {
    func placeholder(in context: Context) -> CountdownEntry {
        CountdownEntry(date: .now)
    }

    func getSnapshot(in context: Context, completion: @escaping (CountdownEntry) -> Void) {
        completion(CountdownEntry(date: .now))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<CountdownEntry>) -> Void) {
        let now = Date()
        let entries = (0..<60).map { minute in
            CountdownEntry(date: Calendar.current.date(byAdding: .minute, value: minute, to: now) ?? now)
        }
        completion(Timeline(entries: entries, policy: .atEnd))
    }
}

struct CountdownWidgetView: View {
    @Environment(\.widgetFamily) private var family
    let entry: CountdownEntry

    private var parts: (days: Int, hours: Int, minutes: Int, seconds: Int) {
        CountdownDate.parts(from: entry.date)
    }

    var body: some View {
        ZStack {
            WidgetBackdrop()
            switch family {
            case .systemSmall:
                small
            case .systemLarge:
                large
            default:
                medium
            }
        }
        .containerBackground(for: .widget) { WidgetBackdrop() }
    }

    private var small: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack { AvengersEmblem(size: 31); Spacer(); Text("MARVEL").font(.system(size: 8, weight: .black)).foregroundStyle(CountdownStyle.muted) }
            Spacer(minLength: 0)
            Text("AVENGERS").font(.system(size: 12, weight: .black)).tracking(1).foregroundStyle(.white).lineLimit(1).minimumScaleFactor(0.7)
            Text("DOOMSDAY").font(.system(size: 11, weight: .heavy)).tracking(1.5).foregroundStyle(CountdownStyle.gold).lineLimit(1).minimumScaleFactor(0.7)
            Text("\(parts.days)").font(.system(size: 43, weight: .bold, design: .rounded)).monospacedDigit().foregroundStyle(CountdownStyle.paleGold).minimumScaleFactor(0.6).lineLimit(1)
            Text("天后上映").font(.system(size: 10, weight: .medium)).foregroundStyle(CountdownStyle.muted)
            Spacer(minLength: 0)
            Text("DEC 18 · 2026").font(.system(size: 8, weight: .bold)).tracking(1).foregroundStyle(CountdownStyle.muted)
        }
        .padding(13)
    }

    private var medium: some View {
        HStack(spacing: 14) {
            VStack(spacing: 8) {
                AvengersEmblem(size: 57)
                Text("AVENGERS").font(.system(size: 11, weight: .black)).tracking(1).foregroundStyle(.white)
                Text("DOOMSDAY").font(.system(size: 10, weight: .heavy)).tracking(2).foregroundStyle(CountdownStyle.gold)
            }
            Rectangle().fill(CountdownStyle.gold.opacity(0.25)).frame(width: 1).padding(.vertical, 9)
            VStack(alignment: .leading, spacing: 12) {
                Text("距离上映还有").font(.system(size: 11, weight: .medium)).foregroundStyle(CountdownStyle.muted)
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("\(parts.days)").font(.system(size: 42, weight: .bold, design: .rounded)).monospacedDigit()
                    Text("天").font(.system(size: 12, weight: .medium))
                }.foregroundStyle(CountdownStyle.paleGold)
                HStack(spacing: 5) {
                    miniUnit(String(format: "%02d", parts.hours), "小时")
                    miniUnit(String(format: "%02d", parts.minutes), "分钟")
                }
                Text("DECEMBER 18, 2026").font(.system(size: 9, weight: .bold)).tracking(1).foregroundStyle(CountdownStyle.gold)
            }
            Spacer(minLength: 0)
        }
        .padding(16)
    }

    private var large: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("MARVEL STUDIOS").font(.system(size: 9, weight: .heavy)).tracking(2).foregroundStyle(CountdownStyle.muted)
                Spacer()
                AvengersEmblem(size: 43)
            }
            Text("AVENGERS").font(.system(size: 24, weight: .black)).tracking(2).foregroundStyle(.white)
            Text("DOOMSDAY").font(.system(size: 17, weight: .heavy)).tracking(5).foregroundStyle(CountdownStyle.gold)
            Text("复仇者联盟5：毁灭日").font(.system(size: 11, weight: .medium)).tracking(2).foregroundStyle(CountdownStyle.muted)
            Divider().overlay(CountdownStyle.gold.opacity(0.3))
            Text("距离上映还有").font(.system(size: 12, weight: .medium)).foregroundStyle(CountdownStyle.muted)
            HStack(spacing: 4) {
                largeUnit("\(parts.days)", "天")
                largeUnit(String(format: "%02d", parts.hours), "小时")
                largeUnit(String(format: "%02d", parts.minutes), "分钟")
                largeUnit(String(format: "%02d", parts.seconds), "秒")
            }
            Spacer(minLength: 0)
            HStack {
                Text("DECEMBER 18, 2026").font(.system(size: 10, weight: .bold)).tracking(1).foregroundStyle(CountdownStyle.paleGold)
                Spacer()
                Text("WHATEVER IT TAKES.").font(.system(size: 8, weight: .semibold)).tracking(1).foregroundStyle(CountdownStyle.muted)
            }
        }
        .padding(17)
    }

    private func miniUnit(_ value: String, _ label: String) -> some View {
        HStack(spacing: 3) {
            Text(value).font(.system(size: 16, weight: .bold, design: .rounded)).monospacedDigit().foregroundStyle(CountdownStyle.paleGold)
            Text(label).font(.system(size: 9)).foregroundStyle(CountdownStyle.muted)
        }
    }

    private func largeUnit(_ value: String, _ label: String) -> some View {
        VStack(spacing: 5) {
            Text(value).font(.system(size: 25, weight: .bold, design: .rounded)).monospacedDigit().foregroundStyle(CountdownStyle.paleGold).minimumScaleFactor(0.55).lineLimit(1)
            Text(label).font(.system(size: 10, weight: .medium)).foregroundStyle(CountdownStyle.muted)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(.white.opacity(0.035), in: RoundedRectangle(cornerRadius: 10))
    }
}

@main
struct CountdownWidget: Widget {
    let kind = "CountdownWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CountdownProvider()) { entry in
            CountdownWidgetView(entry: entry)
        }
        .configurationDisplayName("复联5上映倒计时")
        .description("在主屏幕查看《复仇者联盟5：毁灭日》上映倒计时。")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
