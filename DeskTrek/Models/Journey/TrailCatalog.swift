import Foundation

enum TrailCatalog {
    static let all: [Trail] = [
        .johnMuir,
        .wonderland,
        .superiorHiking
    ]

    static func trail(for id: String) -> Trail? {
        all.first(where: { $0.id == id })
    }
}
