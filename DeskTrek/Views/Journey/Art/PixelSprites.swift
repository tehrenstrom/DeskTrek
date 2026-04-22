import SwiftUI

/// Registry of programmatic pixel-art sprites keyed by asset name.
/// `PixelImage` and `ParallaxLayer` look up art here first; when a key is
/// missing they fall back to `Assets.xcassets` (or the magenta debug box).
enum PixelArtRegistry {
    static let all: [String: PixelSprite] = [
        // Hiker walk cycle (4 frames)
        "hiker.walk.0": HikerArt.frame0,
        "hiker.walk.1": HikerArt.frame1,
        "hiker.walk.2": HikerArt.frame2,
        "hiker.walk.3": HikerArt.frame3,

        // Landmarks — John Muir Trail
        "landmark.jmt.happy_isles":          LandmarkArt.happyIsles,
        "landmark.jmt.half_dome":            LandmarkArt.halfDome,
        "landmark.jmt.cathedral_peak":       LandmarkArt.cathedralPeak,
        "landmark.jmt.tuolumne_meadows":     LandmarkArt.tuolumneMeadows,
        "landmark.jmt.thousand_island_lake": LandmarkArt.thousandIslandLake,
        "landmark.jmt.muir_pass":            LandmarkArt.muirPass,
        "landmark.jmt.forester_pass":        LandmarkArt.foresterPass,
        "landmark.jmt.mt_whitney":           LandmarkArt.mtWhitney,

        // Badges
        "badge.cautious_hiker":       BadgeArt.cautiousHiker,
        "badge.trailblazer":          BadgeArt.trailblazer,
        "badge.good_samaritan":       BadgeArt.goodSamaritan,
        "badge.storm_chaser":         BadgeArt.stormChaser,
        "badge.peak_bagger":          BadgeArt.peakBagger,
        "badge.ultralight":           BadgeArt.ultralight,
        "badge.lost_hiker_saved":     BadgeArt.lostHikerSaved,
        "badge.bear_canister_master": BadgeArt.bearCanisterMaster,
        "badge.sierra_storyteller":   BadgeArt.sierraStoryteller,

        // Parallax layers
        "parallax.jmt.sky":       ParallaxArt.skyJMT,
        "parallax.jmt.mountains": ParallaxArt.mountainsJMT,
        "parallax.jmt.hills":     ParallaxArt.hillsJMT,
        "parallax.jmt.ground":    ParallaxArt.groundJMT,

        // Finale hero scene
        "finale.jmt": FinaleArt.jmt,

        // Landmarks — Wonderland Trail
        "landmark.wonder.longmire":           LandmarkArtWonder.longmire,
        "landmark.wonder.cougar_rock_bridge": LandmarkArtWonder.cougarRockBridge,
        "landmark.wonder.emerald_ridge":      LandmarkArtWonder.emeraldRidge,
        "landmark.wonder.klapatche_park":     LandmarkArtWonder.klapatchePark,
        "landmark.wonder.spray_park":         LandmarkArtWonder.sprayPark,
        "landmark.wonder.mystic_lake":        LandmarkArtWonder.mysticLake,
        "landmark.wonder.summerland":         LandmarkArtWonder.summerland,
        "landmark.wonder.panhandle_gap":      LandmarkArtWonder.panhandleGap,

        // Parallax layers — Wonderland
        "parallax.wonder.sky":       ParallaxArtWonder.sky,
        "parallax.wonder.mountains": ParallaxArtWonder.mountains,
        "parallax.wonder.hills":     ParallaxArtWonder.hills,
        "parallax.wonder.ground":    ParallaxArtWonder.ground,

        // Finale — Wonderland
        "finale.wonder": FinaleArtWonder.wonder,

        // Badges — Wonderland
        "badge.wonder.volcano_circler": BadgeArtWonder.volcanoCircler,
        "badge.wonder.rangers_friend":  BadgeArtWonder.rangersFriend,
        "badge.wonder.weather_eye":     BadgeArtWonder.weatherEye,

        // Landmarks — Superior Hiking Trail
        "landmark.sht.jay_cooke":             LandmarkArtSHT.jayCooke,
        "landmark.sht.enger_park":            LandmarkArtSHT.engerPark,
        "landmark.sht.gooseberry_falls":      LandmarkArtSHT.gooseberryFalls,
        "landmark.sht.split_rock_lighthouse": LandmarkArtSHT.splitRockLighthouse,
        "landmark.sht.palisade_head":         LandmarkArtSHT.palisadeHead,
        "landmark.sht.temperance_river":      LandmarkArtSHT.temperanceRiver,
        "landmark.sht.carlton_peak":          LandmarkArtSHT.carltonPeak,
        "landmark.sht.bean_bear_lakes":       LandmarkArtSHT.beanBearLakes,
        "landmark.sht.caribou_falls":         LandmarkArtSHT.caribouFalls,
        "landmark.sht.grand_portage":         LandmarkArtSHT.grandPortage,

        // Parallax layers — Superior Hiking
        "parallax.sht.sky":       ParallaxArtSHT.sky,
        "parallax.sht.mountains": ParallaxArtSHT.mountains,
        "parallax.sht.hills":     ParallaxArtSHT.hills,
        "parallax.sht.ground":    ParallaxArtSHT.ground,

        // Finale — Superior Hiking
        "finale.sht": FinaleArtSHT.sht,

        // Badges — Superior Hiking
        "badge.sht.gitchi_gumi_walker":      BadgeArtSHT.gitchiGumiWalker,
        "badge.sht.lighthouse_friend":       BadgeArtSHT.lighthouseFriend,
        "badge.sht.moose_tracker":           BadgeArtSHT.mooseTracker,
        "badge.sht.north_shore_chronicler":  BadgeArtSHT.northShoreChronicler,

        // Ambient encounters (wildlife, weather, fellow hikers)
        "ambient.cloud.small":      AmbientArt.cloudSmall,
        "ambient.cloud.large":      AmbientArt.cloudLarge,
        "ambient.bird.flap.0":      AmbientArt.birdFlap0,
        "ambient.bird.flap.1":      AmbientArt.birdFlap1,
        "ambient.bird.flock":       AmbientArt.birdFlock,
        "ambient.eagle.glide":      AmbientArt.eagleGlide,
        "ambient.raven":            AmbientArt.raven,
        "ambient.marmot.sit":       AmbientArt.marmotSit,
        "ambient.deer.stand":       AmbientArt.deerStand,
        "ambient.squirrel.run.0":   AmbientArt.squirrelRun0,
        "ambient.squirrel.run.1":   AmbientArt.squirrelRun1,
        "ambient.hiker.distant.0":  AmbientArt.hikerDistant0,
        "ambient.hiker.distant.1":  AmbientArt.hikerDistant1,
        "ambient.butterfly.0":      AmbientArt.butterfly0,
        "ambient.butterfly.1":      AmbientArt.butterfly1,
        "ambient.pika":             AmbientArt.pika,
        "ambient.bear.distant":     AmbientArt.bearDistant,
        "ambient.rain.sheet":       AmbientArt.rainSheet,
        "ambient.snow.sheet":       AmbientArt.snowSheet
    ]
}

// MARK: - Hiker walk cycle (32×48)

private enum HikerArt {
    // Draw everything above the feet. Legs/boots drawn by each frame.
    static func upperBody(_ c: PixelCanvas, bob: Int = 0) {
        let p = ArtPalette.self
        // Hat crown
        c.rect(12, 1 + bob, 8, 1, p.deep)
        c.rect(11, 2 + bob, 10, 3, p.deep)
        // Hat brim (wider)
        c.rect(9, 5 + bob, 14, 1, p.deep)
        c.rect(10, 6 + bob, 12, 1, p.brown)
        // Face
        c.rect(12, 7 + bob, 8, 4, p.skin)
        // Eyes
        c.px(14, 9 + bob, p.deep)
        c.px(17, 9 + bob, p.deep)
        // Chin shadow
        c.rect(13, 10 + bob, 6, 1, p.brown)
        // Neck
        c.rect(14, 11 + bob, 4, 1, p.skin)
        // Pack peeking above shoulders
        c.rect(13, 11 + bob, 6, 2, p.green)
        c.rect(14, 10 + bob, 4, 1, p.green)
        // Torso / shirt
        c.rect(11, 13 + bob, 10, 11, p.coral)
        // Pack straps over shoulders
        c.rect(11, 13 + bob, 1, 11, p.mountBlue)
        c.rect(20, 13 + bob, 1, 11, p.mountBlue)
        // Chest horizontal strap
        c.rect(11, 17 + bob, 10, 1, p.mountBlue)
        // Arms
        c.rect(9, 14 + bob, 2, 9, p.coral)
        c.rect(21, 14 + bob, 2, 9, p.coral)
        // Hands
        c.rect(9, 23 + bob, 2, 2, p.skin)
        c.rect(21, 23 + bob, 2, 2, p.skin)
        // Belt
        c.rect(11, 24 + bob, 10, 1, p.brown)
    }

    static let frame0 = PixelSprite(width: 32, height: 48) { c in
        let p = ArtPalette.self
        upperBody(c, bob: 0)
        // Passing stance — feet close together
        c.rect(12, 25, 3, 13, p.mountBlue)
        c.rect(17, 25, 3, 13, p.mountBlue)
        // Boots
        c.rect(11, 38, 5, 3, p.deep)
        c.rect(16, 38, 5, 3, p.deep)
    }

    static let frame1 = PixelSprite(width: 32, height: 48) { c in
        let p = ArtPalette.self
        upperBody(c, bob: -1)
        // Step right — left leg back & bent, right leg forward
        // Back leg
        c.rect(11, 25, 3, 10, p.mountBlue)
        c.rect(9, 35, 5, 3, p.mountBlue)  // angled back
        c.rect(8, 38, 4, 2, p.deep)        // back boot
        // Front leg
        c.rect(18, 25, 3, 11, p.mountBlue)
        c.rect(19, 36, 4, 2, p.mountBlue)  // angled forward
        c.rect(20, 38, 5, 3, p.deep)        // front boot
    }

    static let frame2 = PixelSprite(width: 32, height: 48) { c in
        let p = ArtPalette.self
        upperBody(c, bob: 0)
        // Mirror of frame0 — passing stance (slightly different for variation)
        c.rect(13, 25, 3, 13, p.mountBlue)
        c.rect(16, 25, 3, 13, p.mountBlue)
        // Boots slightly apart
        c.rect(12, 38, 4, 3, p.deep)
        c.rect(16, 38, 4, 3, p.deep)
    }

    static let frame3 = PixelSprite(width: 32, height: 48) { c in
        let p = ArtPalette.self
        upperBody(c, bob: -1)
        // Step left — mirror of frame1
        // Back leg (right back)
        c.rect(18, 25, 3, 10, p.mountBlue)
        c.rect(18, 35, 5, 3, p.mountBlue)
        c.rect(20, 38, 4, 2, p.deep)
        // Front leg (left forward)
        c.rect(11, 25, 3, 11, p.mountBlue)
        c.rect(9, 36, 4, 2, p.mountBlue)
        c.rect(7, 38, 5, 3, p.deep)
    }
}

// MARK: - Landmarks (48×48 each)

private enum LandmarkArt {
    // Draws a small pine tree at position (x, y) where y is the bottom.
    static func pine(_ c: PixelCanvas, x: Int, y: Int, size: Int = 3) {
        let p = ArtPalette.self
        c.rect(x, y - size, 1, size, p.treeDark)
        c.rect(x - 1, y - size + 1, 3, 1, p.green)
        if size >= 3 {
            c.rect(x - 1, y - 1, 3, 1, p.green)
        }
    }

    static let happyIsles = PixelSprite(width: 48, height: 48) { c in
        let p = ArtPalette.self
        // Sky
        c.rect(0, 0, 48, 28, p.sky)
        // Forest backdrop
        c.rect(0, 20, 48, 10, p.treeDark)
        for x in stride(from: 0, to: 48, by: 4) {
            c.rect(x, 17, 3, 4, p.green)
        }
        // Distant peaks
        c.rect(5, 12, 10, 8, p.mountDark)
        c.rect(7, 10, 6, 2, p.mountLight)
        c.rect(28, 14, 12, 6, p.mountDark)
        c.rect(30, 12, 8, 2, p.mountLight)
        // Water / river flowing under
        c.rect(0, 34, 48, 10, p.water)
        c.rect(0, 34, 48, 1, p.waterLight)
        c.rect(0, 38, 48, 1, p.waterLight)
        c.rect(0, 42, 48, 1, p.waterLight)
        // Stone bridge — arch
        c.rect(8, 26, 32, 8, p.stone)
        c.rect(8, 25, 32, 1, p.stoneLight)
        c.rect(10, 27, 28, 1, p.stoneDark)
        // Bridge railings
        c.rect(8, 24, 2, 2, p.stoneDark)
        c.rect(38, 24, 2, 2, p.stoneDark)
        for x in stride(from: 11, to: 38, by: 3) {
            c.rect(x, 22, 1, 3, p.stoneDark)
        }
        c.rect(10, 21, 28, 1, p.stoneDark)
        // Arch opening
        c.rect(19, 30, 10, 4, p.deep)
        c.rect(20, 29, 8, 1, p.deep)
        // Ground at bridge ends
        c.rect(0, 32, 8, 4, p.grassDark)
        c.rect(40, 32, 8, 4, p.grassDark)
        c.rect(0, 30, 8, 2, p.grass)
        c.rect(40, 30, 8, 2, p.grass)
        // Water ripples under the arch
        c.rect(20, 40, 2, 1, p.waterLight)
        c.rect(24, 41, 3, 1, p.waterLight)
        c.rect(28, 39, 2, 1, p.waterLight)
    }

