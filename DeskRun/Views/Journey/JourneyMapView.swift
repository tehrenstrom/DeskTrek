import SwiftUI

struct JourneyMapView: View {
    let appState: AppState

    @State private var showAbandonConfirm = false

    private var active: JourneyState? { appState.journeyStore.active }
    private var trail: Trail? { appState.journeyEngine.currentTrail ?? (active.flatMap { TrailCatalog.trail(for: $0.trailID) }) }

    var body: some View {
        ZStack(alignment: .topLeading) {
            if let trail, let active {
                mapScene(trail: trail, active: active)
            } else {
                Text("No active journey.")
                    .font(.system(size: 14, design: .monospaced))
                    .foregroundStyle(TrailColor.text.opacity(0.5))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }

            // Encounter banner
            if let encounter = appState.journeyEngine.pendingEncounter {
                EncounterBanner(
                    encounter: encounter,
                    onChoose: { choiceID in
                        appState.journeyEngine.resolve(choiceID: choiceID, wasDefault: false)
                    }
                )
                .padding(.top, 16)
                .transition(.move(edge: .top).combined(with: .opacity))
                .frame(maxWidth: .infinity)
            } else if let resultText = appState.journeyEngine.lastResultText {
                EncounterResultToast(text: resultText) {
                    appState.journeyEngine.dismissResultText()
                }
                .padding(.top, 16)
                .frame(maxWidth: .infinity)
            }

            if let landmark = appState.journeyEngine.pendingLandmark {
                LandmarkNoticeView(landmark: landmark.landmark) {
                    appState.journeyEngine.dismissLandmarkNotice()
                }
                .padding(.top, 80)
                .transition(.scale.combined(with: .opacity))
                .frame(maxWidth: .infinity)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: appState.journeyEngine.pendingEncounter?.id)
        .animation(.easeInOut(duration: 0.3), value: appState.journeyEngine.pendingLandmark?.id)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(TrailColor.sky)
        .navigationTitle(trail?.name ?? "Trail")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                let tracking = appState.journeyEngine.isTrackingEnabled
                Button(tracking ? "Pause Tracking" : "Resume Tracking") {
                    appState.journeyEngine.setTrackingEnabled(!tracking)
                }
                .foregroundStyle(tracking ? TrailColor.mountainBlue : TrailColor.forestGreen)
            }
            ToolbarItem(placement: .primaryAction) {
                Button("Abandon") { showAbandonConfirm = true }
                    .foregroundStyle(TrailColor.coral)
            }
        }
        .confirmationDialog(
            "Abandon this journey? Progress moves to history.",
            isPresented: $showAbandonConfirm
        ) {
            Button("Abandon", role: .destructive) {
                appState.journeyEngine.abandon()
            }
            Button("Keep hiking", role: .cancel) {}
        }
    }

    @ViewBuilder
    private func mapScene(trail: Trail, active: JourneyState) -> some View {
        GeometryReader { geo in
            let pausedBannerHeight: CGFloat = active.isTrackingEnabled ? 0 : 32
            VStack(spacing: 0) {
                if !active.isTrackingEnabled {
                    pausedBanner
                        .frame(height: pausedBannerHeight)
                }
                mapCanvas(trail: trail, active: active, width: geo.size.width)
                    .frame(height: geo.size.height - 120 - pausedBannerHeight)

                StatsBar(state: active, trail: trail, speed: appState.treadmillState.currentSpeed)
                    .frame(height: 120)
            }
        }
    }

    private var pausedBanner: some View {
        HStack(spacing: 8) {
            Image(systemName: "pause.circle.fill")
                .foregroundStyle(TrailColor.forestGreen)
            Text("JOURNEY PAUSED — WALKING NOW WON'T ADD MILES")
                .font(.system(size: 11, weight: .bold, design: .monospaced))
                .foregroundStyle(TrailColor.darkEarth)
                .tracking(2)
            Spacer()
            Button("Resume") {
                appState.journeyEngine.setTrackingEnabled(true)
            }
            .buttonStyle(RetroSecondaryButtonStyle())
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
        .background(TrailColor.forestGreen.opacity(0.2))
    }

    @ViewBuilder
    private func mapCanvas(trail: Trail, active: JourneyState, width: CGFloat) -> some View {
        let pxPerMile: CGFloat = 80
        let hikerOffsetX: CGFloat = width * 0.3

        TimelineView(.animation(minimumInterval: 1.0 / 12.0)) { timeline in
            ZStack(alignment: .bottomLeading) {
                // Sky background (static)
                TrailColor.sky
                    .ignoresSafeArea()

                // Parallax mountains (slow scroll)
                ParallaxLayer(
                    assetName: trail.mapArt.mountainAsset,
                    width: 512,
                    height: 160,
                    scrollOffset: CGFloat(active.milesTraveled) * pxPerMile * 0.3,
                    fallbackColor: TrailColor.mountainBlue.opacity(0.6)
                )
                .frame(height: 160)
                .offset(y: -90)

                // Parallax hills
                ParallaxLayer(
                    assetName: trail.mapArt.hillAsset,
                    width: 512,
                    height: 120,
                    scrollOffset: CGFloat(active.milesTraveled) * pxPerMile * 0.6,
                    fallbackColor: TrailColor.forestGreen.opacity(0.6)
                )
                .frame(height: 120)
                .offset(y: -30)

                // Trail ribbon (the ground line hiker walks on)
                Rectangle()
                    .fill(TrailColor.desertSand)
                    .frame(height: 24)
                    .overlay(
                        Rectangle()
                            .fill(TrailColor.darkEarth.opacity(0.2))
                            .frame(height: 2)
                            .offset(y: 11)
                    )

                // Landmarks ahead/behind hiker
                ForEach(trail.landmarks) { landmark in
                    let worldOffset = (landmark.mileMarker - active.milesTraveled) * Double(pxPerMile)
                    let screenX = hikerOffsetX + CGFloat(worldOffset)
                    if screenX > -100 && screenX < width + 100 {
                        LandmarkSprite(
                            landmark: landmark,
                            highlighted: active.visitedLandmarkIDs.contains(landmark.id)
                        )
                        .position(x: screenX, y: 40)
                    }
                }

                // Hiker sprite
                HikerSprite(size: 56, date: timeline.date)
                    .position(x: hikerOffsetX, y: 40)

                // Mile marker text above hiker
                Text(String(format: "MILE %.1f / %.0f", active.milesTraveled, trail.totalMiles))
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .foregroundStyle(TrailColor.darkEarth)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(TrailColor.parchment)
                    .overlay(
                        Rectangle()
                            .strokeBorder(TrailColor.darkEarth, lineWidth: 1)
                    )
                    .position(x: hikerOffsetX, y: 100)
            }
        }
    }
}

