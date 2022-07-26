import Foundation

extension UnitTemperature: AAUnitType {
    public enum TemperatureUnit: String, Codable {
        case kelvin
        case celsius
        case fahrenheit
    }

    public static let measurementID: UInt8 = 0x17

    public static func create(id: UInt8) -> Self? {
        switch id {
        case 0x00:  return UnitTemperature.kelvin as? Self
        case 0x01:  return UnitTemperature.celsius as? Self
        case 0x02:  return UnitTemperature.fahrenheit as? Self
        default:    return nil
        }
    }

    public static func create(unit: TemperatureUnit) -> UnitTemperature {
        switch unit {
        case .kelvin: return Self.kelvin
        case .celsius: return Self.celsius
        case .fahrenheit: return Self.fahrenheit
        }
    }

    public var identifiers: [UInt8]? {
        switch self {
        case .kelvin: return [Self.measurementID, 0x00]
        case .celsius: return [Self.measurementID, 0x01]
        case .fahrenheit: return [Self.measurementID, 0x02]
        default: return nil
        }
    }

    public var unit: TemperatureUnit? {
        switch self {
        case .kelvin: return .kelvin
        case .celsius: return .celsius
        case .fahrenheit: return .fahrenheit
        default: return nil
        }
    }
}
