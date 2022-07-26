import Foundation

public protocol AAUnitType: Dimension, Codable {
    static var measurementID: UInt8 { get }
    static func create(id: UInt8) -> Self?

    var identifiers: [UInt8]? { get }
}

enum AAUnitTypeCodingKeys: String, CodingKey {
    case identifier
}

public extension AAUnitType {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AAUnitTypeCodingKeys.self)
        let id = try container.decode(UInt8.self, forKey: .identifier)

        guard let me = Self.create(id: id) else {
            throw DecodingError.dataCorruptedError(forKey: AAUnitTypeCodingKeys.identifier,
                                                   in: container,
                                                   debugDescription: "Failed to create the Unit from an id: \(id)")
        }

        self.init(symbol: me.symbol, converter: me.converter)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AAUnitTypeCodingKeys.self)

        try container.encodeIfPresent(self.identifiers?.last, forKey: .identifier)
    }
}
