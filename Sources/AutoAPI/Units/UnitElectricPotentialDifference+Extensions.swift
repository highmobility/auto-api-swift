import Foundation

extension UnitElectricPotentialDifference: AAUnitType {
    public enum ElectricPotentialDifferenceUnit: String, Codable {
        case volts
        case millivolts
        case kilovolts
    }

    public static let measurementID: UInt8 = 0x0a

    public static func create(id: UInt8) -> Self? {
        switch id {
        case 0x00:  return UnitElectricPotentialDifference.volts as? Self
        case 0x01:  return UnitElectricPotentialDifference.millivolts as? Self
        case 0x02:  return UnitElectricPotentialDifference.kilovolts as? Self
        default:    return nil
        }
    }

    public static func create(unit: ElectricPotentialDifferenceUnit) -> UnitElectricPotentialDifference {
        switch unit {
        case .volts: return Self.volts
        case .millivolts: return Self.millivolts
        case .kilovolts: return Self.kilovolts
        }
    }

    public var identifiers: [UInt8]? {
        switch self {
        case .volts: return [Self.measurementID, 0x00]
        case .millivolts: return [Self.measurementID, 0x01]
        case .kilovolts: return [Self.measurementID, 0x02]
        default: return nil
        }
    }

    public var unit: ElectricPotentialDifferenceUnit? {
        switch self {
        case .volts: return .volts
        case .millivolts: return .millivolts
        case .kilovolts: return .kilovolts
        default: return nil
        }
    }
}
