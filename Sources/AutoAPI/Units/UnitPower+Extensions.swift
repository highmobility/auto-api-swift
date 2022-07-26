import Foundation

extension UnitPower: AAUnitType {
    public enum PowerUnit: String, Codable {
        case watts
        case milliwatts
        case kilowatts
        case megawatts
        case horsepower
    }

    public static let measurementID: UInt8 = 0x14

    public static func create(id: UInt8) -> Self? {
        switch id {
        case 0x00:  return UnitPower.watts as? Self
        case 0x01:  return UnitPower.milliwatts as? Self
        case 0x02:  return UnitPower.kilowatts as? Self
        case 0x03:  return UnitPower.megawatts as? Self
        case 0x0a:  return UnitPower.horsepower as? Self
        default:    return nil
        }
    }

    public static func create(unit: PowerUnit) -> UnitPower {
        switch unit {
        case .watts: return Self.watts
        case .milliwatts: return Self.milliwatts
        case .kilowatts: return Self.kilowatts
        case .megawatts: return Self.megawatts
        case .horsepower: return Self.horsepower
        }
    }

    public var identifiers: [UInt8]? {
        switch self {
        case .watts: return [Self.measurementID, 0x00]
        case .milliwatts: return [Self.measurementID, 0x01]
        case .kilowatts: return [Self.measurementID, 0x02]
        case .megawatts: return [Self.measurementID, 0x03]
        case .horsepower: return [Self.measurementID, 0x0a]
        default: return nil
        }
    }

    public var unit: PowerUnit? {
        switch self {
        case .watts: return .watts
        case .milliwatts: return .milliwatts
        case .kilowatts: return .kilowatts
        case .megawatts: return .megawatts
        case .horsepower: return .horsepower
        default: return nil
        }
    }
}
