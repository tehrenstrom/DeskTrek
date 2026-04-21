import AppKit
import CoreGraphics
import Foundation
import SwiftUI

enum CertificateRenderer {
    /// Render a certificate to a US Letter landscape PDF (792×612 pt @ 72dpi)
    /// in the app's certificates directory. Returns the file URL on success.
    @MainActor
    static func render(
        certificate: Certificate,
        trail: Trail,
        settings: AppSettings,
        dataManager: DataManager
    ) -> URL? {
        let view = CertificateView(certificate: certificate, trail: trail, settings: settings)
            .frame(width: 792, height: 612)

        let renderer = ImageRenderer(content: view)
        renderer.proposedSize = .init(width: 792, height: 612)

        let fileName = "\(certificate.id).pdf"
        let url = dataManager.certificatesDir.appendingPathComponent(fileName)

        var result: URL?
        renderer.render { size, drawInto in
            var mediaBox = CGRect(origin: .zero, size: size)
            guard let ctx = CGContext(url as CFURL, mediaBox: &mediaBox, nil) else { return }
            ctx.beginPDFPage(nil)
            drawInto(ctx)
            ctx.endPDFPage()
            ctx.closePDF()
            result = url
        }
        return result
    }
}
