import AVFoundation
import Foundation
import Observation

@Observable
class SoundManager {
    private var audioEngine: AVAudioEngine?
    private var playerNode: AVAudioPlayerNode?
    private let sampleRate: Double = 44100.0

    static let shared = SoundManager()

    private init() {
        setupEngine()
    }

    // MARK: - Engine Setup

    private func setupEngine() {
        let engine = AVAudioEngine()
        let player = AVAudioPlayerNode()
        engine.attach(player)

        let format = AVAudioFormat(standardFormatWithSampleRate: sampleRate, channels: 1)!
        engine.connect(player, to: engine.mainMixerNode, format: format)

        // Lower volume so it's a subtle chime
        engine.mainMixerNode.outputVolume = 0.3

        do {
            try engine.start()
            self.audioEngine = engine
            self.playerNode = player
        } catch {
            print("SoundManager: Failed to start audio engine: \(error)")
        }
    }

    // MARK: - Public Sound Effects

    /// Ascending 8-bit arpeggio (C-E-G-C) — play when daily goal is hit
    func playGoalAchieved() {
        let notes: [(frequency: Double, duration: Double)] = [
            (523.25, 0.12),  // C5
            (659.25, 0.12),  // E5
            (783.99, 0.12),  // G5
            (1046.50, 0.20), // C6
        ]
        playSquareWaveSequence(notes)
    }

    /// Longer triumphant 8-bit fanfare — play for journey milestones
    func playMilestoneReached() {
        let notes: [(frequency: Double, duration: Double)] = [
            (392.00, 0.10),  // G4
            (523.25, 0.10),  // C5
            (659.25, 0.10),  // E5
            (783.99, 0.15),  // G5
            (0, 0.05),       // tiny rest
            (783.99, 0.10),  // G5
            (1046.50, 0.25), // C6
        ]
        playSquareWaveSequence(notes)
    }

    /// Simple "boop" — play when workout recording starts
    func playWorkoutStarted() {
        let notes: [(frequency: Double, duration: Double)] = [
            (440.0, 0.08),   // A4
            (554.37, 0.10),  // C#5
        ]
        playSquareWaveSequence(notes)
    }

    /// Descending tone — play when workout recording ends
    func playWorkoutEnded() {
        let notes: [(frequency: Double, duration: Double)] = [
            (554.37, 0.10),  // C#5
            (440.0, 0.12),   // A4
            (349.23, 0.14),  // F4
        ]
        playSquareWaveSequence(notes)
    }

    // MARK: - Synthesis

    private func playSquareWaveSequence(_ notes: [(frequency: Double, duration: Double)]) {
        guard let player = playerNode, let engine = audioEngine, engine.isRunning else { return }

        let format = AVAudioFormat(standardFormatWithSampleRate: sampleRate, channels: 1)!

        // Calculate total sample count
        let totalDuration = notes.reduce(0.0) { $0 + $1.duration }
        let totalSamples = AVAudioFrameCount(totalDuration * sampleRate)

        guard let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: totalSamples) else { return }
        buffer.frameLength = totalSamples

        guard let channelData = buffer.floatChannelData?[0] else { return }

        var sampleIndex: Int = 0

        for note in notes {
            let noteSamples = Int(note.duration * sampleRate)
            let frequency = note.frequency

            for i in 0..<noteSamples {
                guard sampleIndex < Int(totalSamples) else { break }

                if frequency <= 0 {
                    // Rest
                    channelData[sampleIndex] = 0
                } else {
                    // Square wave
                    let phase = Double(i) * frequency / sampleRate
                    let squareValue: Float = (phase.truncatingRemainder(dividingBy: 1.0)) < 0.5 ? 0.4 : -0.4

                    // Apply envelope to avoid clicks
                    let attackSamples = min(noteSamples / 10, 200)
                    let releaseSamples = min(noteSamples / 5, 400)
                    var envelope: Float = 1.0

                    if i < attackSamples {
                        envelope = Float(i) / Float(attackSamples)
                    } else if i > noteSamples - releaseSamples {
                        envelope = Float(noteSamples - i) / Float(releaseSamples)
                    }

                    channelData[sampleIndex] = squareValue * envelope
                }
                sampleIndex += 1
            }
        }

        player.stop()
        player.scheduleBuffer(buffer, completionHandler: nil)
        player.play()
    }
}
