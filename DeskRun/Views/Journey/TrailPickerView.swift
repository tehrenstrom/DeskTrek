import SwiftUI

struct TrailPickerView: View {
    let appState: AppState

    @State private var selectedTrail: Trail = TrailCatalog.all.first ?? .johnMuir
    @State private var targetDate: Date = Calendar.current.date(byAdding: .month, value: 4, to: Date()) ?? Date()
    @State private var useTargetDate: Bool = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                Text("CHOOSE YOUR TRAIL")
                    .font(.system(size: 20, weight: .black, design: .monospaced))
                    .foregroundStyle(TrailColor.darkEarth)
                    .tracking(3)

                Text("Each trail is a long, gamified hike. You'll pass landmarks, meet encounters, and earn a certificate when you complete the miles from your desk.")
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundStyle(TrailColor.text.opacity(0.7))
                    .fixedSize(horizontal: false, vertical: true)

                ForEach(TrailCatalog.all) { trail in
                    trailCard(trail)
                }

                targetDateSection

                Button {
                    appState.journeyEngine.start(
                        trail: selectedTrail,
                        targetDate: useTargetDate ? targetDate : nil
                    )
                } label: {
                    Text(">> EMBARK <<")
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .tracking(3)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                }
                .buttonStyle(RetroButtonStyle(tint: TrailColor.coral))
                .frame(maxWidth: .infinity)

                Spacer(minLength: 0)
            }
            .padding(24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(TrailColor.parchment)
        .navigationTitle("Trail")
    }

    private func trailCard(_ trail: Trail) -> some View {
        Button {
            selectedTrail = trail
        } label: {
            HStack(spacing: 16) {
                PixelImage(assetName: trail.finaleArt, size: 64)
                    .frame(width: 64, height: 64)

                VStack(alignment: .leading, spacing: 4) {
                    Text(trail.name.uppercased())
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                        .foregroundStyle(TrailColor.text)
                        .tracking(1)
                    Text(trail.subtitle)
                        .font(.system(size: 11, design: .monospaced))
                        .foregroundStyle(TrailColor.text.opacity(0.6))
                    Text(String(format: "%.0f miles  \u{00B7}  %d landmarks", trail.totalMiles, trail.landmarks.count))
                        .font(.system(size: 10, design: .monospaced))
                        .foregroundStyle(TrailColor.mountainBlue)
                }
                Spacer()
                Image(systemName: selectedTrail.id == trail.id ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 20))
                    .foregroundStyle(selectedTrail.id == trail.id ? TrailColor.forestGreen : TrailColor.darkEarth.opacity(0.3))
            }
            .padding(14)
            .background(TrailColor.parchment)
            .overlay(
                Rectangle()
                    .strokeBorder(
                        selectedTrail.id == trail.id ? TrailColor.coral : TrailColor.darkEarth.opacity(0.3),
                        lineWidth: selectedTrail.id == trail.id ? 2 : 1
                    )
            )
        }
        .buttonStyle(.plain)
    }

    private var targetDateSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Toggle(isOn: $useTargetDate) {
                Text("Set a target completion date")
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundStyle(TrailColor.text)
            }
            .toggleStyle(.switch)

            if useTargetDate {
                DatePicker(
                    "Finish by",
                    selection: $targetDate,
                    in: Date()...,
                    displayedComponents: .date
                )
                .font(.system(size: 12, design: .monospaced))
            }
        }
        .retroPanel()
    }
}