    static let halfDome = PixelSprite(width: 48, height: 48) { c in
        let p = ArtPalette.self
        // Sky
        c.rect(0, 0, 48, 44, p.sky)
        // Ground strip
        c.rect(0, 42, 48, 6, p.grassDark)
        c.rect(0, 40, 48, 2, p.grass)
        // Distant peak (right, behind)
        let farPeak: [Int] = Array(repeating: 0, count: 28) + [0, 2, 5, 8, 11, 9, 6, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        c.silhouette(heights: Array(farPeak.prefix(48)), baselineY: 40, color: p.mountDark)
        // Half Dome — flat cliff on the left, dome curving down to the right
        let dome: [Int] = [
            0,  0,  0,  0,  0,  0,                       //  0–5
            6,  11, 17, 22, 25, 28,                      //  6–11 cliff rising
            30, 31, 31, 31, 31, 31,                      // 12–17 flat top
            31, 31, 31, 31, 31, 30,                      // 18–23
            29, 28, 27, 25, 23, 21,                      // 24–29
            18, 15, 12,  9,  6,  4,                      // 30–35 sloping right
            2,  1,  0,  0,  0,  0,                       // 36–41
            0,  0,  0,  0,  0,  0                        // 42–47
        ]
        c.silhouette(heights: dome, baselineY: 40, color: p.stone)
        // Shadow side (cliff face)
        for x in 7...11 {
            let top = 40 - dome[x] + 1
            c.col(x, from: top, to: 40, p.stoneDark)
        }
        c.col(12, from: 10, to: 40, p.stoneDark)
        // Vertical crack lines on cliff
        c.col(8, from: 18, to: 38, p.deep)
        c.col(10, from: 16, to: 38, p.deep)
        // Highlight top edge
        c.row(9, from: 13, to: 28, p.stoneLight)
        c.row(10, from: 12, to: 29, p.stoneLight)
        // Snow on the summit
        c.row(8, from: 15, to: 26, p.snow)
        c.row(7, from: 17, to: 24, p.snow)
        // Trees at base
        pine(c, x: 2, y: 42)
        pine(c, x: 5, y: 42, size: 4)
        pine(c, x: 43, y: 42, size: 4)
        pine(c, x: 46, y: 42)
    }

    static let cathedralPeak = PixelSprite(width: 48, height: 48) { c in
        let p = ArtPalette.self
        c.rect(0, 0, 48, 44, p.sky)
        c.rect(0, 42, 48, 6, p.grassDark)
        c.rect(0, 40, 48, 2, p.grass)
        // Rocky base
        c.rect(4, 32, 40, 9, p.stone)
        c.rect(4, 31, 40, 1, p.stoneLight)
        // Left (taller) spire
        let spireL: [Int] = [
            0,0,0,0,0,0,0,0,0,0,0,0,
            0,0,0,0,0,4,8,12,16,20,22,24,    // x=12-23 rising
            26,28,30,32,30,28,26,24,          // x=24-31 peak
            22,20,18,16,14,12,10,8,6,4,2,0,0,0,0,0
        ]
        c.silhouette(heights: spireL, baselineY: 40, color: p.stoneDark)
        // Right (shorter) spire
        let spireR: [Int] = [
            0,0,0,0,0,0,0,0,0,0,0,0,
            0,0,0,0,0,0,0,0,0,0,0,0,
            0,0,0,0,0,0,0,0,
            0,0,0,0,0,3,6,10,13,16,19,21,22,22,20,16
        ]
        c.silhouette(heights: spireR, baselineY: 40, color: p.stone)
        // Highlights on the tall spire
        c.rect(27, 10, 2, 8, p.stoneLight)
        c.rect(25, 14, 2, 6, p.stoneLight)
        // Snow dabs near peaks
        c.px(28, 9, p.snow)
        c.px(27, 10, p.snow)
        c.px(43, 19, p.snow)
        c.px(42, 20, p.snow)
        // Forest at base
        pine(c, x: 2, y: 41, size: 3)
        pine(c, x: 5, y: 41, size: 4)
        pine(c, x: 8, y: 41, size: 3)
        pine(c, x: 38, y: 41, size: 3)
        pine(c, x: 41, y: 41, size: 4)
        pine(c, x: 45, y: 41, size: 3)
    }

    static let tuolumneMeadows = PixelSprite(width: 48, height: 48) { c in
        let p = ArtPalette.self
        // Sky
        c.rect(0, 0, 48, 20, p.sky)
        // Distant granite peaks
        let peaks: [Int] = [
            2, 4, 6, 8, 10, 12, 10, 8,
            6, 4, 2, 3, 6, 8, 10, 11,
            10, 9, 8, 7, 6, 6, 8, 10,
            12, 14, 12, 10, 8, 6, 4, 3,
            4, 6, 8, 10, 12, 14, 13, 11,
            9, 7, 5, 3, 2, 2, 1, 0
        ]
        c.silhouette(heights: peaks, baselineY: 22, color: p.mountBlue)
        // Snow on highest peaks
        for x in 0..<48 where peaks[x] >= 12 {
            c.px(x, 22 - peaks[x] + 1, p.snow)
            c.px(x, 22 - peaks[x] + 2, p.snow)
        }
        // Tree line
        c.rect(0, 22, 48, 3, p.treeDark)
        for x in stride(from: 0, to: 48, by: 3) {
            c.rect(x, 20, 2, 3, p.green)
        }
        // Meadow
        c.rect(0, 25, 48, 23, p.grass)
        // Grass detail strokes
        for x in stride(from: 1, to: 48, by: 4) {
            c.px(x, 27, p.grassDark)
            c.px(x + 2, 29, p.grassDark)
            c.px(x, 31, p.grassDark)
        }
        // Lyell Fork (winding river)
        c.rect(2, 34, 44, 3, p.water)
        c.rect(2, 34, 44, 1, p.waterLight)
        c.rect(6, 33, 8, 1, p.water)
        c.rect(22, 33, 10, 1, p.water)
        c.rect(38, 35, 6, 1, p.waterLight)
        // Wildflowers
        c.px(10, 40, p.coral)
        c.px(18, 42, p.coral)
        c.px(27, 39, p.sunrise)
        c.px(35, 43, p.coral)
        c.px(40, 40, p.sunrise)
        // A lone pine
        pine(c, x: 14, y: 34, size: 4)
        pine(c, x: 34, y: 34, size: 3)
    }

    static let thousandIslandLake = PixelSprite(width: 48, height: 48) { c in
        let p = ArtPalette.self
        // Sky
        c.rect(0, 0, 48, 18, p.sky)
        // Banner Peak silhouette (triangular)
        let banner: [Int] = [
            0, 0, 0, 2, 4, 6, 8, 10,
            12, 14, 16, 18, 20, 22, 24, 26,
            28, 28, 26, 24, 22, 20, 18, 16,
            14, 12, 10, 8, 6, 4, 2, 0,
            0, 0, 0, 2, 4, 6, 8, 10,
            12, 10, 8, 6, 4, 2, 0, 0
        ]
        c.silhouette(heights: banner, baselineY: 22, color: p.mountBlue)
        // Snow on Banner's peak
        for x in 15...20 {
            c.px(x, 22 - banner[x] + 1, p.snow)
            c.px(x, 22 - banner[x] + 2, p.snow)
        }
        c.px(16, 22 - banner[16], p.snow)
        c.px(17, 22 - banner[17], p.snow)
        // Far shore tree line
        c.rect(0, 22, 48, 2, p.treeDark)
        // Lake
        c.rect(0, 24, 48, 20, p.water)
        // Water ripples
        c.rect(2, 26, 6, 1, p.waterLight)
        c.rect(12, 28, 8, 1, p.waterLight)
        c.rect(24, 27, 10, 1, p.waterLight)
        c.rect(38, 29, 8, 1, p.waterLight)
        c.rect(4, 33, 40, 1, p.waterLight)
        c.rect(6, 37, 30, 1, p.waterLight)
        // Tiny islands (the "thousand")
        c.rect(8, 32, 4, 2, p.stone)
        c.px(9, 31, p.treeDark)
        c.rect(20, 30, 3, 1, p.stone)
        c.px(21, 29, p.treeDark)
        c.rect(30, 34, 5, 2, p.stone)
        c.rect(32, 33, 2, 1, p.treeDark)
        c.rect(40, 31, 3, 1, p.stone)
        // Shore
        c.rect(0, 44, 48, 4, p.grassDark)
        c.rect(0, 43, 48, 1, p.grass)
    }

    static let muirPass = PixelSprite(width: 48, height: 48) { c in
        let p = ArtPalette.self
        // Sky
        c.rect(0, 0, 48, 30, p.sky)
        // Snowy ridge in the distance
        let ridge: [Int] = [
            4, 6, 8, 10, 12, 14, 16, 14,
            12, 10, 12, 14, 16, 18, 16, 14,
            12, 14, 16, 18, 20, 18, 16, 14,
            12, 10, 12, 14, 16, 18, 16, 14,
            12, 10, 8, 10, 12, 14, 12, 10,
            8, 6, 4, 3, 2, 1, 0, 0
        ]
        c.silhouette(heights: ridge, baselineY: 30, color: p.mountDark)
        // Snow across the ridge
        for x in 0..<48 where ridge[x] >= 10 {
            c.px(x, 30 - ridge[x] + 1, p.snow)
            if ridge[x] >= 14 {
                c.px(x, 30 - ridge[x] + 2, p.snow)
            }
        }
        // Alpine ground
        c.rect(0, 30, 48, 18, p.grassDark)
        c.rect(0, 30, 48, 1, p.stone)
        // Scattered rocks
        c.rect(3, 36, 3, 2, p.stone)
        c.rect(42, 38, 4, 2, p.stone)
        c.rect(8, 42, 2, 2, p.stoneDark)
        c.rect(36, 41, 3, 2, p.stoneDark)
        // The famous stone hut — rounded dome
        c.rect(18, 32, 12, 10, p.stone)
        c.rect(19, 31, 10, 1, p.stone)
        c.rect(20, 30, 8, 1, p.stone)
        c.rect(22, 29, 4, 1, p.stone)
        // Hut stones (random blocks)
        c.row(34, from: 18, to: 29, p.stoneDark)
        c.px(21, 36, p.stoneDark)
        c.px(26, 37, p.stoneDark)
        c.px(20, 39, p.stoneDark)
        c.px(27, 40, p.stoneDark)
        c.px(23, 35, p.stoneLight)
        c.px(25, 38, p.stoneLight)
        // Door
        c.rect(22, 36, 4, 6, p.deep)
        c.rect(23, 37, 2, 4, p.brown)
        // Door arch
        c.px(22, 36, p.stoneDark)
        c.px(25, 36, p.stoneDark)
    }

    static let foresterPass = PixelSprite(width: 48, height: 48) { c in
        let p = ArtPalette.self
        c.rect(0, 0, 48, 48, p.sky)
        // Jagged knife-edge ridge
        let ridge: [Int] = [
            0, 0, 4, 8, 12, 16, 20, 22,
            24, 26, 28, 26, 24, 28, 32, 34,
            36, 38, 40, 38, 36, 34, 32, 30,
            32, 34, 32, 28, 24, 26, 28, 26,
            22, 18, 20, 22, 18, 14, 10, 12,
            14, 10, 6, 4, 2, 0, 0, 0
        ]
        c.silhouette(heights: ridge, baselineY: 44, color: p.mountBlue)
        // Shadow on one side of the ridge (darker)
        for x in 0..<48 {
            let h = ridge[x]
            if h > 0 {
                let top = 44 - h + 1
                // Draw right-side shadow
                if x > 0 && ridge[x - 1] < h {
                    c.col(x, from: top, to: min(top + h / 3, 44), p.mountDark)
                }
            }
        }
        // Snow on the highest peak
        for x in 14...21 where ridge[x] >= 30 {
            c.px(x, 44 - ridge[x] + 1, p.snow)
            c.px(x, 44 - ridge[x] + 2, p.snow)
            if ridge[x] >= 36 {
                c.px(x, 44 - ridge[x] + 3, p.snow)
            }
        }
        // Foreground rocky scree
        c.rect(0, 44, 48, 4, p.stoneDark)
        c.px(5, 45, p.stone)
        c.px(10, 46, p.stone)
        c.px(18, 45, p.stone)
        c.px(30, 46, p.stone)
        c.px(40, 45, p.stone)
        // Thin clouds high above
        c.rect(4, 6, 8, 1, p.cloudGray)
        c.rect(35, 4, 9, 1, p.cloudGray)
    }

    static let mtWhitney = PixelSprite(width: 48, height: 48) { c in
        let p = ArtPalette.self
        c.rect(0, 0, 48, 48, p.sky)
        // A softer sunrise tint near the horizon
        c.rect(0, 38, 48, 4, p.sunrise.opacity(0.35))
        // Subordinate peaks behind
        let back: [Int] = [
            0, 0, 2, 6, 10, 8, 6, 4,
            2, 0, 0, 2, 6, 10, 14, 12,
            10, 8, 6, 4, 2, 0, 0, 0,
            0, 0, 0, 0, 2, 6, 10, 8,
            6, 4, 2, 0, 0, 2, 6, 10,
            8, 6, 4, 2, 0, 0, 0, 0
        ]
        c.silhouette(heights: back, baselineY: 42, color: p.mountDark)
        // The main peak — sharp, tall, centered
        let whitney: [Int] = [
            0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 2, 6, 10, 14,
            18, 22, 26, 30, 33, 36, 38, 40,
            40, 38, 36, 33, 30, 26, 22, 18,
            14, 10, 6, 2, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0
        ]
        c.silhouette(heights: whitney, baselineY: 44, color: p.stoneDark)
        // Lighter rock highlight on one face
        for x in 16...23 {
            let top = 44 - whitney[x] + 1
            c.col(x, from: top, to: top + whitney[x] / 3, p.stone)
        }
        // Deep snow cap
        for x in 0..<48 where whitney[x] >= 30 {
            c.px(x, 44 - whitney[x] + 1, p.snow)
            if whitney[x] >= 34 {
                c.px(x, 44 - whitney[x] + 2, p.snow)
            }
            if whitney[x] >= 38 {
                c.px(x, 44 - whitney[x] + 3, p.snow)
            }
        }
        // Tiny summit shelter at the very top
        c.rect(23, 3, 3, 2, p.stoneDark)
        c.rect(22, 4, 5, 1, p.stoneDark)
        // Base / boulders
        c.rect(0, 44, 48, 4, p.stoneDark)
        c.px(6, 45, p.stone)
        c.px(18, 46, p.stone)
        c.px(36, 45, p.stone)
        c.px(43, 46, p.stone)
    }
}

// MARK: - Badges (32×32)

private enum BadgeArt {
    /// Common round-ish badge plate with a given accent and interior draw block.
    static func plate(_ c: PixelCanvas, tint: Color, interior: (PixelCanvas) -> Void) {
        let p = ArtPalette.self
        // Ribbon/outer ring
        c.rect(4, 4, 24, 24, tint)
        c.rect(6, 2, 20, 2, tint)
        c.rect(6, 28, 20, 2, tint)
        c.rect(2, 6, 2, 20, tint)
        c.rect(28, 6, 2, 20, tint)
        // Inner parchment face
        c.rect(6, 6, 20, 20, p.parchment)
        c.rect(6, 6, 20, 1, p.sand)
        c.rect(6, 25, 20, 1, p.sand)
        c.rect(6, 6, 1, 20, p.sand)
        c.rect(25, 6, 1, 20, p.sand)
        interior(c)
    }

