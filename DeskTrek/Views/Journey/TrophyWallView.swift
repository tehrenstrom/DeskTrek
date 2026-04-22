import SwiftUI

struct TrophyWallView: View {
    let appState: AppState

    private var portraits: [TrailPortrait] {
        appState.journeyStore.portraits.sorted { $0.collectedAt > $1.collectedAt }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                Text("TROPHY WALL")
                    .font(.system(size: 20, weight: .black, design: .monospaced))
                    .foregroundStyle(TrailColor.darkEarth)
                    .tracking(3)

                if appState.journeyStore.trophies.isEmpty && portraits.isEmpty {
                    emptyState
                }

                if !portraits.isEmpty {
                    portraitsSection
                }

                if !appState.journeyStore.trophies.isEmpty {
                    certificatesSection
                }
            }
            .padding(24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(TrailColor.parchment)
        .navigationTitle("Trophy Wall")
    }

    @ViewBuilder
    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "rosette")
                .font(.system(size: 40))
                .foregroundStyle(TrailColor.text.opacity(0.25))
            Text("Nothing collected yet")
                .font(.system(size: 13, weight: .bold, design: .monospaced))
                .foregroundStyle(TrailColor.text.opacity(0.6))
            Text("Pass a landmark on the trail and its portrait arrives here. Finish the trail and you earn a certificate.")
                .font(.system(size: 11, design: .monospaced))
                .foregroundStyle(TrailColor.text.opacity(0.4))
                .multilineTextAlignment(.center)
                .frame(maxWidth: 380)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 60)
    }

    // MARK: - Portraits

    private var portraitsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader("TRAIL PORTRAITS", subtitle: "\(portraits.count) collected")

            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 130, maximum: 200), spacing: 14)],
                spacing: 14
            ) {
                ForEach(portraits) { portrait in
                    portraitCard(portrait)
                }
            }
        }
    }

    @ViewBuilder
    private func portraitCard(_ portrait: TrailPortrait) -> some View {
        let trail = TrailCatalog.trail(for: portrait.trailID)
        let landmark = trail?.landmarks.first(where: { $0.id == portrait.landmarkID })

        VStack(spacing: 6) {
            // Framed portrait with subtle matte
            ZStack {
                Rectangle()
                    .fill(TrailColor.parchment)
                    .overlay(
                        Rectangle()
                            .strokeBorder(TrailColor.darkEarth.opacity(0.4), lineWidth: 1)
                    )
                    .aspectRatio(1, contentMode: .fit)

                PixelImage(assetName: landmark?.spriteAsset ?? "", size: 88)
                    .padding(6)
            }
            .aspectRatio(1, contentMode: .fit)

            Text((landmark?.name ?? "Unknown Landmark").uppercased())
                .font(.system(size: 10, weight: .bold, design: .monospaced))
                .foregroundStyle(TrailColor.darkEarth)
                .tracking(1)
                .multilineTextAlignment(.center)
                .lineLimit(2)

            Text((trail?.name ?? portrait.trailID))
                .font(.system(size: 9, design: .monospaced))
                .foregroundStyle(TrailColor.text.opacity(0.55))

            Text(formattedDate(portrait.collectedAt))
                .font(.system(size: 9, design: .monospaced))
                .foregroundStyle(TrailColor.text.opacity(0.45))
        }
        .padding(10)
        .background(TrailColor.parchment)
        .overlay(
            Rectangle()
                .strokeBorder(TrailColor.coral.opacity(0.6), lineWidth: 2)
        )
    }

    // MARK: - Certificates

    private var certificatesSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionHeader("CERTIFICATES", subtitle: "\(appState.journeyStore.trophies.count) earned")
            ForEach(appState.journeyStore.trophies) { trophy in
                trophyRow(trophy)
            }
        }
    }

    private func trophyRow(_ trophy: Certificate) -> some View {
        let trail = TrailCatalog.trail(for: trophy.trailID)
        return HStack(spacing: 14) {
            if let trail {
                PixelImage(assetName: trail.finaleArt, size: 72)
            } else {
                Rectangle()
                    .fill(TrailColor.desertSand)
                    .frame(width: 72, height: 72)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text((trail?.name ?? trophy.trailID).uppercased())
                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                    .foregroundStyle(TrailColor.darkEarth)
                    .tracking(1)
                Text("\(appState.settings.distanceString(miles: trophy.totalMiles, decimals: 0))  \u{00B7}  \(trophy.totalDays) days  \u{00B7}  \(formattedDate(trophy.completedAt))")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(TrailColor.text.opacity(0.6))
                if !trophy.earnedBadgeIDs.isEmpty {
                    Text("\(trophy.earnedBadgeIDs.count) badges earned")
                        .font(.system(size: 10, design: .monospaced))
                        .foregroundStyle(TrailColor.forestGreen)
                }
            }

            Spacer()

            if let url = pdfURL(for: trophy) {
                Button("Open PDF") { NSWorkspace.shared.open(url) }
                    .buttonStyle(RetroSecondaryButtonStyle())
                Button("Reveal") { NSWorkspace.shared.activateFileViewerSelecting([url]) }
                    .buttonStyle(RetroSecondaryButtonStyle())
            }
        }
        .retroPanel()
    }

    // MARK: - Shared

    private func sectionHeader(_ title: String, subtitle: String) -> some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
                .font(.system(size: 13, weight: .bold, design: .monospaced))
                .foregroundStyle(TrailColor.darkEarth)
                .tracking(2)
            Text(subtitle)
                .font(.system(size: 10, design: .monospaced))
                .foregroundStyle(TrailColor.text.opacity(0.55))
            Spacer()
        }
    }

    private func pdfURL(for trophy: Certificate) -> URL? {
        guard let name = trophy.pdfFileName else { return nil }
        let url = appState.dataManager.certificatesDir.appendingPathComponent(name)
        return FileManager.default.fileExists(atPath: url.path) ? url : nil
    }

    private func formattedDate(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateStyle = .medium
        return f.string(from: date)
    }
}
