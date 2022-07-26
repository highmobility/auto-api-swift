import Foundation

extension UnitElectricCurrent: AAUnitType {
    public enum ElectricCurrentUnit: String, Codable {
        case amperes
        case milliamperes
        case kiloamperes
    }

    public static let measurementID: UInt8 = 0x09

    public static func create(id: UInt8) -> Self? {
        switch id {
        case 0x00:  return UnitElectricCurrent.amperes as? Self
        case 0x01:  return UnitElectricCurrent.milliamperes as? Self
        case 0x02:  return UnitElectricCurrent.kiloamperes as? Self
        default:    return nil
        }
    }

    public static func create(unit: ElectricCurrentUnit) -> UnitElectricCurrent {
        switch unit {
        case .amperes: return Self.amperes
        case .milliamperes: return Self.milliamperes
        case .kiloamperes: return Self.kiloamperes
        }
    }

    public var identifiers: [UInt8]? {
        switch self {
        case .amperes: return [Self.measurementID, 0x00]
        case .milliamperes: return [Self.measurementID, 0x01]
        case .kiloamperes: return [Self.measurementID, 0x02]
        default: return nil
        }
    }

    public var unit: ElectricCurrentUnit? {
        switch self {
        case .amperes: return .amperes
        case .milliamperes: return .milliamperes
        case .kiloamperes: return .kiloamperes
        default: return nil
        }
    }
}