    static let cautiousHiker = PixelSprite(width: 32, height: 32) { c in
        plate(c, tint: ArtPalette.forestGreen(opacity: 1.0)) { c in
            let p = ArtPalette.self
            // Shield shape
            c.rect(12, 9, 8, 2, p.mountBlue)
            c.rect(11, 11, 10, 8, p.mountBlue)
            c.rect(12, 19, 8, 2, p.mountBlue)
            c.rect(13, 21, 6, 1, p.mountBlue)
            c.rect(14, 22, 4, 1, p.mountBlue)
            c.px(15, 23, p.mountBlue)
            c.px(16, 23, p.mountBlue)
            // Checkmark
            c.px(13, 15, p.parchment)
            c.px(14, 16, p.parchment)
            c.px(15, 17, p.parchment)
            c.px(16, 16, p.parchment)
            c.px(17, 15, p.parchment)
            c.px(18, 14, p.parchment)
            c.px(19, 13, p.parchment)
        }
    }

    static let trailblazer = PixelSprite(width: 32, height: 32) { c in
        plate(c, tint: ArtPalette.coral) { c in
            let p = ArtPalette.self
            // A pair of boots
            // Left boot
            c.rect(9, 16, 5, 6, p.brown)
            c.rect(8, 20, 7, 2, p.brown)
            c.rect(9, 22, 6, 1, p.deep)
            // Laces
            c.px(10, 17, p.sand)
            c.px(12, 17, p.sand)
            c.px(10, 19, p.sand)
            c.px(12, 19, p.sand)
            // Right boot
            c.rect(18, 14, 5, 8, p.brown)
            c.rect(17, 20, 7, 2, p.brown)
            c.rect(18, 22, 6, 1, p.deep)
            c.px(19, 15, p.sand)
            c.px(21, 15, p.sand)
            c.px(19, 17, p.sand)
            c.px(21, 17, p.sand)
            c.px(19, 19, p.sand)
            c.px(21, 19, p.sand)
        }
    }

    static let goodSamaritan = PixelSprite(width: 32, height: 32) { c in
        plate(c, tint: ArtPalette.coral) { c in
            let p = ArtPalette.self
            // Heart shape
            c.rect(10, 11, 4, 2, p.coral)
            c.rect(18, 11, 4, 2, p.coral)
            c.rect(9, 13, 6, 2, p.coral)
            c.rect(17, 13, 6, 2, p.coral)
            c.rect(9, 15, 14, 3, p.coral)
            c.rect(10, 18, 12, 2, p.coral)
            c.rect(11, 20, 10, 1, p.coral)
            c.rect(12, 21, 8, 1, p.coral)
            c.rect(13, 22, 6, 1, p.coral)
            c.rect(14, 23, 4, 1, p.coral)
            c.px(15, 24, p.coral)
            c.px(16, 24, p.coral)
            // Highlight
            c.px(11, 13, p.parchment)
            c.px(12, 14, p.parchment)
        }
    }

    static let stormChaser = PixelSprite(width: 32, height: 32) { c in
        plate(c, tint: ArtPalette.mountBlue) { c in
            let p = ArtPalette.self
            // Cloud
            c.rect(10, 10, 12, 5, p.cloudGray)
            c.rect(8, 12, 2, 3, p.cloudGray)
            c.rect(22, 12, 2, 3, p.cloudGray)
            c.rect(12, 8, 8, 2, p.cloudGray)
            // Cloud shadow underside
            c.rect(10, 14, 12, 1, p.stoneDark)
            // Lightning bolt
            c.rect(15, 15, 3, 2, p.sunrise)
            c.rect(14, 17, 3, 2, p.sunrise)
            c.rect(16, 19, 3, 2, p.sunrise)
            c.rect(15, 21, 2, 2, p.sunrise)
            c.rect(13, 23, 4, 1, p.sunrise)
        }
    }

    static let peakBagger = PixelSprite(width: 32, height: 32) { c in
        plate(c, tint: ArtPalette.stoneDark) { c in
            let p = ArtPalette.self
            // Mountain silhouette
            let peak: [Int] = [
                0, 0, 1, 3, 5, 8, 11, 13,
                15, 13, 11, 8, 10, 12, 10, 7,
                5, 3, 1, 0
            ]
            for (i, h) in peak.enumerated() where h > 0 {
                c.col(7 + i, from: 22 - h + 1, to: 22, p.stoneDark)
            }
            // Snow cap on top
            c.px(14, 10, p.snow)
            c.px(15, 9, p.snow)
            c.px(13, 11, p.snow)
            // Flag
            c.rect(16, 4, 1, 6, p.brown)
            c.rect(17, 4, 4, 3, p.coral)
        }
    }

    static let ultralight = PixelSprite(width: 32, height: 32) { c in
        plate(c, tint: ArtPalette.forestGreen(opacity: 1.0)) { c in
            let p = ArtPalette.self
            // Stylized feather
            let spine = 16
            c.rect(spine, 9, 1, 14, p.brown)
            // Barbs left
            c.rect(13, 11, 3, 1, p.green)
            c.rect(12, 13, 4, 1, p.green)
            c.rect(11, 15, 5, 1, p.green)
            c.rect(12, 17, 4, 1, p.green)
            c.rect(13, 19, 3, 1, p.green)
            c.rect(14, 21, 2, 1, p.green)
            // Barbs right
            c.rect(17, 11, 3, 1, p.green)
            c.rect(17, 13, 4, 1, p.green)
            c.rect(17, 15, 5, 1, p.green)
            c.rect(17, 17, 4, 1, p.green)
            c.rect(17, 19, 3, 1, p.green)
            c.rect(17, 21, 2, 1, p.green)
            // Tip curl
            c.px(16, 8, p.brown)
            c.px(17, 8, p.brown)
        }
    }

    static let lostHikerSaved = PixelSprite(width: 32, height: 32) { c in
        plate(c, tint: ArtPalette.mountBlue) { c in
            let p = ArtPalette.self
            // Compass body
            c.rect(10, 10, 12, 12, p.metal)
            c.rect(11, 9, 10, 1, p.metal)
            c.rect(11, 22, 10, 1, p.metal)
            c.rect(9, 11, 1, 10, p.metal)
            c.rect(22, 11, 1, 10, p.metal)
            // Face
            c.rect(11, 11, 10, 10, p.parchment)
            // Cardinal marks
            c.px(16, 11, p.deep)
            c.px(16, 20, p.deep)
            c.px(11, 16, p.deep)
            c.px(20, 16, p.deep)
            // Needle (north pointing)
            c.rect(16, 12, 1, 5, p.coral)  // N half
            c.rect(15, 16, 1, 4, p.deep)   // S half
            c.rect(17, 16, 1, 4, p.deep)
            c.rect(16, 15, 1, 2, p.coral)
            // Center pin
            c.px(16, 16, p.sunrise)
        }
    }

    static let bearCanisterMaster = PixelSprite(width: 32, height: 32) { c in
        plate(c, tint: ArtPalette.brown) { c in
            let p = ArtPalette.self
            // Bear face circle
            c.rect(11, 11, 10, 10, p.bear)
            c.rect(12, 10, 8, 1, p.bear)
            c.rect(12, 21, 8, 1, p.bear)
            c.rect(10, 12, 1, 8, p.bear)
            c.rect(21, 12, 1, 8, p.bear)
            // Ears
            c.rect(10, 9, 3, 3, p.bear)
            c.rect(19, 9, 3, 3, p.bear)
            c.px(11, 10, p.brown)
            c.px(20, 10, p.brown)
            // Muzzle
            c.rect(14, 17, 4, 3, p.sand)
            c.rect(15, 16, 2, 1, p.sand)
            // Nose
            c.rect(15, 17, 2, 1, p.deep)
            // Eyes
            c.px(13, 14, p.sunrise)
            c.px(18, 14, p.sunrise)
            c.px(13, 13, p.deep)
            c.px(18, 13, p.deep)
        }
    }

    static let sierraStoryteller = PixelSprite(width: 32, height: 32) { c in
        plate(c, tint: ArtPalette.sand) { c in
            let p = ArtPalette.self
            // Open book
            // Left page
            c.rect(8, 11, 8, 12, p.paperYellow)
            // Right page
            c.rect(16, 11, 8, 12, p.paperYellow)
            // Book spine (center)
            c.rect(15, 10, 2, 14, p.brown)
            // Outer covers
            c.rect(7, 10, 1, 14, p.deep)
            c.rect(24, 10, 1, 14, p.deep)
            c.rect(8, 10, 7, 1, p.deep)
            c.rect(17, 10, 7, 1, p.deep)
            c.rect(8, 23, 16, 1, p.deep)
            // Lines of text
            c.rect(9, 13, 5, 1, p.brown)
            c.rect(9, 15, 6, 1, p.brown)
            c.rect(9, 17, 4, 1, p.brown)
            c.rect(9, 19, 5, 1, p.brown)
            c.rect(17, 13, 6, 1, p.brown)
            c.rect(17, 15, 4, 1, p.brown)
            c.rect(17, 17, 5, 1, p.brown)
            c.rect(17, 19, 3, 1, p.brown)
        }
    }
}

// MARK: - Parallax layers

private enum ParallaxArt {
    static let skyJMT = PixelSprite(width: 8, height: 8) { c in
        c.rect(0, 0, 8, 8, ArtPalette.sky)
    }

    /// Distant mountain silhouette — one tileable piece.
    /// Chosen heights are symmetric at the edges so tiles seam cleanly.
    static let mountainsJMT = PixelSprite(width: 256, height: 96) { c in
        let p = ArtPalette.self
        // Sky wash
        c.rect(0, 0, 256, 96, p.sky)
        // Horizon haze
        c.rect(0, 80, 256, 16, p.mountLight.opacity(0.4))

        // Generate jagged mountain silhouette
        var heights: [Int] = []
        // Seed a deterministic pattern using an array of control points, interpolated
        let control: [Int] = [22, 32, 46, 38, 54, 28, 44, 60, 48, 36, 52, 70, 56, 42, 50, 38, 22]
        // Tileable: first and last should match. Force last = first.
        var adjusted = control
        adjusted[adjusted.count - 1] = adjusted[0]
        let span = 256 / (adjusted.count - 1)
        for seg in 0..<(adjusted.count - 1) {
            let a = adjusted[seg]
            let b = adjusted[seg + 1]
            for i in 0..<span {
                let t = Double(i) / Double(span)
                let smooth = Double(a) * (1 - t) + Double(b) * t
                // Add a deterministic jaggedness
                let jag = (seg * 7 + i * 3) % 5 - 2
                heights.append(max(0, Int(smooth.rounded()) + jag))
            }
        }
        while heights.count < 256 { heights.append(heights.last ?? 0) }

        c.silhouette(heights: heights, baselineY: 95, color: p.mountBlue)

        // Second layer (darker back ridge behind)
        var back: [Int] = []
        for (i, h) in heights.enumerated() {
            back.append(h + (i * 3 % 6) - 8)
        }
        for (x, h) in back.enumerated() where h > 0 {
            let lo = max(0, 95 - h + 1)
            // Only the very tops of the back ridge peek above the front
            if lo < 95 - heights[x] {
                c.col(x, from: lo, to: 95 - heights[x], p.mountDark)
            }
        }

        // Snow caps on any column >= 52
        for (x, h) in heights.enumerated() where h >= 52 {
            c.px(x, 95 - h + 1, p.snow)
            if h >= 58 { c.px(x, 95 - h + 2, p.snow) }
            if h >= 64 { c.px(x, 95 - h + 3, p.snow) }
        }

        // Soft highlight on sunny faces (right-facing columns)
        for x in 1..<256 where heights[x] > 0 && heights[x] < heights[x - 1] {
            let top = 95 - heights[x] + 1
            c.px(x, top, p.mountLight)
        }
    }

    /// Closer rolling hills — shorter tile.
    static let hillsJMT = PixelSprite(width: 256, height: 64) { c in
        let p = ArtPalette.self

        // Generate rolling silhouette
        var heights: [Int] = []
        let control: [Int] = [18, 24, 30, 26, 32, 22, 28, 34, 28, 22, 26, 30, 20, 18]
        var adjusted = control
        adjusted[adjusted.count - 1] = adjusted[0]
        let span = 256 / (adjusted.count - 1)
        for seg in 0..<(adjusted.count - 1) {
            let a = adjusted[seg]
            let b = adjusted[seg + 1]
            let ad = Double(a)
            let bd = Double(b)
            for i in 0..<span {
                let t = Double(i) / Double(span)
                let lerp: Double = ad * (1.0 - t) + bd * t
                heights.append(Int(lerp.rounded()))
            }
        }
        while heights.count < 256 { heights.append(heights.last ?? 0) }

        c.silhouette(heights: heights, baselineY: 63, color: p.hillDark)

        // Lighter crowns
        for x in 0..<256 {
            let h = heights[x]
            if h > 0 {
                let top = 63 - h + 1
                c.col(x, from: top, to: top + max(1, h / 3), p.hillLight)
            }
        }

        // Scattered pine dots along the crown
        for x in stride(from: 4, to: 256, by: 9) {
            let h = heights[x]
            if h > 4 {
                let baseY = 63 - h
                c.rect(x, baseY - 3, 1, 3, p.treeDark)
                c.rect(x - 1, baseY - 2, 3, 1, p.green)
                c.rect(x - 1, baseY, 3, 1, p.green)
            }
        }
    }

