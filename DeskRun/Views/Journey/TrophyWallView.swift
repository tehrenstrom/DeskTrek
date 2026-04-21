import SwiftUI

struct TrophyWallView: View {
    let appState: AppState

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                Text("TROPHY WALL")
                    .font(.system(size: 20, weight: .black, design: .monospaced))
                    .foregroundStyle(TrailColor.darkEarth)
                    .tracking(3)

                if appState.journeyStore.trophies.isEmpty {
                    emptyState
                } else {
                    ForEach(appState.journeyStore.trophies) { trophy in
                        trophyRow(trophy)
                    }
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
            Text("No trails completed yet")
                .font(.system(size: 13, weight: .bold, design: .monospaced))
                .foregroundStyle(TrailColor.text.opacity(0.6))
            Text("Complete a journey and your certificate will appear here.")
                .font(.system(size: 11, design: .monospaced))
                .foregroundStyle(TrailColor.text.opacity(0.4))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 60)
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
                Text(String(format: "%.0f mi  \u{00B7}  %d days  \u{00B7}  \(formattedDate(trophy.completedAt))", trophy.totalMiles, trophy.totalDays))
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