// MARK: - Stats Bar

private struct StatsBar: View {
    let state: JourneyState
    let trail: Trail
    let speed: Double

    var body: some View {
        VStack(spacing: 8) {
            RetroProgressBar(
                progress: state.progressPercentage,
                fillColor: TrailColor.forestGreen,
                height: 10
            )
            HStack(alignment: .top, spacing: 18) {
                stat(label: "MILES", value: String(format: "%.1f", state.milesTraveled))
                stat(label: "REMAINING", value: String(format: "%.0f", max(0, trail.totalMiles - state.milesTraveled)))
                stat(label: "MORALE", value: "\(state.morale)", tint: moraleColor(state.morale))
                stat(label: "ENERGY", value: "\(state.energy)", tint: energyColor(state.energy))
                stat(label: "SPEED", value: String(format: "%.1f km/h", speed))
                if let target = state.targetCompletionDate {
                    stat(label: "TARGET", value: shortDate(target), tint: state.isOverdue ? TrailColor.coral : TrailColor.text)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .frame(maxWidth: .infinity)
        .background(TrailColor.parchment)
        .overlay(
            Rectangle()
                .frame(height: 2)
                .foregroundStyle(TrailColor.darkEarth),
            alignment: .top
        )
    }

    private func stat(label: String, value: String, tint: Color = TrailColor.text) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(.system(size: 9, weight: .bold, design: .monospaced))
                .foregroundStyle(TrailColor.text.opacity(0.55))
                .tracking(1)
            Text(value)
                .font(.system(size: 14, weight: .bold, design: .monospaced))
                .foregroundStyle(tint)
        }
    }

    private func moraleColor(_ m: Int) -> Color {
        if m >= 75 { return TrailColor.forestGreen }
        if m >= 40 { return TrailColor.text }
        return TrailColor.coral
    }

    private func energyColor(_ e: Int) -> Color {
        if e >= 50 { return TrailColor.forestGreen }
        if e >= 20 { return TrailColor.desertSand }
        return TrailColor.coral
    }

    private func shortDate(_ d: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "MMM d"
        return f.string(from: d)
    }
}

// MARK: - Encounter Result Toast

private struct EncounterResultToast: View {
    let text: String
    let onDismiss: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "sparkle")
                .foregroundStyle(TrailColor.forestGreen)
            Text(text)
                .font(.system(size: 12, design: .monospaced))
                .foregroundStyle(TrailColor.text)
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
            Button("OK") { onDismiss() }
                .buttonStyle(RetroSecondaryButtonStyle())
        }
        .padding(14)
        .frame(maxWidth: 520)
        .background(TrailColor.parchment)
        .overlay(
            Rectangle()
                .strokeBorder(TrailColor.forestGreen, lineWidth: 2)
        )
        .shadow(color: .black.opacity(0.15), radius: 4, y: 2)
    }
}

// MARK: - Landmark Notice

private struct LandmarkNoticeView: View {
    let landmark: Landmark
    let onDismiss: () -> Void

    var body: some View {
        VStack(spacing: 10) {
            Text("LANDMARK REACHED")
                .font(.system(size: 11, weight: .bold, design: .monospaced))
                .foregroundStyle(TrailColor.coral)
                .tracking(2)

            PixelImage(assetName: landmark.spriteAsset, size: 96)

            Text(landmark.name.uppercased())
                .font(.system(size: 16, weight: .black, design: .monospaced))
                .foregroundStyle(TrailColor.darkEarth)
                .tracking(2)

            Text(landmark.flavorText)
                .font(.system(size: 11, design: .monospaced))
                .foregroundStyle(TrailColor.text)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: 360)

            Button("Continue") { onDismiss() }
                .buttonStyle(RetroButtonStyle(tint: TrailColor.forestGreen))
        }
        .padding(20)
        .background(TrailColor.parchment)
        .overlay(
            Rectangle()
                .strokeBorder(TrailColor.darkEarth, lineWidth: 3)
        )
        .shadow(color: .black.opacity(0.25), radius: 8, y: 4)
    }
}