    /// Ground strip — trail dirt for under the hiker.
    static let groundJMT = PixelSprite(width: 32, height: 16) { c in
        let p = ArtPalette.self
        c.rect(0, 0, 32, 16, p.sand)
        c.rect(0, 0, 32, 2, p.grassDark)
        c.rect(0, 2, 32, 1, p.grass)
        // Specks of gravel
        c.px(3, 7, p.stoneDark)
        c.px(10, 9, p.stoneDark)
        c.px(17, 6, p.stone)
        c.px(24, 11, p.stoneDark)
        c.px(29, 8, p.stone)
        c.px(6, 13, p.stoneDark)
        c.px(21, 14, p.stoneDark)
    }
}

// MARK: - Finale scene (512×320)

private enum FinaleArt {
    static let jmt = PixelSprite(width: 512, height: 320) { c in
        let p = ArtPalette.self

        // Sky gradient (sunrise bands, top to bottom: deep → sunrise → sun → sky)
        c.rect(0, 0, 512, 30, p.mountDark)
        c.rect(0, 30, 512, 30, p.sunrise)
        c.rect(0, 60, 512, 40, p.sun)
        c.rect(0, 100, 512, 80, p.sky)

        // Sun disc
        let sunX = 356
        let sunY = 80
        c.rect(sunX - 18, sunY - 18, 36, 36, p.sun)
        c.rect(sunX - 20, sunY - 14, 2, 28, p.sun)
        c.rect(sunX + 18, sunY - 14, 2, 28, p.sun)
        c.rect(sunX - 14, sunY - 20, 28, 2, p.sun)
        c.rect(sunX - 14, sunY + 18, 28, 2, p.sun)
        // Sun highlight
        c.rect(sunX - 14, sunY - 14, 28, 28, p.parchment)
        c.rect(sunX - 10, sunY - 10, 20, 20, p.sun)

        // Distant mountain ridge (far)
        var farHeights: [Int] = []
        for x in 0..<512 {
            let a = Double(x) * 0.035
            let noise: Double = 18.0 * sin(a) + 12.0 * sin(a * 1.7) + 6.0 * sin(a * 3.1)
            let h = 35 + Int(noise)
            farHeights.append(h)
        }
        c.silhouette(heights: farHeights, baselineY: 200, color: p.mountDark)
        for x in 0..<512 where farHeights[x] >= 50 {
            c.px(x, 200 - farHeights[x] + 1, p.snow)
            if farHeights[x] >= 60 {
                c.px(x, 200 - farHeights[x] + 2, p.snow)
            }
        }

        // Mid ridge
        var midHeights: [Int] = []
        for x in 0..<512 {
            let a = Double(x) * 0.025
            let noise: Double = 24.0 * sin(a * 0.8) + 16.0 * sin(a * 2.1) + 8.0 * sin(a * 4.3)
            let h = 55 + Int(noise)
            midHeights.append(h)
        }
        c.silhouette(heights: midHeights, baselineY: 230, color: p.mountBlue)
        for x in 0..<512 where midHeights[x] >= 72 {
            c.px(x, 230 - midHeights[x] + 1, p.snow)
        }

        // Mt. Whitney — the hero peak, towering center-left
        let whitneyBaseX = 220
        let peak: [Int] = [
            0, 4, 10, 18, 26, 34, 42, 50, 58, 66, 74, 82, 90, 98, 106, 114,
            122, 130, 138, 146, 154, 162, 170, 178, 186, 194, 202, 210, 218, 226, 234, 240,
            244, 248, 250, 252, 252, 250, 248, 244, 238, 232, 224, 216, 208, 198, 188, 176,
            164, 152, 140, 128, 116, 104, 92, 80, 68, 56, 44, 32, 22, 14, 8, 4
        ]
        let peakBaseY = 260
        for (i, h) in peak.enumerated() {
            let hh = h / 2  // scale for virtual 320-tall canvas
            c.col(whitneyBaseX + i, from: peakBaseY - hh, to: peakBaseY, p.stoneDark)
        }
        // Sunlit face
        for (i, h) in peak.enumerated() where i >= 28 {
            let hh = h / 2
            let top = peakBaseY - hh
            c.col(whitneyBaseX + i, from: top, to: top + hh / 3, p.stone)
        }
        // Snow cap
        for (i, h) in peak.enumerated() where h >= 200 {
            let top = peakBaseY - h / 2
            c.rect(whitneyBaseX + i, top, 1, 4, p.snow)
        }
        for (i, h) in peak.enumerated() where h >= 230 {
            let top = peakBaseY - h / 2
            c.rect(whitneyBaseX + i, top, 1, 7, p.snow)
        }

        // Clouds drifting high above
        cloud(c, x: 40, y: 50, w: 70, h: 8)
        cloud(c, x: 420, y: 40, w: 60, h: 7)
        cloud(c, x: 130, y: 30, w: 50, h: 6)

        // Foreground ridge and trail
        c.rect(0, 260, 512, 60, p.hillDark)
        c.rect(0, 258, 512, 3, p.hillLight)

        // Winding trail
        for x in 0..<512 {
            let wave: Double = 6.0 * sin(Double(x) * 0.04)
            let y = 285 + Int(wave)
            c.rect(x, y, 1, 3, p.sand)
            c.px(x, y - 1, p.grass)
        }

        // Hiker silhouette at summit, arms raised in triumph
        let hx = whitneyBaseX + 31       // centered on peak
        let hy = peakBaseY - peak[31] / 2 - 18   // just above peak top
        // Hat
        c.rect(hx - 2, hy, 4, 1, p.deep)
        c.rect(hx - 3, hy + 1, 6, 1, p.deep)
        // Head
        c.rect(hx - 1, hy + 2, 3, 2, p.skin)
        // Torso
        c.rect(hx - 2, hy + 4, 5, 6, p.coral)
        // Arms raised up
        c.rect(hx - 4, hy + 1, 1, 5, p.coral)
        c.rect(hx + 3, hy + 1, 1, 5, p.coral)
        c.px(hx - 4, hy, p.skin)
        c.px(hx + 3, hy, p.skin)
        // Legs
        c.rect(hx - 2, hy + 10, 2, 4, p.mountBlue)
        c.rect(hx + 1, hy + 10, 2, 4, p.mountBlue)
        // Boots
        c.rect(hx - 2, hy + 14, 2, 1, p.deep)
        c.rect(hx + 1, hy + 14, 2, 1, p.deep)

        // Summit marker next to hiker
        let mx = hx + 8
        let my = hy + 6
        c.rect(mx, my, 1, 10, p.brown)
        c.rect(mx + 1, my - 1, 6, 5, p.coral)

        // Small pines scattered in foreground
        for (fx, fy) in [(40, 300), (80, 305), (140, 302), (200, 308), (310, 304), (380, 306), (450, 302)] {
            c.rect(fx, fy - 8, 1, 8, p.treeDark)
            c.rect(fx - 3, fy - 6, 7, 2, p.green)
            c.rect(fx - 2, fy - 3, 5, 2, p.green)
            c.rect(fx - 1, fy - 1, 3, 1, p.green)
        }
    }

    private static func cloud(_ c: PixelCanvas, x: Int, y: Int, w: Int, h: Int) {
        let p = ArtPalette.self
        c.rect(x + 3, y, w - 6, h, p.parchment)
        c.rect(x, y + 1, 3, h - 2, p.parchment)
        c.rect(x + w - 3, y + 1, 3, h - 2, p.parchment)
        c.rect(x + 4, y - 1, w - 10, 1, p.parchment)
        // Shadow underside
        c.rect(x + 3, y + h - 1, w - 6, 1, p.cloudGray)
    }
}

// MARK: - Wonderland Trail art (landmarks, parallax, finale, badges)

private enum LandmarkArtWonder {
    static func pine(_ c: PixelCanvas, x: Int, y: Int, size: Int = 3) {
        let p = ArtPalette.self
        c.rect(x, y - size, 1, size, p.treeDark)
        c.rect(x - 1, y - size + 1, 3, 1, p.green)
        if size >= 3 { c.rect(x - 1, y - 1, 3, 1, p.green) }
    }

    /// Draw Mt. Rainier silhouette — broad, symmetric, glaciated. Base x is
    /// the left edge of the mountain; width is total; maxHeight is peak height.
    static func rainier(_ c: PixelCanvas, baseX: Int, baseY: Int, width: Int, maxHeight: Int) {
        let p = ArtPalette.self
        var heights: [Int] = []
        for i in 0..<width {
            let t = Double(i) / Double(width - 1)
            // Bell curve-ish: (1 - |2t - 1|^1.6)
            let centered = abs(2 * t - 1)
            let shape = 1.0 - pow(centered, 1.6)
            heights.append(max(0, Int((shape * Double(maxHeight)).rounded())))
        }
        // Main silhouette
        for (i, h) in heights.enumerated() where h > 0 {
            c.col(baseX + i, from: baseY - h + 1, to: baseY, p.stoneDark)
        }
        // Sunlit east face (right half)
        for (i, h) in heights.enumerated() where i > width / 2 && h > 4 {
            let top = baseY - h + 1
            c.col(baseX + i, from: top, to: top + h / 3, p.stone)
        }
        // Snow cap — top third of the dome
        let snowThreshold = (maxHeight * 2) / 3
        for (i, h) in heights.enumerated() where h >= snowThreshold {
            c.px(baseX + i, baseY - h + 1, p.snow)
            if h >= snowThreshold + 3 { c.px(baseX + i, baseY - h + 2, p.snow) }
            if h >= snowThreshold + 6 { c.px(baseX + i, baseY - h + 3, p.snow) }
        }
    }

    static let longmire = PixelSprite(width: 48, height: 48) { c in
        let p = ArtPalette.self
        // Sky
        c.rect(0, 0, 48, 30, p.sky)
        // Distant conifer ridge
        c.rect(0, 22, 48, 10, p.treeDark)
        for x in stride(from: 0, to: 48, by: 3) {
            c.rect(x, 20, 2, 4, p.green)
        }
        // Ground
        c.rect(0, 38, 48, 10, p.grassDark)
        c.rect(0, 36, 48, 2, p.grass)
        // Log inn — main body
        c.rect(14, 26, 22, 12, p.brown)
        // Log-texture horizontal bands
        for y in stride(from: 27, to: 38, by: 2) {
            c.rect(14, y, 22, 1, p.deep)
        }
        // Pitched roof
        let roof: [Int] = [0,0,0,0,1,2,3,4,5,6,7,8,9,10,11,12,11,10,9,8,7,6,5,4,3,2,1,0]
        for (i, h) in roof.enumerated() where h > 0 {
            c.col(11 + i, from: 26 - h, to: 26 - 1, p.deep)
        }
        // Stone chimney
        c.rect(30, 18, 3, 10, p.stone)
        c.px(30, 18, p.stoneLight)
        c.px(32, 18, p.stoneDark)
        // Door
        c.rect(23, 31, 3, 7, p.deep)
        c.px(25, 34, p.sunrise) // doorknob
        // Windows
        c.rect(16, 29, 3, 3, p.sun)
        c.rect(29, 29, 3, 3, p.sun)
        // Foreground pines flanking
        pine(c, x: 3, y: 38, size: 4)
        pine(c, x: 6, y: 38, size: 3)
        pine(c, x: 43, y: 38, size: 4)
        pine(c, x: 46, y: 38, size: 3)
    }

    static let cougarRockBridge = PixelSprite(width: 48, height: 48) { c in
        let p = ArtPalette.self
        // Sky
        c.rect(0, 0, 48, 26, p.sky)
        // Gorge walls
        c.rect(0, 18, 12, 30, p.stoneDark)
        c.rect(36, 18, 12, 30, p.stoneDark)
        c.rect(0, 18, 12, 1, p.stoneLight)
        c.rect(36, 18, 12, 1, p.stoneLight)
        // Trees on tops
        pine(c, x: 3, y: 18, size: 3)
        pine(c, x: 7, y: 18, size: 4)
        pine(c, x: 40, y: 18, size: 3)
        pine(c, x: 44, y: 18, size: 4)
        // Glacier meltwater below (pale turquoise)
        c.rect(12, 38, 24, 10, p.waterLight)
        c.rect(14, 42, 20, 1, p.water)
        c.rect(16, 45, 16, 1, p.water)
        // Suspension cables — sagging curve
        let cableTopL = 20, cableTopR = 20
        c.px(12, cableTopL, p.brown)
        c.px(36, cableTopR, p.brown)
        for x in 12...36 {
            // parabolic sag
            let t = Double(x - 12) / 24.0
            let sag = Int((4.0 * (0.25 - (t - 0.5) * (t - 0.5))) * 8.0)
            c.px(x, cableTopL + sag, p.deep)
        }
        // Deck — slightly arched
        for x in 12...36 {
            let t = Double(x - 12) / 24.0
            let arch = Int(2.0 * (0.25 - (t - 0.5) * (t - 0.5)) * 6.0)
            c.px(x, 30 - arch, p.brown)
            c.px(x, 31 - arch, p.deep)
        }
        // Cable hangers (verticals)
        for x in stride(from: 14, to: 36, by: 3) {
            let t = Double(x - 12) / 24.0
            let sag = Int((4.0 * (0.25 - (t - 0.5) * (t - 0.5))) * 8.0)
            let arch = Int(2.0 * (0.25 - (t - 0.5) * (t - 0.5)) * 6.0)
            c.col(x, from: cableTopL + sag, to: 30 - arch, p.brown)
        }
    }

