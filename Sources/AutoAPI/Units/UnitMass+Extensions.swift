import Foundation

public extension UnitMass {
    static let pounds = UnitMass(symbol: "hm_p", converter: UnitConverterLinear(coefficient: 0.453592))
}

extension UnitMass: AAUnitType {
    public enum MassUnit: String, Codable {
        case kilograms
        case grams
        case decigrams
        case centigrams
        case milligrams
        case micrograms
        case nanograms
        case picograms
        case ounces
        case pounds
        case stones
        case metricTons
        case shortTons
        case carats
        case ouncesTroy
        case slugs
    }

    public static let measurementID: UInt8 = 0x13

    public static func create(id: UInt8) -> Self? {
        switch id {
        case 0x00:  return UnitMass.kilograms as? Self
        case 0x01:  return UnitMass.grams as? Self
        case 0x02:  return UnitMass.decigrams as? Self
        case 0x03:  return UnitMass.centigrams as? Self
        case 0x04:  return UnitMass.milligrams as? Self
        case 0x05:  return UnitMass.micrograms as? Self
        case 0x06:  return UnitMass.nanograms as? Self
        case 0x07:  return UnitMass.picograms as? Self
        case 0x08:  return UnitMass.ounces as? Self
        case 0x09:  return UnitMass.pounds as? Self
        case 0x0a:  return UnitMass.stones as? Self
        case 0x0b:  return UnitMass.metricTons as? Self
        case 0x0c:  return UnitMass.shortTons as? Self
        case 0x0d:  return UnitMass.carats as? Self
        case 0x0e:  return UnitMass.ouncesTroy as? Self
        case 0x0f:  return UnitMass.slugs as? Self
        default:    return nil
        }
    }

    public static func create(unit: MassUnit) -> UnitMass {
        switch unit {
        case .kilograms: return Self.kilograms
        case .grams: return Self.grams
        case .decigrams: return Self.decigrams
        case .centigrams: return Self.centigrams
        case .milligrams: return Self.milligrams
        case .micrograms: return Self.micrograms
        case .nanograms: return Self.nanograms
        case .picograms: return Self.picograms
        case .ounces: return Self.ounces
        case .pounds: return Self.pounds
        case .stones: return Self.stones
        case .metricTons: return Self.metricTons
        case .shortTons: return Self.shortTons
        case .carats: return Self.carats
        case .ouncesTroy: return Self.ouncesTroy
        case .slugs: return Self.slugs
        }
    }

    public var identifiers: [UInt8]? {
        switch self {
        case .kilograms: return [Self.measurementID, 0x00]
        case .grams: return [Self.measurementID, 0x01]
        case .decigrams: return [Self.measurementID, 0x02]
        case .centigrams: return [Self.measurementID, 0x03]
        case .milligrams: return [Self.measurementID, 0x04]
        case .micrograms: return [Self.measurementID, 0x05]
        case .nanograms: return [Self.measurementID, 0x06]
        case .picograms: return [Self.measurementID, 0x07]
        case .ounces: return [Self.measurementID, 0x08]
        case .pounds: return [Self.measurementID, 0x09]
        case .stones: return [Self.measurementID, 0x0a]
        case .metricTons: return [Self.measurementID, 0x0b]
        case .shortTons: return [Self.measurementID, 0x0c]
        case .carats: return [Self.measurementID, 0x0d]
        case .ouncesTroy: return [Self.measurementID, 0x0e]
        case .slugs: return [Self.measurementID, 0x0f]
        default: return nil
        }
    }

    public var unit: MassUnit? {
        switch self {
        case .kilograms: return .kilograms
        case .grams: return .grams
        case .decigrams: return .decigrams
        case .centigrams: return .centigrams
        case .milligrams: return .milligrams
        case .micrograms: return .micrograms
        case .nanograms: return .nanograms
        case .picograms: return .picograms
        case .ounces: return .ounces
        case .pounds: return .pounds
        case .stones: return .stones
        case .metricTons: return .metricTons
        case .shortTons: return .shortTons
        case .carats: return .carats
        case .ouncesTroy: return .ouncesTroy
        case .slugs: return .slugs
        default: return nil
        }
    }
}
