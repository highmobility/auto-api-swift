import Foundation

extension UnitFuelEfficiency: AAUnitType {
    public enum FuelEfficiencyUnit: String, Codable {
        case litersPer100Kilometers
        case milesPerImperialGallon
        case milesPerGallon
    }

    public static let measurementID: UInt8 = 0x0f

    public static func create(id: UInt8) -> Self? {
        switch id {
        case 0x00:  return UnitFuelEfficiency.litersPer100Kilometers as? Self
        case 0x01:  return UnitFuelEfficiency.milesPerImperialGallon as? Self
        case 0x02:  return UnitFuelEfficiency.milesPerGallon as? Self
        default:    return nil
        }
    }

    public static func create(unit: FuelEfficiencyUnit) -> UnitFuelEfficiency {
        switch unit {
        case .litersPer100Kilometers: return Self.litersPer100Kilometers
        case .milesPerImperialGallon: return Self.milesPerImperialGallon
        case .milesPerGallon: return Self.milesPerGallon
        }
    }

    public var identifiers: [UInt8]? {
        switch self {
        case .litersPer100Kilometers: return [Self.measurementID, 0x00]
        case .milesPerImperialGallon: return [Self.measurementID, 0x01]
        case .milesPerGallon: return [Self.measurementID, 0x02]
        default: return nil
        }
    }

    public var unit: FuelEfficiencyUnit? {
        switch self {
        case .litersPer100Kilometers: return .litersPer100Kilometers
        case .milesPerImperialGallon: return .milesPerImperialGallon
        case .milesPerGallon: return .milesPerGallon
        default: return nil
        }
    }
}