    static let emeraldRidge = PixelSprite(width: 48, height: 48) { c in
        let p = ArtPalette.self
        c.rect(0, 0, 48, 48, p.sky)
        // Back ridges
        let back: [Int] = [
            6,8,10,12,14,12,10,8,6,4,3,2,
            4,6,8,10,12,14,12,10,8,6,4,2,
            0,0,0,0,0,0,0,0,0,0,0,0,
            0,0,0,0,0,0,0,0,0,0,0,0
        ]
        c.silhouette(heights: back, baselineY: 32, color: p.mountDark)
        // Mt. Rainier dominates center
        rainier(c, baseX: 4, baseY: 36, width: 40, maxHeight: 30)
        // Meadow foreground
        c.rect(0, 40, 48, 8, p.grassDark)
        c.rect(0, 38, 48, 2, p.grass)
        // A few wildflowers
        c.px(8, 44, p.coral)
        c.px(14, 45, p.sunrise)
        c.px(22, 43, p.coral)
        c.px(30, 45, p.sunrise)
        c.px(38, 44, p.coral)
        // Tiny hiker silhouette
        c.rect(22, 37, 1, 3, p.deep)
        c.px(22, 36, p.coral)
    }

    static let klapatchePark = PixelSprite(width: 48, height: 48) { c in
        let p = ArtPalette.self
        c.rect(0, 0, 48, 22, p.sky)
        // Distant Rainier (upper half)
        rainier(c, baseX: 10, baseY: 22, width: 28, maxHeight: 18)
        // Tree line
        c.rect(0, 22, 48, 2, p.treeDark)
        pine(c, x: 4, y: 23, size: 3)
        pine(c, x: 44, y: 23, size: 3)
        // Aurora Lake — mirror
        c.rect(0, 24, 48, 16, p.water)
        // Reflection of Rainier (inverted, lighter)
        let reflectHeights = (0..<28).map { i -> Int in
            let t = Double(i) / 27.0
            let centered = abs(2 * t - 1)
            let shape = 1.0 - pow(centered, 1.6)
            return max(0, Int((shape * 18.0).rounded()))
        }
        for (i, h) in reflectHeights.enumerated() where h > 0 {
            c.col(10 + i, from: 24, to: min(24 + h, 39), p.mountBlue.opacity(0.6))
        }
        // Ripple lines
        c.rect(2, 28, 12, 1, p.waterLight)
        c.rect(30, 30, 14, 1, p.waterLight)
        c.rect(8, 34, 30, 1, p.waterLight)
        // Shore grass
        c.rect(0, 40, 48, 8, p.grassDark)
        c.rect(0, 39, 48, 1, p.grass)
    }

    static let sprayPark = PixelSprite(width: 48, height: 48) { c in
        let p = ArtPalette.self
        c.rect(0, 0, 48, 18, p.sky)
        // Peek of Rainier
        rainier(c, baseX: 15, baseY: 20, width: 18, maxHeight: 14)
        // Tree fringe
        for x in stride(from: 0, to: 48, by: 5) {
            pine(c, x: x, y: 22, size: 3)
        }
        // Meadow
        c.rect(0, 22, 48, 26, p.grass)
        for y in stride(from: 24, to: 48, by: 2) {
            for x in stride(from: y % 4, to: 48, by: 4) {
                c.px(x, y, p.grassDark)
            }
        }
        // Wildflowers — dense, varied
        let flowers: [(Int, Int, Int)] = [
            (4,26,0),(10,28,1),(18,27,0),(24,29,2),(32,26,1),(38,28,0),(44,27,2),
            (6,32,1),(14,34,2),(22,33,0),(28,35,1),(36,32,0),(42,34,2),
            (2,38,0),(10,40,1),(16,39,2),(26,41,0),(32,38,1),(40,40,2),
            (8,44,1),(18,45,0),(28,44,2),(38,46,1)
        ]
        for (x, y, kind) in flowers {
            let color = [p.coral, p.sunrise, p.parchment][kind]
            c.px(x, y, color)
            c.px(x, y - 1, p.treeDark)
        }
        // Marmot on a rock
        c.rect(2, 41, 5, 3, p.stoneDark)
        c.rect(3, 38, 3, 3, p.brown) // marmot body
        c.rect(5, 37, 1, 2, p.brown) // head
        c.px(5, 37, p.deep)
    }

    static let mysticLake = PixelSprite(width: 48, height: 48) { c in
        let p = ArtPalette.self
        c.rect(0, 0, 48, 10, p.sky)
        // Willis Wall — dark massive cliff
        c.rect(0, 4, 48, 26, p.stoneDark)
        // Snow bands on wall
        for y in [6, 10, 14, 18] {
            for x in stride(from: 2, to: 46, by: 6) {
                c.rect(x, y, 3, 1, p.snow)
            }
        }
        // Striations
        for x in stride(from: 0, to: 48, by: 4) {
            c.col(x, from: 8, to: 28, p.stoneDark.opacity(0.7))
        }
        // Wall's jagged top edge
        let top: [Int] = [
            4,5,6,7,8,6,5,7,9,10,11,9,
            7,8,10,12,13,11,9,7,8,10,11,13,
            14,12,10,8,7,9,11,10,
            8,6,7,9,10,8,6,5,6,7,8,6,5,4,3,2
        ]
        for (x, h) in top.enumerated() where h > 0 {
            c.col(x, from: 4 - h + 4, to: 4, p.sky)
        }
        // Shore
        c.rect(0, 30, 48, 4, p.stone)
        // Alpine tarn
        c.rect(0, 34, 48, 14, p.water)
        c.rect(0, 34, 48, 1, p.mountDark)
        // Ripples
        c.rect(4, 38, 10, 1, p.waterLight)
        c.rect(22, 40, 16, 1, p.waterLight)
        c.rect(10, 44, 28, 1, p.waterLight)
    }

    static let summerland = PixelSprite(width: 48, height: 48) { c in
        let p = ArtPalette.self
        c.rect(0, 0, 48, 16, p.sky)
        // Rainier east face (asymmetric — steeper east)
        var heights: [Int] = []
        for i in 0..<40 {
            let t = Double(i) / 39.0
            // Steeper on the right (east face)
            let centered = abs(2 * t - 1)
            let shape = 1.0 - pow(centered, 1.8)
            // Bias the peak slightly left
            heights.append(max(0, Int((shape * 28.0).rounded())))
        }
        for (i, h) in heights.enumerated() where h > 0 {
            c.col(4 + i, from: 32 - h + 1, to: 32, p.stoneDark)
        }
        // Snow on upper slopes
        for (i, h) in heights.enumerated() where h >= 20 {
            c.px(4 + i, 32 - h + 1, p.snow)
            if h >= 24 { c.px(4 + i, 32 - h + 2, p.snow) }
        }
        // Subalpine bowl — purple heather
        c.rect(0, 32, 48, 16, p.grassDark)
        for y in stride(from: 34, to: 48, by: 2) {
            for x in stride(from: y % 3, to: 48, by: 3) {
                c.px(x, y, p.mountBlue.opacity(0.5))
            }
        }
        // Scattered alpine firs
        pine(c, x: 6, y: 34, size: 3)
        pine(c, x: 12, y: 34, size: 4)
        pine(c, x: 36, y: 34, size: 3)
        pine(c, x: 42, y: 34, size: 4)
    }

    static let panhandleGap = PixelSprite(width: 48, height: 48) { c in
        let p = ArtPalette.self
        c.rect(0, 0, 48, 48, p.sky)
        // Distant back ridges
        let back: [Int] = [
            4,6,8,10,8,6,4,2,3,5,7,9,
            11,9,7,5,3,4,6,8,10,8,6,4,
            2,3,5,7,6,4,2,0,0,0,0,0,
            0,0,0,0,0,0,0,0,0,0,0,0
        ]
        c.silhouette(heights: back, baselineY: 30, color: p.mountDark)
        // Snow on back peaks
        for (x, h) in back.enumerated() where h >= 8 {
            c.px(x, 30 - h + 1, p.snow)
        }
        // Stark rocky ground
        c.rect(0, 30, 48, 18, p.stone)
        c.rect(0, 30, 48, 1, p.stoneLight)
        // Scree specks
        for (x, y) in [(3,36),(8,40),(14,42),(20,38),(28,43),(34,37),(40,41),(45,39)] {
            c.px(x, y, p.stoneDark)
        }
        // Large stone cairn
        c.rect(22, 36, 6, 2, p.stoneDark)
        c.rect(23, 34, 4, 2, p.stone)
        c.rect(24, 32, 2, 2, p.stoneDark)
        c.px(24, 30, p.stone)
        c.px(25, 30, p.stone)
        // Wind wisp
        c.rect(32, 10, 8, 1, p.parchment.opacity(0.4))
        c.rect(6, 16, 9, 1, p.parchment.opacity(0.4))
    }
}

private enum ParallaxArtWonder {
    static let sky = PixelSprite(width: 8, height: 8) { c in
        c.rect(0, 0, 8, 8, ArtPalette.sky)
        // Cooler PNW tint — gray wash at top
        c.rect(0, 0, 8, 3, ArtPalette.cloudGray.opacity(0.25))
    }

    static let mountains = PixelSprite(width: 256, height: 96) { c in
        let p = ArtPalette.self
        // Sky wash
        c.rect(0, 0, 256, 96, p.sky)
        // PNW gray mist band
        c.rect(0, 0, 256, 30, p.cloudGray.opacity(0.2))
        c.rect(0, 74, 256, 14, p.mountLight.opacity(0.35))

        // Background ridge — low, rolling, dark green-blue
        var back: [Int] = []
        let backControl: [Int] = [32, 38, 30, 36, 42, 28, 34, 40, 32, 28, 34, 38, 30, 32]
        var adjusted = backControl
        adjusted[adjusted.count - 1] = adjusted[0]
        let span = 256 / (adjusted.count - 1)
        for seg in 0..<(adjusted.count - 1) {
            let a = adjusted[seg]; let b = adjusted[seg + 1]
            for i in 0..<span {
                let t = Double(i) / Double(span)
                back.append(Int((Double(a) * (1 - t) + Double(b) * t).rounded()))
            }
        }
        while back.count < 256 { back.append(back.last ?? 0) }
        c.silhouette(heights: back, baselineY: 95, color: p.mountDark)

        // Mt. Rainier — the dominant dome, centered
        let rainierCenter = 128
        let rainierHalfWidth = 90
        let rainierMax = 72
        for i in -rainierHalfWidth...rainierHalfWidth {
            let t = Double(abs(i)) / Double(rainierHalfWidth)
            let shape = 1.0 - pow(t, 1.7)
            let h = max(0, Int((shape * Double(rainierMax)).rounded()))
            let x = rainierCenter + i
            guard x >= 0, x < 256, h > 0 else { continue }
            c.col(x, from: 95 - h + 1, to: 95, p.stoneDark)
        }
        // East face sunlit highlight
        for i in 1...rainierHalfWidth {
            let t = Double(i) / Double(rainierHalfWidth)
            let shape = 1.0 - pow(t, 1.7)
            let h = max(0, Int((shape * Double(rainierMax)).rounded()))
            let x = rainierCenter + i
            guard x >= 0, x < 256, h > 4 else { continue }
            let top = 95 - h + 1
            c.col(x, from: top, to: top + h / 4, p.stone)
        }
        // West face shadow
        for i in 1...rainierHalfWidth {
            let t = Double(i) / Double(rainierHalfWidth)
            let shape = 1.0 - pow(t, 1.7)
            let h = max(0, Int((shape * Double(rainierMax)).rounded()))
            let x = rainierCenter - i
            guard x >= 0, x < 256, h > 4 else { continue }
            c.col(x, from: 95 - h + 1, to: 95 - h + 1 + h / 5, p.mountDark)
        }
        // Heavy snow across upper third of Rainier
        for i in -rainierHalfWidth...rainierHalfWidth {
            let t = Double(abs(i)) / Double(rainierHalfWidth)
            let shape = 1.0 - pow(t, 1.7)
            let h = max(0, Int((shape * Double(rainierMax)).rounded()))
            guard h >= 44 else { continue }
            let x = rainierCenter + i
            guard x >= 0, x < 256 else { continue }
            c.px(x, 95 - h + 1, p.snow)
            if h >= 50 { c.px(x, 95 - h + 2, p.snow) }
            if h >= 56 { c.px(x, 95 - h + 3, p.snow) }
            if h >= 62 { c.px(x, 95 - h + 4, p.snow) }
            if h >= 68 { c.px(x, 95 - h + 5, p.snow) }
        }
    }

    static let hills = PixelSprite(width: 256, height: 64) { c in
        let p = ArtPalette.self
        var heights: [Int] = []
        let control: [Int] = [20, 26, 32, 28, 36, 24, 30, 34, 28, 24, 28, 30, 22, 20]
        var adjusted = control
        adjusted[adjusted.count - 1] = adjusted[0]
        let span = 256 / (adjusted.count - 1)
        for seg in 0..<(adjusted.count - 1) {
            let a = adjusted[seg]; let b = adjusted[seg + 1]
            for i in 0..<span {
                let t = Double(i) / Double(span)
                heights.append(Int((Double(a) * (1 - t) + Double(b) * t).rounded()))
            }
        }
        while heights.count < 256 { heights.append(heights.last ?? 0) }
        c.silhouette(heights: heights, baselineY: 63, color: p.hillDark)
        // Crown shading
        for x in 0..<256 {
            let h = heights[x]
            if h > 0 {
                let top = 63 - h + 1
                c.col(x, from: top, to: top + max(1, h / 4), p.hillLight)
            }
        }
        // Tall Douglas-fir silhouettes (narrower, taller than JMT pines)
        for x in stride(from: 5, to: 256, by: 7) {
            let h = heights[x]
            if h > 3 {
                let baseY = 63 - h
                c.rect(x, baseY - 5, 1, 5, p.treeDark)
                c.rect(x - 1, baseY - 4, 3, 1, p.green)
                c.rect(x - 1, baseY - 2, 3, 1, p.green)
                c.px(x, baseY - 5, p.treeDark)
            }
        }
    }

