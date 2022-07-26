import Foundation

extension UnitAngularVelocity: AAUnitType {
    public enum AngularVelocityUnit: String, Codable {
        case revolutionsPerMinute
        case degreesPerSecond
        case radiansPerSecond
    }

    public static let measurementID: UInt8 = 0x03

    public static func create(id: UInt8) -> Self? {
        switch id {
        case 0x00:  return UnitAngularVelocity.revolutionsPerMinute as? Self
        case 0x01:  return UnitAngularVelocity.degreesPerSecond as? Self
        case 0x02:  return UnitAngularVelocity.radiansPerSecond as? Self
        default:    return nil
        }
    }

    public static func create(unit: AngularVelocityUnit) -> UnitAngularVelocity {
        switch unit {
        case .revolutionsPerMinute: return Self.revolutionsPerMinute
        case .degreesPerSecond: return Self.degreesPerSecond
        case .radiansPerSecond: return Self.radiansPerSecond
        }
    }

    public var identifiers: [UInt8]? {
        switch self {
        case .revolutionsPerMinute: return [Self.measurementID, 0x00]
        case .degreesPerSecond: return [Self.measurementID, 0x01]
        case .radiansPerSecond: return [Self.measurementID, 0x02]
        default: return nil
        }
    }

    public var unit: AngularVelocityUnit? {
        switch self {
        case .revolutionsPerMinute: return .revolutionsPerMinute
        case .degreesPerSecond: return .degreesPerSecond
        case .radiansPerSecond: return .radiansPerSecond
        default: return nil
        }
    }
}
