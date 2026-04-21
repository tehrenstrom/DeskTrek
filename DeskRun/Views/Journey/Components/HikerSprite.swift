import SwiftUI

/// A tiny 4-frame walk-cycle hiker sprite. Cycles frames from a timeline date.
struct HikerSprite: View {
    let size: CGFloat
    let date: Date

    private var frame: Int {
        let cyclePos = date.timeIntervalSinceReferenceDate.truncatingRemainder(dividingBy: 0.6)
        return Int(cyclePos / 0.15) % 4
    }

    var body: some View {
        PixelImage(assetName: "hiker.walk.\(frame)", size: size)
    }
}
