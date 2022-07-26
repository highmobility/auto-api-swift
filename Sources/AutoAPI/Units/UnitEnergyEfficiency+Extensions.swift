import Foundation

extension UnitEnergyEfficiency: AAUnitType {
    public enum EnergyEfficiencyUnit: String, Codable {
        case kwhPer100Kilometers
        case milesPerKwh
    }

    public static let measurementID: UInt8 = 0x0d

    public static func create(id: UInt8) -> Self? {
        switch id {
        case 0x00:  return UnitEnergyEfficiency.kwhPer100Kilometers as? Self
        case 0x01:  return UnitEnergyEfficiency.milesPerKwh as? Self
        default:    return nil
        }
    }

    public static func create(unit: EnergyEfficiencyUnit) -> UnitEnergyEfficiency {
        switch unit {
        case .kwhPer100Kilometers: return Self.kwhPer100Kilometers
        case .milesPerKwh: return Self.milesPerKwh
        }
    }

    public var identifiers: [UInt8]? {
        switch self {
        case .kwhPer100Kilometers: return [Self.measurementID, 0x00]
        case .milesPerKwh: return [Self.measurementID, 0x01]
        default: return nil
        }
    }

    public var unit: EnergyEfficiencyUnit? {
        switch self {
        case .kwhPer100Kilometers: return .kwhPer100Kilometers
        case .milesPerKwh: return .milesPerKwh
        default: return nil
        }
    }
}
