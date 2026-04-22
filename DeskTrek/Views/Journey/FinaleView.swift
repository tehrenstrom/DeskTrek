import SwiftUI

struct FinaleView: View {
    let certificate: Certificate
    let trail: Trail
    let appState: AppState
    let onDismiss: () -> Void

    @State private var pdfURL: URL?
    @State private var renderError: Bool = false

    var body: some View {
        ZStack {
            TrailColor.parchment.ignoresSafeArea()

            VStack(spacing: 22) {
                Text("═════════════════════")
                    .font(.system(size: 16, design: .monospaced))
                    .foregroundStyle(TrailColor.coral)

                Text("YOU MADE IT!")
                    .font(.system(size: 38, weight: .black, design: .monospaced))
                    .foregroundStyle(TrailColor.darkEarth)
                    .tracking(6)

                PixelImage(assetName: trail.finaleArt, size: 220)

                Text(trail.certificateCopy)
                    .font(.system(size: 14, design: .monospaced))
                    .foregroundStyle(TrailColor.text)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                if renderError {
                    Text("Certificate PDF could not be generated.")
                        .font(.system(size: 11, design: .monospaced))
                        .foregroundStyle(TrailColor.coral)
                }

                HStack(spacing: 12) {
                    if let pdfURL {
                        Button("Reveal PDF") {
                            NSWorkspace.shared.activateFileViewerSelecting([pdfURL])
                        }
                        .buttonStyle(RetroButtonStyle(tint: TrailColor.mountainBlue))
                    }
                    Button("Close") {
                        onDismiss()
                    }
                    .buttonStyle(RetroButtonStyle(tint: TrailColor.forestGreen))
                }
            }
            .padding(40)
        }
        .frame(minWidth: 640, minHeight: 560)
        .onAppear { renderPDFIfNeeded() }
    }

    private func renderPDFIfNeeded() {
        guard pdfURL == nil else { return }
        if let url = CertificateRenderer.render(
            certificate: certificate,
            trail: trail,
            settings: appState.settings,
            dataManager: appState.dataManager
        ) {
            pdfURL = url
            // Persist the filename on the certificate.
            var trophies = appState.journeyStore.trophies
            if let idx = trophies.firstIndex(where: { $0.id == certificate.id }) {
                trophies[idx].pdfFileName = url.lastPathComponent
                appState.dataManager.saveTrophies(trophies)
            }
        } else {
            renderError = true
        }
    }
}
