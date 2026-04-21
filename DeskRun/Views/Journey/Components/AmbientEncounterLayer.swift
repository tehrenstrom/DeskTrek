import SwiftUI

/// Renders a single band of ambient actors (sky, distance, or foreground)
/// inside the journey map's TimelineView. Also triggers rare flavor captions
/// on the engine when a notable species spawns.
///
/// The scheduler is stateless and deterministic, so this view is safe to
/// recompute every animation frame — same input produces the same actor set
/// and positions, with no flicker.
struct AmbientEncounterLayer: View {
    let band: AmbientZLayer
    let trailID: String
    let milesTraveled: Double
    let speedKmh: Double
    let isTrackingEnabled: Bool
    let date: Date
    let bandFrame: CGRect
    let hikerScreenX: CGFloat
    let pxPerMile: CGFloat
    /// Called when a notable species spawns. The journey engine decides
    /// whether to actually surface a caption (rate-limits and defers to
    /// active encounters / landmarks).
    var onNotableSpawn: ((AmbientSpecies) -> Void)? = nil

    @State private var lastNotableIndex: [AmbientZLayer: Double] = [:]

    var body: some View {
        let context = AmbientLayoutContext(
            bandWidth: bandFrame.width,
            bandHeight: bandFrame.height,
            bandOriginY: bandFrame.minY,
            hikerScreenX: hikerScreenX,
            pxPerMile: pxPerMile
        )

        let renders = AmbientScheduler.activeActors(
            trailID: trailID,
            milesTraveled: milesTraveled,
            speedKmh: speedKmh,
            isTrackingEnabled: isTrackingEnabled,
            date: date,
            band: band,
            context: context
        )

        ZStack(alignment: .topLeading) {
            ForEach(renders) { render in
                PixelImage(assetName: render.assetKey)
                    .frame(width: render.width, height: render.height)
                    .scaleEffect(x: render.flipH ? -1 : 1, y: 1, anchor: .center)
                    .opacity(render.opacity)
                    .position(x: render.x, y: render.y)
                    .allowsHitTesting(false)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .allowsHitTesting(false)
        .onChange(of: milesTraveled) { oldValue, newValue in
            guard let onNotableSpawn else { return }
            if let actor = AmbientScheduler.newlySpawnedNotable(
                trailID: trailID,
                milesTraveled: newValue,
                previousMilesTraveled: oldValue,
                speedKmh: speedKmh,
                isTrackingEnabled: isTrackingEnabled,
                date: date,
                band: band,
                context: context
            ) {
                onNotableSpawn(actor.species)
            }
        }
    }
}
