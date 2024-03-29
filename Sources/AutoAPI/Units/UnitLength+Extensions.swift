import Foundation

extension UnitLength: AAUnitType {
    public enum LengthUnit: String, Codable {
        case meters
        case millimeters
        case centimeters
        case decimeters
        case kilometers
        case megameters
        case inches
        case feet
        case yards
        case miles
        case scandinavianMiles
        case nauticalMiles
    }

    public static let measurementID: UInt8 = 0x12

    public static func create(id: UInt8) -> Self? {
        switch id {
        case 0x00:  return UnitLength.meters as? Self
        case 0x01:  return UnitLength.millimeters as? Self
        case 0x02:  return UnitLength.centimeters as? Self
        case 0x03:  return UnitLength.decimeters as? Self
        case 0x04:  return UnitLength.kilometers as? Self
        case 0x05:  return UnitLength.megameters as? Self
        case 0x0b:  return UnitLength.inches as? Self
        case 0x0c:  return UnitLength.feet as? Self
        case 0x0d:  return UnitLength.yards as? Self
        case 0x0e:  return UnitLength.miles as? Self
        case 0x0f:  return UnitLength.scandinavianMiles as? Self
        case 0x11:  return UnitLength.nauticalMiles as? Self
        default:    return nil
        }
    }

    public static func create(unit: LengthUnit) -> UnitLength {
        switch unit {
        case .meters: return Self.meters
        case .millimeters: return Self.millimeters
        case .centimeters: return Self.centimeters
        case .decimeters: return Self.decimeters
        case .kilometers: return Self.kilometers
        case .megameters: return Self.megameters
        case .inches: return Self.inches
        case .feet: return Self.feet
        case .yards: return Self.yards
        case .miles: return Self.miles
        case .scandinavianMiles: return Self.scandinavianMiles
        case .nauticalMiles: return Self.nauticalMiles
        }
    }

    public var identifiers: [UInt8]? {
        switch self {
        case .meters: return [Self.measurementID, 0x00]
        case .millimeters: return [Self.measurementID, 0x01]
        case .centimeters: return [Self.measurementID, 0x02]
        case .decimeters: return [Self.measurementID, 0x03]
        case .kilometers: return [Self.measurementID, 0x04]
        case .megameters: return [Self.measurementID, 0x05]
        case .inches: return [Self.measurementID, 0x0b]
        case .feet: return [Self.measurementID, 0x0c]
        case .yards: return [Self.measurementID, 0x0d]
        case .miles: return [Self.measurementID, 0x0e]
        case .scandinavianMiles: return [Self.measurementID, 0x0f]
        case .nauticalMiles: return [Self.measurementID, 0x11]
        default: return nil
        }
    }

    public var unit: LengthUnit? {
        switch self {
        case .meters: return .meters
        case .millimeters: return .millimeters
        case .centimeters: return .centimeters
        case .decimeters: return .decimeters
        case .kilometers: return .kilometers
        case .megameters: return .megameters
        case .inches: return .inches
        case .feet: return .feet
        case .yards: return .yards
        case .miles: return .miles
        case .scandinavianMiles: return .scandinavianMiles
        case .nauticalMiles: return .nauticalMiles
        default: return nil
        }
    }
}
