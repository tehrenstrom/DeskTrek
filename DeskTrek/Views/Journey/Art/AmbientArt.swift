import SwiftUI

/// Pixel-art sprites for the ambient encounters layer: transient wildlife,
/// birds, weather, and fellow hikers that drift through the trail scene.
/// Registered by key in `PixelArtRegistry.all` alongside the hiker and
/// landmark art.
enum AmbientArt {

    // MARK: - Clouds

    static let cloudSmall = PixelSprite(width: 32, height: 12) { c in
        let p = ArtPalette.self
        c.rect(3, 2, 26, 6, p.parchment)
        c.rect(0, 4, 3, 3, p.parchment)
        c.rect(29, 4, 3, 3, p.parchment)
        c.rect(6, 0, 8, 2, p.parchment)
        c.rect(18, 0, 7, 2, p.parchment)
        c.rect(3, 8, 26, 1, p.cloudGray)
        c.rect(6, 9, 8, 1, p.cloudGray.opacity(0.6))
        c.rect(18, 9, 7, 1, p.cloudGray.opacity(0.6))
    }

    static let cloudLarge = PixelSprite(width: 56, height: 18) { c in
        let p = ArtPalette.self
        c.rect(4, 4, 48, 10, p.parchment)
        c.rect(0, 7, 4, 5, p.parchment)
        c.rect(52, 7, 4, 5, p.parchment)
        c.rect(8, 1, 10, 3, p.parchment)
        c.rect(22, 0, 12, 4, p.parchment)
        c.rect(38, 2, 10, 2, p.parchment)
        // Shadow underside
        c.rect(4, 14, 48, 1, p.cloudGray)
        c.rect(8, 15, 40, 1, p.cloudGray.opacity(0.55))
    }

    // MARK: - Birds

    static let birdFlap0 = PixelSprite(width: 12, height: 6) { c in
        let p = ArtPalette.self
        // Wings up — "M" shape
        c.rect(0, 2, 2, 1, p.deep)
        c.rect(2, 1, 2, 1, p.deep)
        c.rect(4, 0, 2, 1, p.deep)
        c.rect(6, 0, 2, 1, p.deep)
        c.rect(8, 1, 2, 1, p.deep)
        c.rect(10, 2, 2, 1, p.deep)
        // Body
        c.rect(5, 2, 2, 1, p.deep)
    }

    static let birdFlap1 = PixelSprite(width: 12, height: 6) { c in
        let p = ArtPalette.self
        // Wings down — wider "∨" shape
        c.rect(0, 1, 2, 1, p.deep)
        c.rect(2, 2, 2, 1, p.deep)
        c.rect(4, 3, 2, 1, p.deep)
        c.rect(6, 3, 2, 1, p.deep)
        c.rect(8, 2, 2, 1, p.deep)
        c.rect(10, 1, 2, 1, p.deep)
        // Body
        c.rect(5, 2, 2, 1, p.deep)
    }

    static let birdFlock = PixelSprite(width: 26, height: 8) { c in
        let p = ArtPalette.self
        // Three tiny V's at varying heights
        drawLittleV(c, cx: 3, cy: 5, color: p.deep)
        drawLittleV(c, cx: 12, cy: 2, color: p.deep)
        drawLittleV(c, cx: 21, cy: 4, color: p.deep)
    }

    private static func drawLittleV(_ c: PixelCanvas, cx: Int, cy: Int, color: Color) {
        c.px(cx - 2, cy, color)
        c.px(cx - 1, cy + 1, color)
        c.px(cx, cy, color)
        c.px(cx + 1, cy + 1, color)
        c.px(cx + 2, cy, color)
    }

    static let eagleGlide = PixelSprite(width: 20, height: 6) { c in
        let p = ArtPalette.self
        // Long spread wings, slight M dip at body
        c.rect(0, 2, 2, 1, p.deep)
        c.rect(2, 1, 4, 1, p.deep)
        c.rect(6, 2, 3, 1, p.deep)
        c.rect(9, 2, 2, 2, p.deep)   // body
        c.rect(11, 2, 3, 1, p.deep)
        c.rect(14, 1, 4, 1, p.deep)
        c.rect(18, 2, 2, 1, p.deep)
        // Feather tips drop one pixel
        c.px(0, 3, p.deep)
        c.px(19, 3, p.deep)
    }

    static let raven = PixelSprite(width: 14, height: 8) { c in
        let p = ArtPalette.self
        // Body
        c.rect(5, 3, 5, 3, p.deep)
        // Head + beak
        c.rect(9, 2, 3, 2, p.deep)
        c.rect(12, 3, 1, 1, p.deep)
        // Wings tucked up/forward
        c.rect(2, 2, 3, 2, p.deep)
        c.rect(0, 3, 2, 1, p.deep)
        // Tail
        c.rect(3, 4, 2, 1, p.deep)
        // Feet
        c.px(6, 6, p.deep)
        c.px(8, 6, p.deep)
    }

