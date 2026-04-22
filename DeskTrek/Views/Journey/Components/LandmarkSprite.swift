import SwiftUI

struct LandmarkSprite: View {
    let landmark: Landmark
    var highlighted: Bool = false

    var body: some View {
        VStack(spacing: 4) {
            PixelImage(assetName: landmark.spriteAsset, size: landmark.isMajor ? 72 : 48)
                .shadow(
                    color: highlighted ? TrailColor.coral.opacity(0.6) : .clear,
                    radius: highlighted ? 6 : 0
                )

            Text(landmark.name.uppercased())
                .font(.system(size: landmark.isMajor ? 10 : 8, weight: .bold, design: .monospaced))
                .foregroundStyle(TrailColor.darkEarth)
                .tracking(1)
        }
    }
}
