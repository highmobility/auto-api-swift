import Foundation

extension UnitAngle: AAUnitType {
    public enum AngleUnit: String, Codable {
        case degrees
        case radians
        case revolutions
    }

    public static let measurementID: UInt8 = 0x02

    public static func create(id: UInt8) -> Self? {
        switch id {
        case 0x00:  return UnitAngle.degrees as? Self
        case 0x03:  return UnitAngle.radians as? Self
        case 0x05:  return UnitAngle.revolutions as? Self
        default:    return nil
        }
    }

    public static func create(unit: AngleUnit) -> UnitAngle {
        switch unit {
        case .degrees: return Self.degrees
        case .radians: return Self.radians
        case .revolutions: return Self.revolutions
        }
    }

    public var identifiers: [UInt8]? {
        switch self {
        case .degrees: return [Self.measurementID, 0x00]
        case .radians: return [Self.measurementID, 0x03]
        case .revolutions: return [Self.measurementID, 0x05]
        default: return nil
        }
    }

    public var unit: AngleUnit? {
        switch self {
        case .degrees: return .degrees
        case .radians: return .radians
        case .revolutions: return .revolutions
        default: return nil
        }
    }
}
