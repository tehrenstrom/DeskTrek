import SwiftUI

struct EncounterBanner: View {
    let encounter: ActiveEncounter
    let onChoose: (String) -> Void

    var body: some View {
        TimelineView(.periodic(from: encounter.startedAt, by: 0.1)) { timeline in
            let remaining = max(0, encounter.deadline.timeIntervalSince(timeline.date))
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top) {
                    Text(encounter.event.title.uppercased())
                        .font(.system(size: 13, weight: .black, design: .monospaced))
                        .foregroundStyle(TrailColor.coral)
                        .tracking(2)
                    Spacer()
                    Text(String(format: "%ds", Int(ceil(remaining))))
                        .font(.system(size: 12, weight: .bold, design: .monospaced))
                        .foregroundStyle(remaining < 5 ? TrailColor.coral : TrailColor.text.opacity(0.6))
                        .monospacedDigit()
                }

                Text(encounter.event.body)
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundStyle(TrailColor.text)
                    .fixedSize(horizontal: false, vertical: true)

                // Timeout progress bar
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(TrailColor.darkEarth.opacity(0.15))
                        Rectangle()
                            .fill(remaining < 5 ? TrailColor.coral : TrailColor.mountainBlue)
                            .frame(width: geo.size.width * CGFloat(remaining / encounter.event.timeoutSeconds))
                    }
                }
                .frame(height: 3)

                HStack(spacing: 10) {
                    ForEach(encounter.event.choices) { choice in
                        Button(action: { onChoose(choice.id) }) {
                            Text(choice.label)
                                .font(.system(size: 12, weight: .bold, design: .monospaced))
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(RetroButtonStyle(
                            tint: choice.id == encounter.event.defaultChoiceID ? TrailColor.forestGreen : TrailColor.coral
                        ))
                    }
                }
            }
            .padding(16)
            .frame(maxWidth: 560)
            .background(TrailColor.parchment)
            .overlay(
                Rectangle()
                    .strokeBorder(TrailColor.coral, lineWidth: 3)
            )
            .shadow(color: .black.opacity(0.2), radius: 6, y: 3)
        }
    }
}