    // MARK: - Ground creatures

    static let marmotSit = PixelSprite(width: 16, height: 12) { c in
        let p = ArtPalette.self
        // Rock
        c.rect(1, 9, 14, 3, p.stone)
        c.rect(2, 8, 12, 1, p.stoneLight)
        c.rect(1, 11, 14, 1, p.stoneDark)
        // Body
        c.rect(5, 5, 6, 4, p.brown)
        c.rect(4, 6, 1, 3, p.brown)
        // Head
        c.rect(9, 3, 4, 3, p.brown)
        // Ear
        c.px(12, 2, p.brown)
        // Eye
        c.px(11, 4, p.deep)
        // Nose
        c.px(13, 5, p.deep)
        // Belly highlight
        c.rect(6, 7, 4, 1, p.sand)
        // Tail curl
        c.px(4, 5, p.brown)
        c.px(3, 6, p.brown)
    }

    static let deerStand = PixelSprite(width: 22, height: 18) { c in
        let p = ArtPalette.self
        // Body
        c.rect(5, 7, 12, 5, p.sand)
        c.rect(6, 6, 10, 1, p.sand)
        // Belly shadow
        c.rect(6, 11, 10, 1, p.brown)
        // Neck + head
        c.rect(15, 4, 2, 4, p.sand)
        c.rect(16, 3, 3, 2, p.sand)
        // Ear
        c.px(17, 2, p.sand)
        c.px(18, 2, p.sand)
        // Muzzle
        c.px(19, 4, p.brown)
        // Eye
        c.px(17, 4, p.deep)
        // Legs
        c.rect(6, 12, 1, 5, p.sand)
        c.rect(9, 12, 1, 5, p.sand)
        c.rect(13, 12, 1, 5, p.sand)
        c.rect(16, 12, 1, 5, p.sand)
        // Hooves
        c.px(6, 17, p.deep)
        c.px(9, 17, p.deep)
        c.px(13, 17, p.deep)
        c.px(16, 17, p.deep)
        // Tail
        c.px(4, 7, p.sand)
        c.px(4, 8, p.sand)
    }

    static let squirrelRun0 = PixelSprite(width: 12, height: 10) { c in
        let p = ArtPalette.self
        // Body
        c.rect(3, 4, 5, 3, p.brown)
        // Head
        c.rect(7, 3, 3, 3, p.brown)
        // Ear
        c.px(9, 2, p.brown)
        // Eye
        c.px(9, 4, p.deep)
        // Tail arch up
        c.rect(0, 2, 3, 1, p.brown)
        c.rect(0, 3, 1, 3, p.brown)
        c.px(2, 1, p.brown)
        // Front leg forward
        c.px(8, 7, p.brown)
        c.px(8, 8, p.brown)
        // Back leg back
        c.px(3, 7, p.brown)
        c.px(3, 8, p.brown)
    }

    static let squirrelRun1 = PixelSprite(width: 12, height: 10) { c in
        let p = ArtPalette.self
        // Body (slightly hunched)
        c.rect(3, 5, 5, 3, p.brown)
        // Head
        c.rect(7, 4, 3, 3, p.brown)
        c.px(9, 3, p.brown)
        c.px(9, 5, p.deep)
        // Tail — higher arch
        c.rect(0, 1, 3, 1, p.brown)
        c.rect(0, 2, 1, 3, p.brown)
        c.px(2, 0, p.brown)
        // Legs tucked
        c.px(4, 8, p.brown)
        c.px(7, 8, p.brown)
    }

    static let hikerDistant0 = PixelSprite(width: 10, height: 14) { c in
        let p = ArtPalette.self
        // Head
        c.rect(3, 0, 4, 2, p.deep)      // hat
        c.rect(3, 2, 4, 2, p.skin)      // face
        // Body / pack
        c.rect(2, 4, 6, 5, p.green)
        c.rect(3, 5, 4, 1, p.coral)     // strap color suggestion
        // Legs in mid-stride
        c.rect(3, 9, 1, 4, p.mountBlue)
        c.rect(6, 9, 1, 4, p.mountBlue)
        // Boots
        c.px(3, 13, p.deep)
        c.px(6, 13, p.deep)
    }