    static let ground = PixelSprite(width: 32, height: 16) { c in
        let p = ArtPalette.self
        c.rect(0, 0, 32, 16, p.grassDark)
        c.rect(0, 0, 32, 2, p.grass)
        c.rect(0, 2, 32, 1, p.hillLight)
        // Wildflower specks
        c.px(5, 7, p.coral)
        c.px(11, 10, p.sunrise)
        c.px(17, 6, p.parchment)
        c.px(23, 11, p.coral)
        c.px(28, 8, p.sunrise)
        c.px(3, 13, p.coral)
        c.px(19, 14, p.parchment)
    }
}

private enum FinaleArtWonder {
    static let wonder = PixelSprite(width: 512, height: 320) { c in
        let p = ArtPalette.self
        // Dawn sky — bands from deep purple up top down to warm sky
        c.rect(0, 0, 512, 40, p.mountDark)
        c.rect(0, 40, 512, 30, p.sunrise)
        c.rect(0, 70, 512, 40, p.sun)
        c.rect(0, 110, 512, 90, p.sky)
        // Sun disc — rising low
        let sunX = 120, sunY = 95
        c.rect(sunX - 16, sunY - 16, 32, 32, p.sun)
        c.rect(sunX - 12, sunY - 12, 24, 24, p.parchment)
        c.rect(sunX - 8, sunY - 8, 16, 16, p.sun)
        // Rays
        c.rect(sunX - 24, sunY - 2, 48, 4, p.sun.opacity(0.4))
        c.rect(sunX - 2, sunY - 24, 4, 48, p.sun.opacity(0.4))
        // Distant ridges
        var farH: [Int] = []
        for x in 0..<512 {
            let a = Double(x) * 0.03
            farH.append(30 + Int(14 * sin(a) + 8 * sin(a * 2.1)))
        }
        c.silhouette(heights: farH, baselineY: 200, color: p.mountDark)
        // Mid ridges
        var midH: [Int] = []
        for x in 0..<512 {
            let a = Double(x) * 0.022
            midH.append(50 + Int(20 * sin(a * 0.9) + 12 * sin(a * 2.4)))
        }
        c.silhouette(heights: midH, baselineY: 230, color: p.mountBlue)
        // Mt. Rainier — hero dome, center
        let cx = 280
        let halfW = 160
        let maxH = 220
        for i in -halfW...halfW {
            let t = Double(abs(i)) / Double(halfW)
            let shape = 1.0 - pow(t, 1.6)
            let h = max(0, Int((shape * Double(maxH)).rounded()))
            let x = cx + i
            if x < 0 || x >= 512 || h == 0 { continue }
            c.col(x, from: 260 - h + 1, to: 260, p.stoneDark)
            // East face sunlit
            if i > 0 && h > 20 {
                let top = 260 - h + 1
                c.col(x, from: top, to: top + h / 4, p.sunrise.opacity(0.6))
            }
        }
        // Snow cap — upper half
        for i in -halfW...halfW {
            let t = Double(abs(i)) / Double(halfW)
            let shape = 1.0 - pow(t, 1.6)
            let h = max(0, Int((shape * Double(maxH)).rounded()))
            guard h >= 120 else { continue }
            let x = cx + i
            if x < 0 || x >= 512 { continue }
            for d in 0..<min(h - 100, 30) {
                c.px(x, 260 - h + 1 + d, p.snow)
            }
        }
        // Foreground meadow
        c.rect(0, 260, 512, 60, p.grassDark)
        c.rect(0, 258, 512, 3, p.grass)
        // Wildflowers dense across meadow
        for x in stride(from: 6, to: 512, by: 9) {
            let yJitter = (x * 7) % 5
            let y = 272 + yJitter
            let color = [p.coral, p.sunrise, p.parchment][x % 3]
            c.rect(x, y, 1, 2, color)
            c.px(x, y + 2, p.treeDark)
        }
        // Hiker on meadow, arms raised
        let hx = 260, hy = 252
        c.rect(hx - 2, hy, 4, 1, p.deep) // hat crown
        c.rect(hx - 3, hy + 1, 6, 1, p.deep) // brim
        c.rect(hx - 1, hy + 2, 3, 2, p.skin)
        c.rect(hx - 2, hy + 4, 5, 6, p.coral)
        c.rect(hx - 4, hy + 1, 1, 5, p.coral) // left arm raised
        c.rect(hx + 3, hy + 1, 1, 5, p.coral)
        c.px(hx - 4, hy, p.skin)
        c.px(hx + 3, hy, p.skin)
        c.rect(hx - 2, hy + 10, 2, 4, p.mountBlue)
        c.rect(hx + 1, hy + 10, 2, 4, p.mountBlue)
        c.rect(hx - 2, hy + 14, 2, 1, p.deep)
        c.rect(hx + 1, hy + 14, 2, 1, p.deep)
        // Drifting PNW clouds
        for (cxp, cyp, cw) in [(60, 30, 60), (380, 22, 50), (430, 50, 40), (160, 46, 35)] {
            c.rect(cxp, cyp, cw, 6, p.parchment)
            c.rect(cxp + 2, cyp - 1, cw - 4, 1, p.parchment)
            c.rect(cxp + 3, cyp + 6, cw - 6, 1, p.cloudGray)
        }
    }
}

private enum BadgeArtWonder {
    static func plate(_ c: PixelCanvas, tint: Color, interior: (PixelCanvas) -> Void) {
        let p = ArtPalette.self
        c.rect(4, 4, 24, 24, tint)
        c.rect(6, 2, 20, 2, tint)
        c.rect(6, 28, 20, 2, tint)
        c.rect(2, 6, 2, 20, tint)
        c.rect(28, 6, 2, 20, tint)
        c.rect(6, 6, 20, 20, p.parchment)
        c.rect(6, 6, 20, 1, p.sand)
        c.rect(6, 25, 20, 1, p.sand)
        c.rect(6, 6, 1, 20, p.sand)
        c.rect(25, 6, 1, 20, p.sand)
        interior(c)
    }

    static let volcanoCircler = PixelSprite(width: 32, height: 32) { c in
        plate(c, tint: ArtPalette.sunrise) { c in
            let p = ArtPalette.self
            // Snow-capped cone
            let cone: [Int] = [0,0,0,2,4,6,8,10,11,12,12,11,10,8,6,4,2,0,0,0]
            for (i, h) in cone.enumerated() where h > 0 {
                c.col(6 + i, from: 22 - h + 1, to: 22, p.stoneDark)
            }
            // Snow on top
            c.rect(11, 10, 8, 2, p.snow)
            c.rect(13, 9, 4, 1, p.snow)
            // Compass arrow circling (curved arrow)
            c.px(10, 14, p.mountBlue)
            c.px(8, 16, p.mountBlue)
            c.px(7, 18, p.mountBlue)
            c.px(8, 20, p.mountBlue)
            c.px(10, 21, p.mountBlue)
            c.px(13, 22, p.mountBlue)
            c.px(17, 22, p.mountBlue)
            c.px(20, 21, p.mountBlue)
            c.px(22, 20, p.mountBlue)
            // Arrowhead
            c.px(22, 18, p.coral)
            c.px(23, 19, p.coral)
            c.px(24, 20, p.coral)
            c.px(22, 22, p.coral)
        }
    }

    static let rangersFriend = PixelSprite(width: 32, height: 32) { c in
        plate(c, tint: ArtPalette.green) { c in
            let p = ArtPalette.self
            // Campaign-style ranger hat — wide brim
            // Brim
            c.rect(7, 18, 18, 2, p.brown)
            c.rect(9, 17, 14, 1, p.deep)
            // Crown
            c.rect(11, 12, 10, 6, p.brown)
            c.rect(12, 10, 8, 2, p.brown)
            c.rect(13, 9, 6, 1, p.brown)
            // Dimples
            c.px(12, 12, p.deep)
            c.px(19, 12, p.deep)
            c.rect(15, 10, 2, 1, p.deep)
            // Hat band
            c.rect(11, 16, 10, 1, p.deep)
            // Ranger insignia — shield
            c.rect(15, 20, 2, 3, p.sunrise)
            c.px(14, 21, p.sunrise)
            c.px(17, 21, p.sunrise)
        }
    }

    static let weatherEye = PixelSprite(width: 32, height: 32) { c in
        plate(c, tint: ArtPalette.mountBlue) { c in
            let p = ArtPalette.self
            // Cloud
            c.rect(8, 10, 16, 5, p.cloudGray)
            c.rect(10, 8, 12, 2, p.cloudGray)
            c.rect(12, 6, 8, 2, p.parchment)
            c.rect(6, 12, 2, 3, p.cloudGray)
            c.rect(24, 12, 2, 3, p.cloudGray)
            // Cloud underside
            c.rect(8, 14, 16, 1, p.stoneDark)
            // Eye inside cloud
            c.rect(12, 17, 8, 4, p.parchment)
            c.rect(12, 17, 8, 1, p.deep)
            c.rect(12, 20, 8, 1, p.deep)
            c.rect(11, 18, 1, 2, p.deep)
            c.rect(20, 18, 1, 2, p.deep)
            // Iris
            c.rect(14, 18, 4, 2, p.mountBlue)
            // Pupil
            c.rect(15, 18, 2, 2, p.deep)
            // Highlight
            c.px(15, 18, p.parchment)
            // Rain drops below
            c.rect(12, 23, 1, 2, p.waterLight)
            c.rect(16, 23, 1, 2, p.waterLight)
            c.rect(20, 23, 1, 2, p.waterLight)
        }
    }
}

// MARK: - Superior Hiking Trail art (landmarks, parallax, finale, badges)

private enum LandmarkArtSHT {
    static func pine(_ c: PixelCanvas, x: Int, y: Int, size: Int = 3) {
        let p = ArtPalette.self
        c.rect(x, y - size, 1, size, p.treeDark)
        c.rect(x - 1, y - size + 1, 3, 1, p.green)
        if size >= 3 { c.rect(x - 1, y - 1, 3, 1, p.green) }
    }

    static func birch(_ c: PixelCanvas, x: Int, y: Int, size: Int = 4) {
        let p = ArtPalette.self
        // White trunk
        c.rect(x, y - size, 1, size, p.parchment)
        // Bark marks
        c.px(x, y - size + 1, p.deep)
        c.px(x, y - size + 3, p.deep)
        // Yellow-green leaves
        c.rect(x - 1, y - size, 3, 1, p.hillLight)
        c.rect(x - 2, y - size + 1, 5, 1, p.green)
    }

    static let jayCooke = PixelSprite(width: 48, height: 48) { c in
        let p = ArtPalette.self
        c.rect(0, 0, 48, 22, p.sky)
        // Trees on far bank
        for x in stride(from: 0, to: 48, by: 3) {
            c.rect(x, 16, 2, 6, p.treeDark)
        }
        // Red slate cliffs (signature Jay Cooke color — use coral-ish)
        c.rect(0, 22, 18, 8, p.coral.opacity(0.7))
        c.rect(30, 22, 18, 8, p.coral.opacity(0.7))
        c.rect(0, 22, 18, 1, p.sunrise)
        c.rect(30, 22, 18, 1, p.sunrise)
        // Turbulent river below
        c.rect(0, 30, 48, 18, p.water)
        // White water / foam
        for (x, y) in [(2,34),(8,36),(14,38),(22,34),(28,37),(36,35),(42,39),(6,42),(18,44),(30,43),(40,45)] {
            c.rect(x, y, 3, 1, p.parchment)
        }
        // Swinging bridge — cables
        c.rect(18, 20, 12, 1, p.brown)
        // Cables sagging
        for x in 18...30 {
            let t = Double(x - 18) / 12.0
            let sag = Int((4.0 * (0.25 - (t - 0.5) * (t - 0.5))) * 6.0)
            c.px(x, 20 + sag, p.deep)
        }
        // Deck
        for x in 18...30 {
            let t = Double(x - 18) / 12.0
            let arch = Int(1.5 * (0.25 - (t - 0.5) * (t - 0.5)) * 4.0)
            c.px(x, 28 - arch, p.brown)
            c.px(x, 29 - arch, p.deep)
        }
    }

    static let engerPark = PixelSprite(width: 48, height: 48) { c in
        let p = ArtPalette.self
        c.rect(0, 0, 48, 24, p.sky)
        // Lake Superior horizon (dominant)
        c.rect(0, 18, 48, 2, p.waterLight)
        // Distant lake haze
        c.rect(0, 17, 48, 1, p.mountLight.opacity(0.5))
        // Hill ridgeline where Enger sits
        c.rect(0, 24, 48, 4, p.hillDark)
        c.rect(0, 23, 48, 1, p.hillLight)
        // Duluth harbor / city — cluster of rooflines
        c.rect(2, 28, 44, 10, p.stoneDark)
        // Windows
        for x in stride(from: 3, to: 46, by: 3) {
            c.px(x, 31, p.sun)
            c.px(x, 34, p.sun)
        }
        // Aerial Lift Bridge — two towers with lift span
        c.rect(18, 22, 2, 8, p.deep)
        c.rect(28, 22, 2, 8, p.deep)
        c.rect(18, 26, 12, 1, p.deep)
        c.rect(18, 22, 12, 1, p.deep) // top span
        // Water below bridge
        c.rect(0, 30, 48, 18, p.water)
        c.rect(0, 38, 48, 1, p.waterLight)
        c.rect(0, 44, 48, 1, p.waterLight)
        // A laker steaming through
        c.rect(32, 34, 10, 2, p.stoneDark)
        c.rect(34, 32, 2, 2, p.parchment) // pilothouse
        c.px(40, 32, p.stoneDark)
        c.rect(32, 36, 10, 1, p.deep)
    }

