import SwiftUI
import AppKit

/// Horizontally tiles a pixel-art image across a given width, offset by `scrollOffset`.
/// Caller provides a scrolling speed multiplier via the offset it passes in.
struct ParallaxLayer: View {
    let assetName: String
    let width: CGFloat
    let height: CGFloat
    let scrollOffset: CGFloat
    var fallbackColor: Color = TrailColor.mountainBlue.opacity(0.3)

    var body: some View {
        GeometryReader { geo in
            if let image = NSImage(named: assetName) {
                let tileWidth = width > 0 ? width : max(image.size.width, 256)
                let modOffset = scrollOffset.truncatingRemainder(dividingBy: tileWidth)
                let start = -tileWidth - modOffset
                let tileCount = Int(ceil((geo.size.width + tileWidth * 2) / tileWidth))
                HStack(spacing: 0) {
                    ForEach(0..<tileCount, id: \.self) { _ in
                        Image(nsImage: image)
                            .interpolation(.none)
                            .resizable()
                            .frame(width: tileWidth, height: height)
                    }
                }
                .offset(x: start)
                .frame(width: geo.size.width, height: height, alignment: .leading)
                .clipped()
            } else {
                Rectangle()
                    .fill(fallbackColor)
                    .frame(height: height)
            }
        }
        .frame(height: height)
    }
}
