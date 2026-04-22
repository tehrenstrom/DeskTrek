import SwiftUI

/// An inline control panel shown at the top of the Journey-mode Dashboard.
/// Wraps the treadmill for a focused "free walk" session: start/pause/stop,
/// speed presets, and an explicit Save-Walk action. Auto-save is already
/// handled by `WorkoutRecorder` after 30 s of zero speed; this card surfaces
/// those same controls in one place.
struct FreeWalkControlCard: View {
    let appState: AppState

    private var state: TreadmillState { appState.treadmillState }
    private var bleManager: TreadmillBLEManager { appState.bleManager }
    private var settings: AppSettings { appState.settings }
    private var recorder: WorkoutRecorder { appState.workoutRecorder }
    private var walkSession: WalkSession { appState.walkSession }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            header

            switch state.connectionStatus {
            case .connected:
                connectedBody
            case .scanning, .connecting:
                scanningBody
            case .disconnected, .error:
                disconnectedBody
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(TrailColor.parchment)
        .overlay(
            Rectangle()
                .strokeBorder(TrailColor.darkEarth, lineWidth: 2)
        )
    }

    // MARK: - Header

    private var header: some View {
        HStack(spacing: 10) {
            Image(systemName: "figure.walk")
                .font(.system(size: 18))
                .foregroundStyle(TrailColor.coral)
            Text("FREE WALK")
                .font(.system(size: 13, weight: .bold, design: .monospaced))
                .foregroundStyle(TrailColor.darkEarth)
                .tracking(2)
            Spacer()
            HStack(spacing: 6) {
                Circle()
                    .fill(connectionDotColor)
                    .frame(width: 8, height: 8)
                Text(state.connectionStatus.rawValue.uppercased())
                    .font(.system(size: 10, weight: .medium, design: .monospaced))
                    .foregroundStyle(TrailColor.text.opacity(0.6))
                    .tracking(1)
            }
        }
    }

    // MARK: - Connected state

    private var connectedBody: some View {
        VStack(alignment: .leading, spacing: 12) {
            liveStats
            speedPresetRow
            actionRow
            footerHint
        }
    }

    private var liveStats: some View {
        HStack(alignment: .firstTextBaseline, spacing: 20) {
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(settings.speedValueString(displayedSpeed))
                    .font(.system(size: 38, weight: .black, design: .monospaced))
                    .foregroundStyle(TrailColor.darkEarth)
                    .monospacedDigit()
                Text(settings.speedUnitShort)
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(TrailColor.text.opacity(0.6))
            }
            Spacer()
            stat("DISTANCE", value: settings.distanceString(state.distance, decimals: 2))
            stat("DURATION", value: state.formattedDuration)
            stat("STEPS", value: "\(state.steps)")
        }
    }

    private func stat(_ label: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(.system(size: 9, weight: .bold, design: .monospaced))
                .foregroundStyle(TrailColor.text.opacity(0.55))
                .tracking(1)
            Text(value)
                .font(.system(size: 13, weight: .bold, design: .monospaced))
                .foregroundStyle(TrailColor.darkEarth)
                .monospacedDigit()
        }
    }

    private var speedPresetRow: some View {
        HStack(spacing: 6) {
            Button(action: { adjustSpeed(-settings.speedIncrement) }) {
                Image(systemName: "minus")
                    .frame(width: 28, height: 28)
            }
            .buttonStyle(.bordered)
            .controlSize(.small)

            ForEach(settings.speedPresets, id: \.self) { displaySpeed in
                Button(settings.speedPresetLabel(displaySpeed)) {
                    let speed = settings.kilometersPerHour(fromDisplaySpeed: displaySpeed)
                    state.targetSpeed = speed
                    bleManager.setSpeed(speed)
                }
                .buttonStyle(.bordered)
                .tint(settings.isSelectedSpeedPreset(state.targetSpeed, displayPreset: displaySpeed) ? TrailColor.coral : nil)
                .controlSize(.small)
            }

            Button(action: { adjustSpeed(settings.speedIncrement) }) {
                Image(systemName: "plus")
                    .frame(width: 28, height: 28)
            }
            .buttonStyle(.bordered)
            .controlSize(.small)

            Spacer()
        }
    }

    @ViewBuilder
    private var actionRow: some View {
        HStack(spacing: 10) {
            if state.isRunning {
                Button(action: { bleManager.pauseTreadmill() }) {
                    Label("Pause", systemImage: "pause.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(RetroSecondaryButtonStyle())

                Button(action: { bleManager.stopTreadmill() }) {
                    Label("Stop", systemImage: "stop.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(RetroButtonStyle(tint: TrailColor.coral))
            } else {
                Button(action: {
                    walkSession.markFreeWalk()
                    let speed = state.targetSpeed > 0 ? state.targetSpeed : settings.defaultSpeed
                    bleManager.startTreadmill(speed: speed)
                }) {
                    Label("Start Walking", systemImage: "figure.walk")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(RetroButtonStyle(tint: TrailColor.forestGreen))

                // If a session is in progress (i.e. paused by the user), surface
                // an explicit Save action so they don't have to wait 30 s for the
                // auto-save timer to fire.
                if recorder.isRecording {
                    Button(action: { recorder.stopRecording() }) {
                        Label("Save Walk", systemImage: "tray.and.arrow.down.fill")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(RetroButtonStyle(tint: TrailColor.mountainBlue))
                }
            }
        }
    }

    private var footerHint: some View {
        Text(hintText)
            .font(.system(size: 10, weight: .medium, design: .monospaced))
            .foregroundStyle(TrailColor.text.opacity(0.55))
            .tracking(1)
    }

    private var hintText: String {
        if recorder.isRecording && !state.isRunning {
            return "PAUSED · TAP SAVE WALK OR START AGAIN TO CONTINUE"
        }
        if recorder.isRecording {
            return "RECORDING · SAVES WHEN YOU STOP"
        }
        return "PRESS START TO BEGIN A FREE WALK"
    }

    // MARK: - Scanning / Disconnected

    private var scanningBody: some View {
        HStack(spacing: 10) {
            ProgressView()
                .controlSize(.small)
            Text("SCANNING FOR TREADMILL...")
                .font(.system(size: 11, weight: .medium, design: .monospaced))
                .foregroundStyle(TrailColor.text.opacity(0.7))
                .tracking(1)
            Spacer()
        }
    }

    private var disconnectedBody: some View {
        Button(action: { bleManager.startScanning() }) {
            Label("Connect Treadmill", systemImage: "antenna.radiowaves.left.and.right")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(RetroButtonStyle(tint: TrailColor.mountainBlue))
    }

    // MARK: - Helpers

    /// See note in JourneyWalkCard: show target (intent) so the readout matches
    /// the preset the user just tapped, instead of lagging the treadmill's ramp.
    private var displayedSpeed: Double {
        state.targetSpeed > 0 ? state.targetSpeed : state.currentSpeed
    }

    private var connectionDotColor: Color {
        switch state.connectionStatus {
        case .disconnected, .error: return TrailColor.text.opacity(0.4)
        case .scanning, .connecting: return TrailColor.desertSand
        case .connected: return TrailColor.forestGreen
        }
    }

    private func adjustSpeed(_ delta: Double) {
        let newKmh = max(settings.minimumControlSpeed,
                         min(settings.maximumControlSpeed, state.targetSpeed + delta))
        state.targetSpeed = newKmh
        bleManager.setSpeed(newKmh)
    }
}