    static let gooseberryFalls = PixelSprite(width: 48, height: 48) { c in
        let p = ArtPalette.self
        c.rect(0, 0, 48, 16, p.sky)
        // Tree line
        for x in stride(from: 0, to: 48, by: 3) {
            c.rect(x, 12, 2, 4, p.treeDark)
        }
        // Basalt cliffs — three tiers
        c.rect(0, 16, 48, 6, p.stoneDark)
        c.rect(0, 24, 48, 6, p.stoneDark)
        c.rect(0, 32, 48, 6, p.stoneDark)
        // Tier highlights
        c.rect(0, 16, 48, 1, p.stone)
        c.rect(0, 24, 48, 1, p.stone)
        c.rect(0, 32, 48, 1, p.stone)
        // Waterfall — tea-colored cascade down left-center
        c.rect(16, 16, 14, 6, p.waterLight)
        c.rect(16, 22, 14, 2, p.water)
        c.rect(16, 24, 14, 6, p.waterLight)
        c.rect(16, 30, 14, 2, p.water)
        c.rect(16, 32, 14, 6, p.waterLight)
        // Foam highlights
        for x in stride(from: 17, to: 30, by: 2) {
            c.px(x, 19, p.parchment)
            c.px(x + 1, 27, p.parchment)
            c.px(x, 35, p.parchment)
        }
        // Pool at base
        c.rect(0, 38, 48, 10, p.water)
        c.rect(14, 38, 18, 2, p.parchment.opacity(0.6))
        c.rect(0, 40, 48, 1, p.waterLight)
    }

    static let splitRockLighthouse = PixelSprite(width: 48, height: 48) { c in
        let p = ArtPalette.self
        c.rect(0, 0, 48, 22, p.sky)
        // Lake Superior on the right, horizon
        c.rect(20, 18, 28, 1, p.mountLight)
        // Cliff edge (left) — dark basalt
        c.rect(0, 22, 24, 26, p.stoneDark)
        c.rect(0, 22, 24, 1, p.stone)
        // Lake water
        c.rect(20, 22, 28, 26, p.water)
        c.rect(20, 30, 28, 1, p.waterLight)
        c.rect(20, 38, 28, 1, p.waterLight)
        // Lighthouse on cliff — tall white octagonal tower
        let lx = 10
        // Base
        c.rect(lx - 2, 22, 6, 2, p.stone)
        // Tower
        c.rect(lx - 1, 12, 4, 10, p.parchment)
        c.rect(lx, 11, 2, 1, p.parchment)
        // Tower shadow stripe
        c.rect(lx + 1, 12, 1, 10, p.cloudGray)
        // Lamp room
        c.rect(lx - 2, 8, 6, 3, p.deep)
        c.rect(lx - 1, 6, 4, 2, p.sun) // light lens
        // Red dome
        c.rect(lx - 2, 4, 6, 2, p.coral)
        c.rect(lx - 1, 3, 4, 1, p.coral)
        c.px(lx, 2, p.deep) // finial
        // Keeper's house
        c.rect(14, 18, 8, 4, p.parchment)
        c.rect(13, 17, 10, 1, p.coral) // red roof
        c.rect(14, 17, 8, 1, p.coral)
        // Beam of light
        c.rect(lx + 4, 7, 12, 1, p.sun.opacity(0.3))
        c.rect(lx + 4, 8, 12, 1, p.sun.opacity(0.2))
        // Trees far side
        pine(c, x: 38, y: 22, size: 2)
        pine(c, x: 42, y: 22, size: 2)
    }

    static let palisadeHead = PixelSprite(width: 48, height: 48) { c in
        let p = ArtPalette.self
        c.rect(0, 0, 48, 12, p.sky)
        // Sheer basalt cliff — nearly full height, left side
        c.rect(0, 4, 30, 44, p.stoneDark)
        // Cliff face texture — vertical cracks
        for x in [4, 9, 14, 19, 24] {
            c.col(x, from: 6, to: 44, p.deep)
        }
        // Cliff top edge
        c.rect(0, 3, 30, 1, p.stone)
        // Trees on cliff top
        pine(c, x: 4, y: 4, size: 3)
        pine(c, x: 10, y: 4, size: 4)
        pine(c, x: 16, y: 4, size: 3)
        pine(c, x: 24, y: 4, size: 4)
        // Lake Superior — deep blue, right side
        c.rect(30, 12, 18, 36, p.water)
        // Lake texture
        c.rect(30, 16, 18, 1, p.waterLight)
        c.rect(30, 24, 18, 1, p.waterLight)
        c.rect(30, 34, 18, 1, p.waterLight)
        // Horizon haze
        c.rect(30, 12, 18, 1, p.mountLight.opacity(0.6))
        // Cliff shadow in water
        c.rect(30, 12, 10, 36, p.mountDark.opacity(0.3))
    }

    static let temperanceRiver = PixelSprite(width: 48, height: 48) { c in
        let p = ArtPalette.self
        c.rect(0, 0, 48, 12, p.sky)
        // Trees on top edges
        pine(c, x: 3, y: 12, size: 3)
        pine(c, x: 8, y: 12, size: 4)
        pine(c, x: 39, y: 12, size: 4)
        pine(c, x: 44, y: 12, size: 3)
        // Black basalt walls — narrow canyon
        c.rect(0, 12, 16, 36, p.stoneDark)
        c.rect(32, 12, 16, 36, p.stoneDark)
        c.rect(0, 12, 16, 1, p.stone)
        c.rect(32, 12, 16, 1, p.stone)
        // Wall cracks
        for y in stride(from: 16, to: 46, by: 5) {
            c.px(6, y, p.deep)
            c.px(12, y, p.deep)
            c.px(36, y, p.deep)
            c.px(42, y, p.deep)
        }
        // Narrow river / slot — white water
        c.rect(16, 12, 16, 36, p.water)
        // Turbulent white water
        for y in stride(from: 14, to: 48, by: 3) {
            c.rect(18, y, 12, 1, p.parchment)
            c.rect(16 + (y % 6), y + 1, 3, 1, p.waterLight)
        }
        // Pothole (large scooped rock in river)
        c.rect(20, 34, 8, 4, p.stoneDark)
        c.rect(22, 36, 4, 1, p.water)
    }

    static let carltonPeak = PixelSprite(width: 48, height: 48) { c in
        let p = ArtPalette.self
        c.rect(0, 0, 48, 30, p.sky)
        // Lake Superior stripe on horizon
        c.rect(0, 26, 48, 2, p.mountLight.opacity(0.5))
        c.rect(0, 27, 48, 1, p.water.opacity(0.7))
        // Forest ridge (far)
        c.rect(0, 28, 48, 4, p.hillDark)
        // Anorthosite summit — tumble of boulders
        // Main peak mass
        let peak: [Int] = [
            0,0,0,0,2,4,7,10,13,15,17,18,
            19,20,20,19,18,17,15,12,10,8,
            6,4,2,0,0,0,0,0,0,0,0,0,0,0,
            0,0,0,0,0,0,0,0,0,0,0,0
        ]
        c.silhouette(heights: peak, baselineY: 40, color: p.stone)
        // Boulder texture
        for (x, y) in [(10,30),(14,26),(18,24),(22,25),(16,32),(12,34),(20,33),(14,29)] {
            c.rect(x, y, 3, 2, p.stoneDark)
            c.px(x, y, p.stoneLight)
        }
        // Foreground ground
        c.rect(0, 40, 48, 8, p.grassDark)
        c.rect(0, 38, 48, 2, p.hillDark)
        // Scrubby trees
        pine(c, x: 2, y: 40, size: 3)
        pine(c, x: 6, y: 40, size: 2)
        pine(c, x: 40, y: 40, size: 3)
        pine(c, x: 44, y: 40, size: 4)
    }

    static let beanBearLakes = PixelSprite(width: 48, height: 48) { c in
        let p = ArtPalette.self
        c.rect(0, 0, 48, 14, p.sky)
        // Distant ridges
        let far: [Int] = [
            3,5,7,9,8,6,4,3,5,7,9,8,
            6,4,2,3,5,7,8,10,12,10,8,6,
            4,3,5,7,9,8,6,4,2,3,5,7,
            9,10,8,6,4,3,2,1,0,0,0,0
        ]
        c.silhouette(heights: far, baselineY: 16, color: p.hillDark)
        // Green ridges nearer
        c.rect(0, 16, 48, 3, p.green)
        for x in stride(from: 0, to: 48, by: 2) {
            c.rect(x, 14, 1, 3, p.treeDark)
        }
        // Bean Lake — larger, upper left
        c.rect(8, 22, 16, 8, p.water)
        c.rect(8, 22, 16, 1, p.mountDark)
        c.rect(10, 26, 6, 1, p.waterLight)
        c.rect(18, 28, 4, 1, p.waterLight)
        // Bear Lake — lower right, smaller
        c.rect(26, 32, 14, 7, p.water)
        c.rect(26, 32, 14, 1, p.mountDark)
        c.rect(28, 35, 6, 1, p.waterLight)
        // Surrounding forested ridges
        c.rect(0, 30, 48, 18, p.hillDark)
        // Shores of lakes (cut the forest)
        c.rect(8, 30, 16, 2, p.green)
        c.rect(26, 39, 14, 2, p.green)
        // A loon on Bean Lake (tiny)
        c.rect(14, 25, 3, 1, p.deep)
        c.px(17, 24, p.deep)
        c.px(14, 24, p.deep)
        // Scattered trees
        pine(c, x: 4, y: 46, size: 4)
        pine(c, x: 44, y: 46, size: 4)
    }

    static let caribouFalls = PixelSprite(width: 48, height: 48) { c in
        let p = ArtPalette.self
        c.rect(0, 0, 48, 14, p.sky)
        // Forested cliff edge
        for x in stride(from: 0, to: 24, by: 3) {
            c.rect(x, 10, 2, 4, p.treeDark)
        }
        // Basalt cliff on left
        c.rect(0, 14, 24, 20, p.stoneDark)
        c.rect(0, 14, 24, 1, p.stone)
        // Cracks
        c.col(6, from: 16, to: 32, p.deep)
        c.col(14, from: 16, to: 32, p.deep)
        c.col(20, from: 16, to: 32, p.deep)
        // Waterfall from cliff
        c.rect(12, 14, 8, 20, p.waterLight)
        c.rect(14, 16, 4, 18, p.parchment)
        c.rect(12, 18, 8, 2, p.water)
        c.rect(12, 26, 8, 2, p.water)
        // Lake Superior — blends right side, entire
        c.rect(24, 14, 24, 34, p.water)
        c.rect(24, 14, 24, 1, p.mountLight.opacity(0.7))
        c.rect(24, 20, 24, 1, p.waterLight)
        c.rect(24, 30, 24, 1, p.waterLight)
        c.rect(24, 40, 24, 1, p.waterLight)
        // Where falls meet lake — foam
        c.rect(10, 32, 14, 4, p.parchment.opacity(0.8))
        c.rect(12, 36, 12, 1, p.parchment.opacity(0.6))
        // Merganser and ducklings — tiny
        c.rect(32, 36, 2, 1, p.deep)
        c.px(33, 35, p.coral)
        c.px(36, 36, p.deep)
        c.px(38, 36, p.deep)
        c.px(40, 36, p.deep)
        // Shore rocks
        c.rect(22, 44, 26, 4, p.stoneDark)
    }

    static let grandPortage = PixelSprite(width: 48, height: 48) { c in
        let p = ArtPalette.self
        c.rect(0, 0, 48, 18, p.sky)
        // Lake Superior — vast, with Canada barely visible on far shore
        c.rect(0, 14, 48, 2, p.mountLight.opacity(0.6))
        c.rect(0, 16, 48, 2, p.hillDark.opacity(0.5)) // Canada silhouette
        // Lake
        c.rect(0, 18, 48, 18, p.water)
        c.rect(0, 22, 48, 1, p.waterLight)
        c.rect(0, 28, 48, 1, p.waterLight)
        c.rect(0, 34, 48, 1, p.waterLight)
        // Shore / rocky beach
        c.rect(0, 36, 48, 12, p.stoneDark)
        c.rect(0, 36, 48, 1, p.stone)
        for (x, y) in [(4,39),(10,42),(18,40),(26,43),(34,41),(42,39)] {
            c.rect(x, y, 3, 2, p.stone)
        }
        // Tall pines on left
        pine(c, x: 3, y: 36, size: 5)
        pine(c, x: 7, y: 36, size: 4)
        // Boundary marker / cairn with painted stripe
        c.rect(22, 30, 4, 8, p.stone)
        c.rect(22, 30, 4, 1, p.coral) // painted top
        c.rect(22, 34, 4, 1, p.parchment) // stripe
        // Terminus sign post
        c.rect(30, 32, 1, 8, p.brown)
        c.rect(29, 32, 6, 3, p.parchment)
        c.px(31, 33, p.deep) // text hints
        c.px(32, 33, p.deep)
        c.px(33, 33, p.deep)
    }
}

private enum ParallaxArtSHT {
    /// Includes Lake Superior horizon strip — visible behind the mountain layer.
    static let sky = PixelSprite(width: 8, height: 8) { c in
        c.rect(0, 0, 8, 8, ArtPalette.sky)
        // Subtle lake-country haze
        c.rect(0, 0, 8, 2, ArtPalette.mountLight.opacity(0.3))
    }

    static let mountains = PixelSprite(width: 256, height: 96) { c in
        let p = ArtPalette.self
        // Sky wash
        c.rect(0, 0, 256, 96, p.sky)
        // Horizon haze
        c.rect(0, 46, 256, 4, p.mountLight.opacity(0.5))
        // Lake Superior horizon strip — THIS is the signature SHT backdrop
        c.rect(0, 50, 256, 10, p.water.opacity(0.9))
        c.rect(0, 50, 256, 1, p.mountDark.opacity(0.8))
        // Sparkle on lake
        for x in stride(from: 6, to: 256, by: 14) {
            c.px(x, 54, p.waterLight)
            c.px(x + 4, 57, p.waterLight)
        }
        // Low rolling Sawtooth basalt ridges
        var heights: [Int] = []
        let control: [Int] = [26, 32, 24, 30, 34, 22, 28, 36, 26, 22, 28, 30, 24, 26]
        var adjusted = control
        adjusted[adjusted.count - 1] = adjusted[0]
        let span = 256 / (adjusted.count - 1)
        for seg in 0..<(adjusted.count - 1) {
            let a = adjusted[seg]; let b = adjusted[seg + 1]
            for i in 0..<span {
                let t = Double(i) / Double(span)
                heights.append(Int((Double(a) * (1 - t) + Double(b) * t).rounded()))
            }
        }
        while heights.count < 256 { heights.append(heights.last ?? 0) }
        c.silhouette(heights: heights, baselineY: 95, color: p.mountDark)
        // Sawtooth ridge lighter face
        for x in 0..<256 {
            let h = heights[x]
            if h > 4 {
                let top = 95 - h + 1
                c.col(x, from: top, to: top + h / 4, p.hillDark)
            }
        }
    }

