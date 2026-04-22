import Foundation

enum TrailCatalog {
    static let all: [Trail] = [
        .johnMuir
    ]

    static func trail(for id: String) -> Trail? {
        all.first(where: { $0.id == id })
    }
}
