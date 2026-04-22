import SwiftUI

struct BadgesView: View {
    let appState: AppState

    private var allBadges: [Badge] {
        TrailCatalog.all.flatMap { $0.badges }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                Text("BADGES")
                    .font(.system(size: 20, weight: .black, design: .monospaced))
                    .foregroundStyle(TrailColor.darkEarth)
                    .tracking(3)

                Text("Earned across all journeys. Gray badges are still out on the trail somewhere.")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(TrailColor.text.opacity(0.6))

                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: 140, maximum: 220), spacing: 14)],
                    spacing: 14
                ) {
                    ForEach(allBadges) { badge in
                        badgeCard(badge)
                    }
                }
            }
            .padding(24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(TrailColor.parchment)
        .navigationTitle("Badges")
    }

    @ViewBuilder
    private func badgeCard(_ badge: Badge) -> some View {
        let earned = appState.journeyStore.lifetimeBadgeIDs.contains(badge.id)
        VStack(spacing: 8) {
            PixelImage(assetName: badge.iconAsset, size: 48)
                .opacity(earned ? 1.0 : 0.25)
                .saturation(earned ? 1.0 : 0)
            Text(badge.name.uppercased())
                .font(.system(size: 11, weight: .bold, design: .monospaced))
                .foregroundStyle(earned ? TrailColor.darkEarth : TrailColor.text.opacity(0.4))
                .tracking(1)
                .multilineTextAlignment(.center)
            Text(badge.description)
                .font(.system(size: 10, design: .monospaced))
                .foregroundStyle(TrailColor.text.opacity(earned ? 0.7 : 0.4))
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity)
        .padding(12)
        .background(TrailColor.parchment)
        .overlay(
            Rectangle()
                .strokeBorder(earned ? TrailColor.coral : TrailColor.darkEarth.opacity(0.25), lineWidth: earned ? 2 : 1)
        )
    }
}
