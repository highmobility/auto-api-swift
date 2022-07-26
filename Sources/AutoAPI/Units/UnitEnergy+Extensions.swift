import Foundation

public extension UnitEnergy {
    static let wattHours = UnitEnergy(symbol: "hm_wh", converter: UnitConverterLinear(coefficient: 3600.0))
    static let ampereHours = UnitEnergy(symbol: "hm_ah", converter: UnitConverterLinear(coefficient: 3.6))
}

extension UnitEnergy: AAUnitType {
    public enum EnergyUnit: String, Codable {
        case joules
        case kilojoules
        case wattHours
        case kilowattHours
        case ampereHours
    }

    public static let measurementID: UInt8 = 0x0c

    public static func create(id: UInt8) -> Self? {
        switch id {
        case 0x00:  return UnitEnergy.joules as? Self
        case 0x01:  return UnitEnergy.kilojoules as? Self
        case 0x03:  return UnitEnergy.wattHours as? Self
        case 0x04:  return UnitEnergy.kilowattHours as? Self
        case 0x05:  return UnitEnergy.ampereHours as? Self
        default:    return nil
        }
    }

    public static func create(unit: EnergyUnit) -> UnitEnergy {
        switch unit {
        case .joules: return Self.joules
        case .kilojoules: return Self.kilojoules
        case .wattHours: return Self.wattHours
        case .kilowattHours: return Self.kilowattHours
        case .ampereHours: return Self.ampereHours
        }
    }

    public var identifiers: [UInt8]? {
        switch self {
        case .joules: return [Self.measurementID, 0x00]
        case .kilojoules: return [Self.measurementID, 0x01]
        case .wattHours: return [Self.measurementID, 0x03]
        case .kilowattHours: return [Self.measurementID, 0x04]
        case .ampereHours: return [Self.measurementID, 0x05]
        default: return nil
        }
    }

    public var unit: EnergyUnit? {
        switch self {
        case .joules: return .joules
        case .kilojoules: return .kilojoules
        case .wattHours: return .wattHours
        case .kilowattHours: return .kilowattHours
        case .ampereHours: return .ampereHours
        default: return nil
        }
    }
}
