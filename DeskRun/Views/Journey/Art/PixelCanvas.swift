import SwiftUI

/// Grid-based pixel-art API that wraps a SwiftUI `GraphicsContext`. Authors
/// draw at a fixed virtual resolution (e.g. 32×48 or 48×48); PixelCanvas
/// handles uniform scaling so the sprite fills the target view while preserving
/// crisp, integer-sized rectangles.
struct PixelCanvas {
    let ctx: GraphicsContext
    let scale: CGFloat
    let offsetX: CGFloat
    let offsetY: CGFloat

    init(ctx: GraphicsContext, scale: CGFloat, offsetX: CGFloat = 0, offsetY: CGFloat = 0) {
        self.ctx = ctx
        self.scale = scale
        self.offsetX = offsetX
        self.offsetY = offsetY
    }

    func rect(_ x: Int, _ y: Int, _ w: Int, _ h: Int, _ color: Color) {
        let path = Path(CGRect(
            x: offsetX + CGFloat(x) * scale,
            y: offsetY + CGFloat(y) * scale,
            width: CGFloat(w) * scale,
            height: CGFloat(h) * scale
        ))
        ctx.fill(path, with: .color(color))
    }

    func px(_ x: Int, _ y: Int, _ color: Color) {
        rect(x, y, 1, 1, color)
    }

    func col(_ x: Int, from y0: Int, to y1: Int, _ color: Color) {
        let lo = min(y0, y1)
        let hi = max(y0, y1)
        rect(x, lo, 1, hi - lo + 1, color)
    }

    func row(_ y: Int, from x0: Int, to x1: Int, _ color: Color) {
        let lo = min(x0, x1)
        let hi = max(x0, x1)
        rect(lo, y, hi - lo + 1, 1, color)
    }

    /// Draw a silhouette from a height array — heights[x] is the height (in pixels)
    /// of the opaque column at column x. All columns are anchored to `baselineY`.
    func silhouette(heights: [Int], baselineY: Int, color: Color) {
        for (x, h) in heights.enumerated() where h > 0 {
            col(x, from: baselineY - h + 1, to: baselineY, color)
        }
    }
}

/// A pixel sprite definition: virtual canvas size and a draw closure.
struct PixelSprite {
    let width: Int
    let height: Int
    let draw: (PixelCanvas) -> Void

    var aspectRatio: CGFloat {
        CGFloat(width) / CGFloat(height)
    }
}

/// SwiftUI view that renders a `PixelSprite` into a Canvas with correct scaling and centering.
struct PixelSpriteView: View {
    let sprite: PixelSprite
    var fill: Bool = false

    var body: some View {
        Canvas { ctx, size in
            let scaleX = size.width / CGFloat(sprite.width)
            let scaleY = size.height / CGFloat(sprite.height)
            let scale: CGFloat = fill ? max(scaleX, scaleY) : min(scaleX, scaleY)
            let totalW = scale * CGFloat(sprite.width)
            let totalH = scale * CGFloat(sprite.height)
            let canvas = PixelCanvas(
                ctx: ctx,
                scale: scale,
                offsetX: (size.width - totalW) / 2,
                offsetY: (size.height - totalH) / 2
            )
            sprite.draw(canvas)
        }
        .aspectRatio(sprite.aspectRatio, contentMode: fill ? .fill : .fit)
    }
}

// MARK: - Shared art palette

enum ArtPalette {
    // Canonical trail theme
    static let sky          = TrailColor.sky
    static let parchment    = TrailColor.parchment
    static let sand         = TrailColor.desertSand
    static let coral        = TrailColor.coral
    static let mountBlue    = TrailColor.mountainBlue
    static let green        = TrailColor.forestGreen
    static let brown        = TrailColor.darkEarth
    static let deep         = TrailColor.deepBrown

    // Extended
    static let snow         = Color(red: 0.96, green: 0.97, blue: 0.98)
    static let skin         = Color(red: 0.96, green: 0.78, blue: 0.61)
    static let sun          = Color(red: 1.00, green: 0.85, blue: 0.55)
    static let sunrise      = Color(red: 1.00, green: 0.72, blue: 0.50)
    static let grass        = Color(red: 0.45, green: 0.65, blue: 0.40)
    static let grassDark    = Color(red: 0.32, green: 0.50, blue: 0.30)
    static let water        = Color(red: 0.35, green: 0.60, blue: 0.75)
    static let waterLight   = Color(red: 0.55, green: 0.78, blue: 0.90)
    static let stone        = Color(red: 0.60, green: 0.55, blue: 0.48)
    static let stoneLight   = Color(red: 0.75, green: 0.70, blue: 0.60)
    static let stoneDark    = Color(red: 0.40, green: 0.36, blue: 0.32)
    static let mountDark    = Color(red: 0.22, green: 0.42, blue: 0.48)
    static let mountLight   = Color(red: 0.45, green: 0.68, blue: 0.75)
    static let hillDark     = Color(red: 0.30, green: 0.44, blue: 0.30)
    static let hillLight    = Color(red: 0.50, green: 0.66, blue: 0.45)
    static let treeDark     = Color(red: 0.20, green: 0.35, blue: 0.25)
    static let cloudGray    = Color(red: 0.75, green: 0.73, blue: 0.70)
    static let bear         = Color(red: 0.30, green: 0.22, blue: 0.17)
    static let paperYellow  = Color(red: 0.95, green: 0.87, blue: 0.68)
    static let metal        = Color(red: 0.70, green: 0.72, blue: 0.75)
}
