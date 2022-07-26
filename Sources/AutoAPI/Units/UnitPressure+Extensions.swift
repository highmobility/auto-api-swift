import Foundation

public extension UnitPressure {
    static let pascals = UnitPressure(symbol: "hm_p", converter: UnitConverterLinear(coefficient: 1.0))
}

extension UnitPressure: AAUnitType {
    public enum PressureUnit: String, Codable {
        case pascals
        case kilopascals
        case inchesOfMercury
        case bars
        case millibars
        case millimetersOfMercury
        case poundsForcePerSquareInch
    }

    public static let measurementID: UInt8 = 0x15

    public static func create(id: UInt8) -> Self? {
        switch id {
        case 0x00:  return UnitPressure.pascals as? Self
        case 0x03:  return UnitPressure.kilopascals as? Self
        case 0x05:  return UnitPressure.inchesOfMercury as? Self
        case 0x06:  return UnitPressure.bars as? Self
        case 0x07:  return UnitPressure.millibars as? Self
        case 0x08:  return UnitPressure.millimetersOfMercury as? Self
        case 0x09:  return UnitPressure.poundsForcePerSquareInch as? Self
        default:    return nil
        }
    }

    public static func create(unit: PressureUnit) -> UnitPressure {
        switch unit {
        case .pascals: return Self.pascals
        case .kilopascals: return Self.kilopascals
        case .inchesOfMercury: return Self.inchesOfMercury
        case .bars: return Self.bars
        case .millibars: return Self.millibars
        case .millimetersOfMercury: return Self.millimetersOfMercury
        case .poundsForcePerSquareInch: return Self.poundsForcePerSquareInch
        }
    }

    public var identifiers: [UInt8]? {
        switch self {
        case .pascals: return [Self.measurementID, 0x00]
        case .kilopascals: return [Self.measurementID, 0x03]
        case .inchesOfMercury: return [Self.measurementID, 0x05]
        case .bars: return [Self.measurementID, 0x06]
        case .millibars: return [Self.measurementID, 0x07]
        case .millimetersOfMercury: return [Self.measurementID, 0x08]
        case .poundsForcePerSquareInch: return [Self.measurementID, 0x09]
        default: return nil
        }
    }

    public var unit: PressureUnit? {
        switch self {
        case .pascals: return .pascals
        case .kilopascals: return .kilopascals
        case .inchesOfMercury: return .inchesOfMercury
        case .bars: return .bars
        case .millibars: return .millibars
        case .millimetersOfMercury: return .millimetersOfMercury
        case .poundsForcePerSquareInch: return .poundsForcePerSquareInch
        default: return nil
        }
    }
}
