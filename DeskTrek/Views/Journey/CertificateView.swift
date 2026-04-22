import SwiftUI

struct CertificateView: View {
    let certificate: Certificate
    let trail: Trail
    let settings: AppSettings

    private var formattedDate: String {
        let f = DateFormatter()
        f.dateStyle = .long
        return f.string(from: certificate.completedAt)
    }

    private var earnedBadges: [Badge] {
        certificate.earnedBadgeIDs.compactMap { id in
            trail.badges.first(where: { $0.id == id })
        }
    }

    var body: some View {
        ZStack {
            TrailColor.parchment

            // Decorative border frame
            Rectangle()
                .strokeBorder(TrailColor.darkEarth, lineWidth: 6)
                .padding(16)
            Rectangle()
                .strokeBorder(TrailColor.coral, lineWidth: 2)
                .padding(24)

            VStack(spacing: 20) {
                Spacer(minLength: 8)
                Text("═══ CERTIFICATE OF COMPLETION ═══")
                    .font(.system(size: 18, weight: .black, design: .monospaced))
                    .foregroundStyle(TrailColor.coral)
                    .tracking(3)

                Text(trail.name.uppercased())
                    .font(.system(size: 36, weight: .black, design: .monospaced))
                    .foregroundStyle(TrailColor.darkEarth)
                    .tracking(6)

                PixelImage(assetName: trail.finaleArt, size: 180)

                Text(trail.certificateCopy)
                    .font(.system(size: 14, weight: .medium, design: .monospaced))
                    .foregroundStyle(TrailColor.text)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 60)

                HStack(spacing: 32) {
                    statBlock(label: "DISTANCE", value: settings.distanceString(miles: certificate.totalMiles, decimals: 0))
                    statBlock(label: "DAYS", value: "\(certificate.totalDays)")
                    statBlock(label: "FINAL MORALE", value: "\(certificate.finalMorale)")
                }

                if !earnedBadges.isEmpty {
                    VStack(spacing: 6) {
                        Text("BADGES EARNED")
                            .font(.system(size: 10, weight: .bold, design: .monospaced))
                            .foregroundStyle(TrailColor.text.opacity(0.6))
                            .tracking(2)
                        HStack(spacing: 10) {
                            ForEach(earnedBadges) { badge in
                                VStack(spacing: 2) {
                                    PixelImage(assetName: badge.iconAsset, size: 32)
                                    Text(badge.name)
                                        .font(.system(size: 8, weight: .bold, design: .monospaced))
                                        .foregroundStyle(TrailColor.text.opacity(0.7))
                                }
                            }
                        }
                    }
                }

                Text(formattedDate)
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundStyle(TrailColor.text.opacity(0.6))

                Spacer(minLength: 8)
            }
            .padding(40)
        }
    }

    private func statBlock(label: String, value: String) -> some View {
        VStack(spacing: 2) {
            Text(label)
                .font(.system(size: 9, weight: .bold, design: .monospaced))
                .foregroundStyle(TrailColor.text.opacity(0.55))
                .tracking(2)
            Text(value)
                .font(.system(size: 18, weight: .black, design: .monospaced))
                .foregroundStyle(TrailColor.darkEarth)
        }
    }
}
