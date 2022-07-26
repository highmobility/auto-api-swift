import Foundation

extension UnitIlluminance: AAUnitType {
    public enum IlluminanceUnit: String, Codable {
        case lux
    }

    public static let measurementID: UInt8 = 0x11

    public static func create(id: UInt8) -> Self? {
        switch id {
        case 0x00:  return UnitIlluminance.lux as? Self
        default:    return nil
        }
    }

    public static func create(unit: IlluminanceUnit) -> UnitIlluminance {
        switch unit {
        case .lux: return Self.lux
        }
    }

    public var identifiers: [UInt8]? {
        switch self {
        case .lux: return [Self.measurementID, 0x00]
        default: return nil
        }
    }

    public var unit: IlluminanceUnit? {
        switch self {
        case .lux: return .lux
        default: return nil
        }
    }
}
