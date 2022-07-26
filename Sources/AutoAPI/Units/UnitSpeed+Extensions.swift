import Foundation

extension UnitSpeed: AAUnitType {
    public enum SpeedUnit: String, Codable {
        case metersPerSecond
        case kilometersPerHour
        case milesPerHour
        case knots
    }

    public static let measurementID: UInt8 = 0x16

    public static func create(id: UInt8) -> Self? {
        switch id {
        case 0x00:  return UnitSpeed.metersPerSecond as? Self
        case 0x01:  return UnitSpeed.kilometersPerHour as? Self
        case 0x02:  return UnitSpeed.milesPerHour as? Self
        case 0x03:  return UnitSpeed.knots as? Self
        default:    return nil
        }
    }

    public static func create(unit: SpeedUnit) -> UnitSpeed {
        switch unit {
        case .metersPerSecond: return Self.metersPerSecond
        case .kilometersPerHour: return Self.kilometersPerHour
        case .milesPerHour: return Self.milesPerHour
        case .knots: return Self.knots
        }
    }

    public var identifiers: [UInt8]? {
        switch self {
        case .metersPerSecond: return [Self.measurementID, 0x00]
        case .kilometersPerHour: return [Self.measurementID, 0x01]
        case .milesPerHour: return [Self.measurementID, 0x02]
        case .knots: return [Self.measurementID, 0x03]
        default: return nil
        }
    }

    public var unit: SpeedUnit? {
        switch self {
        case .metersPerSecond: return .metersPerSecond
        case .kilometersPerHour: return .kilometersPerHour
        case .milesPerHour: return .milesPerHour
        case .knots: return .knots
        default: return nil
        }
    }
}