    static let hills = PixelSprite(width: 256, height: 64) { c in
        let p = ArtPalette.self
        var heights: [Int] = []
        let control: [Int] = [16, 22, 28, 24, 30, 20, 26, 30, 24, 20, 24, 28, 18, 16]
        var adjusted = control
        adjusted[adjusted.count - 1] = adjusted[0]
        let span = 256 / (adjusted.count - 1)
        for seg in 0..<(adjusted.count - 1) {
            let a = adjusted[seg]; let b = adjusted[seg + 1]
            for i in 0..<span {
                let t = Double(i) / Double(span)
                heights.append(Int((Double(a) * (1 - t) + Double(b) * t).rounded()))
            }
        }
        while heights.count < 256 { heights.append(heights.last ?? 0) }
        c.silhouette(heights: heights, baselineY: 63, color: p.hillDark)
        for x in 0..<256 {
            let h = heights[x]
            if h > 0 {
                let top = 63 - h + 1
                c.col(x, from: top, to: top + max(1, h / 3), p.hillLight)
            }
        }
        // Mixed birch/aspen/spruce — white trunks scattered among dark conifers
        for x in stride(from: 3, to: 256, by: 6) {
            let h = heights[x]
            if h > 3 {
                let baseY = 63 - h
                if x % 12 == 3 {
                    // Birch — white trunk
                    c.rect(x, baseY - 4, 1, 4, p.parchment)
                    c.px(x, baseY - 2, p.deep)
                    c.rect(x - 1, baseY - 4, 3, 1, p.hillLight)
                } else {
                    // Spruce
                    c.rect(x, baseY - 4, 1, 4, p.treeDark)
                    c.rect(x - 1, baseY - 3, 3, 1, p.green)
                    c.rect(x - 1, baseY - 1, 3, 1, p.green)
                }
            }
        }
    }

    static let ground = PixelSprite(width: 32, height: 16) { c in
        let p = ArtPalette.self
        // Boreal duff — darker, richer than JMT
        c.rect(0, 0, 32, 16, p.brown)
        c.rect(0, 0, 32, 2, p.treeDark)
        c.rect(0, 2, 32, 1, p.green.opacity(0.6))
        // Basalt pebbles
        c.px(4, 8, p.stoneDark)
        c.px(9, 10, p.stoneDark)
        c.px(15, 7, p.stone)
        c.px(22, 11, p.stoneDark)
        c.px(27, 9, p.stoneDark)
        c.px(6, 13, p.stoneDark)
        c.px(20, 14, p.stone)
        // Lichen specks
        c.px(12, 6, p.hillLight)
        c.px(26, 7, p.hillLight)
    }
}

private enum FinaleArtSHT {
    static let sht = PixelSprite(width: 512, height: 320) { c in
        let p = ArtPalette.self
        // Predawn sky with aurora
        c.rect(0, 0, 512, 40, p.deep)
        c.rect(0, 40, 512, 40, p.mountDark)
        c.rect(0, 80, 512, 40, p.mountBlue)
        c.rect(0, 120, 512, 60, p.sky)
        // Aurora bands — green/purple ribbons across the upper sky
        for y in 10..<70 {
            let t = Double(y) / 60.0
            let a = 0.4 - t * 0.3
            for x in 0..<512 {
                let phase = Double(x) * 0.02 + t * 3.0
                let wave = sin(phase) * 6.0 + sin(phase * 1.7) * 3.0
                let yOff = y + Int(wave)
                if yOff >= 10 && yOff < 80 && (x + yOff) % 3 == 0 {
                    c.px(x, yOff, p.green.opacity(a))
                }
                if yOff >= 10 && yOff < 80 && (x + yOff * 2) % 7 == 0 {
                    c.px(x, yOff, p.coral.opacity(a * 0.5))
                }
            }
        }
        // Lake Superior — dominates the middle
        c.rect(0, 180, 512, 70, p.mountDark)
        c.rect(0, 180, 512, 4, p.mountLight.opacity(0.6))
        c.rect(0, 200, 512, 1, p.waterLight.opacity(0.3))
        c.rect(0, 215, 512, 1, p.waterLight.opacity(0.3))
        c.rect(0, 235, 512, 1, p.waterLight.opacity(0.3))
        // Lake sparkle — moonlight/pre-dawn shimmer
        for x in stride(from: 10, to: 512, by: 20) {
            c.px(x, 195, p.parchment.opacity(0.4))
            c.px(x + 8, 210, p.parchment.opacity(0.3))
            c.px(x + 4, 225, p.parchment.opacity(0.3))
        }
        // Distant lighthouse on far point — Split Rock silhouette
        let llx = 380
        c.rect(llx - 1, 172, 3, 10, p.parchment.opacity(0.7))
        c.rect(llx - 2, 168, 5, 4, p.deep.opacity(0.8))
        c.px(llx, 166, p.sun)
        // Beam
        c.rect(llx + 3, 170, 40, 1, p.sun.opacity(0.2))
        c.rect(llx + 3, 171, 40, 1, p.sun.opacity(0.15))
        // Far shore (Canada-side or distant point)
        c.rect(350, 180, 50, 3, p.treeDark.opacity(0.7))
        for x in stride(from: 350, to: 400, by: 4) {
            c.rect(x, 177, 1, 3, p.treeDark)
        }
        // Basalt cliff foreground — hiker stands here
        c.rect(0, 250, 512, 70, p.stoneDark)
        c.rect(0, 248, 512, 3, p.stone)
        // Cliff cracks
        for x in stride(from: 20, to: 512, by: 40) {
            c.col(x, from: 255, to: 310, p.deep)
        }
        // Trees on cliff
        for x in [40, 80, 130, 470] {
            c.rect(x, 244, 1, 6, p.treeDark)
            c.rect(x - 2, 240, 5, 1, p.green)
            c.rect(x - 3, 242, 7, 1, p.green)
            c.rect(x - 2, 246, 5, 1, p.green)
        }
        // Hiker silhouette at cliff edge, pack on, arms at sides
        let hx = 260, hy = 222
        c.rect(hx - 2, hy, 4, 1, p.deep) // hat
        c.rect(hx - 3, hy + 1, 6, 1, p.deep)
        c.rect(hx - 1, hy + 2, 3, 3, p.skin)
        c.rect(hx - 3, hy + 5, 7, 10, p.coral) // torso + pack
        c.rect(hx - 4, hy + 6, 1, 6, p.coral) // arm
        c.rect(hx + 4, hy + 6, 1, 6, p.coral)
        c.rect(hx - 2, hy + 15, 2, 10, p.mountBlue)
        c.rect(hx + 1, hy + 15, 2, 10, p.mountBlue)
        c.rect(hx - 2, hy + 25, 2, 1, p.deep)
        c.rect(hx + 1, hy + 25, 2, 1, p.deep)
    }
}

private enum BadgeArtSHT {
    static func plate(_ c: PixelCanvas, tint: Color, interior: (PixelCanvas) -> Void) {
        let p = ArtPalette.self
        c.rect(4, 4, 24, 24, tint)
        c.rect(6, 2, 20, 2, tint)
        c.rect(6, 28, 20, 2, tint)
        c.rect(2, 6, 2, 20, tint)
        c.rect(28, 6, 2, 20, tint)
        c.rect(6, 6, 20, 20, p.parchment)
        c.rect(6, 6, 20, 1, p.sand)
        c.rect(6, 25, 20, 1, p.sand)
        c.rect(6, 6, 1, 20, p.sand)
        c.rect(25, 6, 1, 20, p.sand)
        interior(c)
    }

    static let gitchiGumiWalker = PixelSprite(width: 32, height: 32) { c in
        plate(c, tint: ArtPalette.mountBlue) { c in
            let p = ArtPalette.self
            // Water — filling lower half
            c.rect(7, 16, 18, 9, p.water)
            c.rect(7, 16, 18, 1, p.mountDark)
            c.rect(8, 19, 16, 1, p.waterLight)
            c.rect(8, 22, 16, 1, p.waterLight)
            // Small island / point with lighthouse
            c.rect(14, 13, 6, 3, p.stoneDark)
            c.rect(16, 10, 2, 3, p.parchment)
            c.rect(15, 8, 4, 2, p.deep)
            c.rect(15, 7, 4, 1, p.coral)
            c.px(16, 6, p.deep)
            // Sky above
            c.rect(7, 9, 7, 7, p.sky)
            c.rect(20, 9, 5, 7, p.sky)
            // Tiny boat
            c.rect(9, 22, 3, 1, p.deep)
            c.px(10, 21, p.coral)
        }
    }

    static let lighthouseFriend = PixelSprite(width: 32, height: 32) { c in
        plate(c, tint: ArtPalette.coral) { c in
            let p = ArtPalette.self
            // Background night sky in badge center
            c.rect(7, 7, 18, 14, p.mountBlue)
            // Lighthouse tower
            c.rect(15, 10, 2, 10, p.parchment)
            c.rect(14, 9, 4, 1, p.deep)
            c.rect(14, 20, 4, 1, p.deep)
            // Lamp room
            c.rect(14, 7, 4, 2, p.deep)
            c.rect(15, 6, 2, 1, p.sun)
            // Red dome
            c.rect(14, 5, 4, 1, p.coral)
            c.rect(15, 4, 2, 1, p.coral)
            // Light beam — wedge radiating right
            c.px(18, 7, p.sun.opacity(0.6))
            c.px(19, 6, p.sun.opacity(0.4))
            c.px(20, 7, p.sun.opacity(0.3))
            c.px(19, 8, p.sun.opacity(0.4))
            c.px(20, 8, p.sun.opacity(0.3))
            c.px(21, 7, p.sun.opacity(0.2))
            c.px(21, 8, p.sun.opacity(0.2))
            // Water base
            c.rect(7, 21, 18, 4, p.water)
            c.rect(7, 21, 18, 1, p.waterLight)
        }
    }

    static let mooseTracker = PixelSprite(width: 32, height: 32) { c in
        plate(c, tint: ArtPalette.brown) { c in
            let p = ArtPalette.self
            // Moose silhouette — unmistakable bulky body, long legs, drooping muzzle
            // Body
            c.rect(10, 14, 10, 6, p.bear)
            c.rect(11, 13, 8, 1, p.bear)
            // Hump (shoulder)
            c.rect(10, 12, 4, 2, p.bear)
            // Neck
            c.rect(19, 13, 2, 3, p.bear)
            // Head
            c.rect(20, 10, 3, 4, p.bear)
            // Muzzle — droops forward
            c.rect(22, 12, 2, 3, p.bear)
            // Antlers — paddled
            c.rect(18, 8, 3, 1, p.brown)
            c.rect(17, 9, 1, 1, p.brown)
            c.rect(21, 9, 3, 1, p.brown)
            c.rect(24, 8, 1, 2, p.brown)
            // Legs — four long
            c.rect(11, 20, 1, 4, p.bear)
            c.rect(13, 20, 1, 4, p.bear)
            c.rect(16, 20, 1, 4, p.bear)
            c.rect(18, 20, 1, 4, p.bear)
            // Tiny eye
            c.px(21, 11, p.sunrise)
            // Hoof-track below
            c.rect(10, 24, 2, 2, p.deep)
            c.rect(14, 25, 2, 2, p.deep)
        }
    }

    static let northShoreChronicler = PixelSprite(width: 32, height: 32) { c in
        plate(c, tint: ArtPalette.mountBlue) { c in
            let p = ArtPalette.self
            // Open book — pages
            c.rect(8, 11, 8, 12, p.paperYellow)
            c.rect(16, 11, 8, 12, p.paperYellow)
            c.rect(15, 10, 2, 14, p.brown)
            // Outer covers
            c.rect(7, 10, 1, 14, p.deep)
            c.rect(24, 10, 1, 14, p.deep)
            c.rect(8, 10, 7, 1, p.deep)
            c.rect(17, 10, 7, 1, p.deep)
            c.rect(8, 23, 16, 1, p.deep)
            // Wave symbol across the spine — three wavy lines
            c.px(9, 14, p.water); c.px(10, 13, p.water); c.px(11, 14, p.water)
            c.px(12, 13, p.water); c.px(13, 14, p.water); c.px(14, 13, p.water)
            c.px(17, 14, p.water); c.px(18, 13, p.water); c.px(19, 14, p.water)
            c.px(20, 13, p.water); c.px(21, 14, p.water); c.px(22, 13, p.water)
            c.px(9, 17, p.water); c.px(10, 16, p.water); c.px(11, 17, p.water)
            c.px(12, 16, p.water); c.px(13, 17, p.water); c.px(14, 16, p.water)
            c.px(17, 17, p.water); c.px(18, 16, p.water); c.px(19, 17, p.water)
            c.px(20, 16, p.water); c.px(21, 17, p.water); c.px(22, 16, p.water)
            // Text lines below
            c.rect(9, 19, 5, 1, p.brown)
            c.rect(9, 21, 4, 1, p.brown)
            c.rect(17, 19, 5, 1, p.brown)
            c.rect(17, 21, 3, 1, p.brown)
        }
    }
}

// MARK: - Color helpers

private extension ArtPalette {
    static func forestGreen(opacity: Double) -> Color {
        Color(red: 0.357, green: 0.549, blue: 0.353).opacity(opacity)
    }
}