    static let hikerDistant1 = PixelSprite(width: 10, height: 14) { c in
        let p = ArtPalette.self
        // Head
        c.rect(3, 0, 4, 2, p.deep)
        c.rect(3, 2, 4, 2, p.skin)
        // Body
        c.rect(2, 4, 6, 5, p.green)
        c.rect(3, 5, 4, 1, p.coral)
        // Legs together (other half of stride)
        c.rect(4, 9, 2, 4, p.mountBlue)
        // Boots
        c.px(4, 13, p.deep)
        c.px(5, 13, p.deep)
        // Slight bob — hat one pixel lower
        c.px(3, 0, Color.clear)
    }

    static let butterfly0 = PixelSprite(width: 10, height: 8) { c in
        let p = ArtPalette.self
        // Open wings
        c.rect(0, 1, 3, 3, p.coral)
        c.rect(7, 1, 3, 3, p.coral)
        c.rect(0, 4, 3, 2, p.sunrise)
        c.rect(7, 4, 3, 2, p.sunrise)
        // Body
        c.rect(4, 2, 2, 4, p.deep)
        // Antennae
        c.px(4, 0, p.deep)
        c.px(5, 0, p.deep)
    }

    static let butterfly1 = PixelSprite(width: 10, height: 8) { c in
        let p = ArtPalette.self
        // Closed (side) wings
        c.rect(2, 2, 2, 3, p.coral)
        c.rect(6, 2, 2, 3, p.coral)
        c.rect(2, 5, 2, 1, p.sunrise)
        c.rect(6, 5, 2, 1, p.sunrise)
        // Body
        c.rect(4, 2, 2, 4, p.deep)
        // Antennae
        c.px(4, 0, p.deep)
        c.px(5, 0, p.deep)
    }

    static let pika = PixelSprite(width: 10, height: 8) { c in
        let p = ArtPalette.self
        // Body
        c.rect(2, 3, 6, 4, p.stoneLight)
        // Head
        c.rect(6, 2, 3, 3, p.stoneLight)
        // Ears (round, prominent)
        c.rect(7, 0, 1, 2, p.stoneLight)
        c.rect(5, 0, 1, 2, p.stoneLight)
        // Eye
        c.px(8, 3, p.deep)
        // Nose
        c.px(9, 4, p.deep)
        // Feet
        c.px(3, 7, p.deep)
        c.px(6, 7, p.deep)
    }

    static let bearDistant = PixelSprite(width: 26, height: 16) { c in
        let p = ArtPalette.self
        // Body bulk
        c.rect(4, 7, 14, 6, p.bear)
        c.rect(3, 8, 1, 4, p.bear)
        c.rect(18, 8, 1, 4, p.bear)
        // Head
        c.rect(17, 5, 5, 4, p.bear)
        // Ears
        c.rect(17, 3, 2, 2, p.bear)
        c.rect(20, 3, 2, 2, p.bear)
        // Snout
        c.rect(22, 6, 2, 2, p.bear)
        c.px(24, 7, p.deep)
        // Legs
        c.rect(4, 13, 3, 2, p.bear)
        c.rect(15, 13, 3, 2, p.bear)
        // Shadow
        c.rect(4, 15, 14, 1, p.deep.opacity(0.4))
    }

    // MARK: - Weather sheets (full-width)

    /// Rain — drawn as scattered diagonal streaks on a thin transparent layer.
    /// The ambient layer tiles this sprite horizontally; `x` seeding handled
    /// by the view via `.offset`.
    static let rainSheet = PixelSprite(width: 48, height: 32) { c in
        let p = ArtPalette.self
        let drops: [(Int, Int)] = [
            (2, 1), (7, 5), (11, 2), (15, 8), (19, 4), (23, 12),
            (27, 7), (31, 2), (35, 10), (39, 5), (43, 14), (4, 18),
            (9, 21), (14, 16), (20, 22), (25, 19), (30, 24), (37, 18),
            (42, 23), (6, 27), (18, 28), (32, 27)
        ]
        for (x, y) in drops {
            c.px(x, y, p.water.opacity(0.75))
            c.px(x + 1, y + 1, p.water.opacity(0.55))
            c.px(x + 2, y + 2, p.water.opacity(0.35))
        }
    }

    /// Snow — soft drifting dots.
    static let snowSheet = PixelSprite(width: 48, height: 32) { c in
        let p = ArtPalette.self
        let flakes: [(Int, Int)] = [
            (3, 2), (9, 6), (14, 3), (19, 9), (24, 5), (29, 13),
            (34, 8), (39, 3), (44, 11), (6, 17), (12, 20), (17, 15),
            (22, 22), (27, 18), (33, 24), (38, 17), (43, 22), (8, 27),
            (21, 28), (35, 27), (46, 5)
        ]
        for (x, y) in flakes {
            c.px(x, y, p.snow.opacity(0.9))
            c.px(x + 1, y, p.snow.opacity(0.6))
            c.px(x, y + 1, p.snow.opacity(0.6))
        }
    }
}
