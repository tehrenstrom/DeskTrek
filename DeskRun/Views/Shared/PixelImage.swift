import SwiftUI
import AppKit

/// Renders a pixel-art asset.
///
/// Resolution order:
/// 1. `PixelArtRegistry` — programmatic Swift-drawn sprite (preferred).
/// 2. `NSImage(named:)` — bundled PNG in Assets.xcassets, if you drop one in later.
/// 3. Magenta-bordered debug box with the asset name, so missing art is loud.
struct PixelImage: View {
    let assetName: String
    var size: CGFloat? = nil

    var body: some View {
        Group {
            if let sprite = PixelArtRegistry.all[assetName] {
                PixelSpriteView(sprite: sprite)
            } else if let nsImage = NSImage(named: assetName) {
                Image(nsImage: nsImage)
                    .interpolation(.none)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                fallback
            }
        }
        .modifier(OptionalSquareSize(size: size))
    }

    private var fallback: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 1.0, green: 0.85, blue: 0.95))
            Rectangle()
                .strokeBorder(Color(red: 1.0, green: 0.0, blue: 1.0), lineWidth: 2)
            Text(assetName)
                .font(.system(size: 8, weight: .bold, design: .monospaced))
                .foregroundColor(Color(red: 1.0, green: 0.0, blue: 1.0))
                .padding(2)
                .multilineTextAlignment(.center)
        }
    }
}

private struct OptionalSquareSize: ViewModifier {
    let size: CGFloat?
    func body(content: Content) -> some View {
        if let size {
            content.frame(width: size, height: size)
        } else {
            content
        }
    }
}
