import Foundation

extension UnitAcceleration: AAUnitType {
    public enum AccelerationUnit: String, Codable {
        case metersPerSecondSquared
        case gravity
    }

    public static let measurementID: UInt8 = 0x01

    public static func create(id: UInt8) -> Self? {
        switch id {
        case 0x00:  return UnitAcceleration.metersPerSecondSquared as? Self
        case 0x01:  return UnitAcceleration.gravity as? Self
        default:    return nil
        }
    }

    public static func create(unit: AccelerationUnit) -> UnitAcceleration {
        switch unit {
        case .metersPerSecondSquared: return Self.metersPerSecondSquared
        case .gravity: return Self.gravity
        }
    }

    public var identifiers: [UInt8]? {
        switch self {
        case .metersPerSecondSquared: return [Self.measurementID, 0x00]
        case .gravity: return [Self.measurementID, 0x01]
        default: return nil
        }
    }

    public var unit: AccelerationUnit? {
        switch self {
        case .metersPerSecondSquared: return .metersPerSecondSquared
        case .gravity: return .gravity
        default: return nil
        }
    }
}
