import SwiftUI

struct ModeSplashView: View {
    let onChoose: (AppMode) -> Void

    var body: some View {
        ZStack {
            TrailColor.parchment.ignoresSafeArea()

            VStack(spacing: 36) {
                Spacer()

                VStack(spacing: 8) {
                    Text("DESKRUN")
                        .font(.system(size: 48, weight: .black, design: .monospaced))
                        .foregroundColor(TrailColor.deepBrown)
                        .tracking(6)
                    Text("═══════════════════")
                        .font(.system(size: 16, design: .monospaced))
                        .foregroundColor(TrailColor.coral)
                    Text("CHOOSE YOUR ADVENTURE")
                        .font(.system(size: 14, weight: .semibold, design: .monospaced))
                        .foregroundColor(TrailColor.darkEarth)
                        .tracking(3)
                }

                HStack(spacing: 24) {
                    modeCard(
                        title: "FREE WALK",
                        subtitle: "Walk freely.\nTrack miles.\nHit your goals.",
                        symbol: "figure.walk",
                        accent: TrailColor.forestGreen,
                        action: { onChoose(.freeWalk) }
                    )

                    modeCard(
                        title: "JOURNEYS",
                        subtitle: "Hike iconic trails.\nEncounter surprises.\nEarn a certificate.",
                        symbol: "mountain.2",
                        accent: TrailColor.coral,
                        action: { onChoose(.journey) }
                    )
                }
                .padding(.horizontal, 40)

                Text("You can switch modes from Camp (Settings) anytime.")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundColor(TrailColor.darkEarth.opacity(0.7))

                Spacer()
            }
            .padding(.vertical, 40)
        }
        .frame(minWidth: 750, minHeight: 550)
    }

    @ViewBuilder
    private func modeCard(title: String, subtitle: String, symbol: String, accent: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 18) {
                Image(systemName: symbol)
                    .font(.system(size: 56))
                    .foregroundColor(accent)

                Text(title)
                    .font(.system(size: 22, weight: .black, design: .monospaced))
                    .foregroundColor(TrailColor.deepBrown)
                    .tracking(4)

                Text(subtitle)
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundColor(TrailColor.darkEarth)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)

                Text(">> BEGIN <<")
                    .font(.system(size: 12, weight: .bold, design: .monospaced))
                    .foregroundColor(accent)
                    .tracking(2)
                    .padding(.top, 4)
            }
            .frame(width: 240, height: 300)
            .padding(20)
            .background(TrailColor.parchment)
            .overlay(
                Rectangle()
                    .strokeBorder(TrailColor.deepBrown, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }
}
