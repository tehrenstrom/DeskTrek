import SwiftUI

/// A 4-frame walk-cycle hiker sprite. When the treadmill is moving, the cycle
/// period scales inversely with speed — faster treadmill → faster legs.
/// When speed is ~0 the sprite locks to the idle pose (frame 0).
struct HikerSprite: View {
    let size: CGFloat
    let date: Date
    var speedKmh: Double = 0

    private static let idleThresholdKmh = 0.1

    private var frame: Int {
        guard speedKmh > Self.idleThresholdKmh else { return 0 }
        // At 4 km/h, one full 4-frame cycle per second (250 ms per frame).
        // At 2 km/h that becomes 500 ms per frame; at 6 km/h it drops to ~167 ms.
        // Clamp the lower bound so a very slow trickle doesn't stall the animation.
        let framePeriod = max(0.09, 0.25 * (4.0 / speedKmh))
        let cyclePeriod = framePeriod * 4
        let cyclePos = date.timeIntervalSinceReferenceDate.truncatingRemainder(dividingBy: cyclePeriod)
        return Int(cyclePos / framePeriod) % 4
    }

    var body: some View {
        PixelImage(assetName: "hiker.walk.\(frame)", size: size)
    }
}
