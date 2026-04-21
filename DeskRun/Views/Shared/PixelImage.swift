import SwiftUI
import AppKit

/// Renders an Image asset with nearest-neighbor interpolation for crisp pixel art.
/// Falls back to a magenta-bordered debug box when the asset is missing — so
/// content authors can see exactly which sprite IDs still need real art.
struct PixelImage: View {
    let assetName: String
    var size: CGFloat? = nil

    var body: some View {
        if let nsImage = NSImage(named: assetName) {
            Image(nsImage: nsImage)
                .interpolation(.none)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .modifier(OptionalSquareSize(size: size))
        } else {
            fallback
        }
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
        .frame(width: size ?? 48, height: size ?? 48)
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
