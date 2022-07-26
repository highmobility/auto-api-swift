import Foundation

extension UnitVolume: AAUnitType {
    public enum VolumeUnit: String, Codable {
        case liters
        case milliliters
        case centiliters
        case deciliters
        case cubicMillimeters
        case cubicCentimeters
        case cubicDecimeters
        case cubicMeters
        case cubicInches
        case cubicFeet
        case fluidOunces
        case gallons
        case imperialFluidOunces
        case imperialGallons
    }

    public static let measurementID: UInt8 = 0x19

    public static func create(id: UInt8) -> Self? {
        switch id {
        case 0x02:  return UnitVolume.liters as? Self
        case 0x03:  return UnitVolume.milliliters as? Self
        case 0x04:  return UnitVolume.centiliters as? Self
        case 0x05:  return UnitVolume.deciliters as? Self
        case 0x0a:  return UnitVolume.cubicMillimeters as? Self
        case 0x09:  return UnitVolume.cubicCentimeters as? Self
        case 0x08:  return UnitVolume.cubicDecimeters as? Self
        case 0x07:  return UnitVolume.cubicMeters as? Self
        case 0x0b:  return UnitVolume.cubicInches as? Self
        case 0x0c:  return UnitVolume.cubicFeet as? Self
        case 0x13:  return UnitVolume.fluidOunces as? Self
        case 0x17:  return UnitVolume.gallons as? Self
        case 0x1a:  return UnitVolume.imperialFluidOunces as? Self
        case 0x1d:  return UnitVolume.imperialGallons as? Self
        default:    return nil
        }
    }

    public static func create(unit: VolumeUnit) -> UnitVolume {
        switch unit {
        case .liters: return Self.liters
        case .milliliters: return Self.milliliters
        case .centiliters: return Self.centiliters
        case .deciliters: return Self.deciliters
        case .cubicMillimeters: return Self.cubicMillimeters
        case .cubicCentimeters: return Self.cubicCentimeters
        case .cubicDecimeters: return Self.cubicDecimeters
        case .cubicMeters: return Self.cubicMeters
        case .cubicInches: return Self.cubicInches
        case .cubicFeet: return Self.cubicFeet
        case .fluidOunces: return Self.fluidOunces
        case .gallons: return Self.gallons
        case .imperialFluidOunces: return Self.imperialFluidOunces
        case .imperialGallons: return Self.imperialGallons
        }
    }

    public var identifiers: [UInt8]? {
        switch self {
        case .liters: return [Self.measurementID, 0x02]
        case .milliliters: return [Self.measurementID, 0x03]
        case .centiliters: return [Self.measurementID, 0x04]
        case .deciliters: return [Self.measurementID, 0x05]
        case .cubicMillimeters: return [Self.measurementID, 0x0a]
        case .cubicCentimeters: return [Self.measurementID, 0x09]
        case .cubicDecimeters: return [Self.measurementID, 0x08]
        case .cubicMeters: return [Self.measurementID, 0x07]
        case .cubicInches: return [Self.measurementID, 0x0b]
        case .cubicFeet: return [Self.measurementID, 0x0c]
        case .fluidOunces: return [Self.measurementID, 0x13]
        case .gallons: return [Self.measurementID, 0x17]
        case .imperialFluidOunces: return [Self.measurementID, 0x1a]
        case .imperialGallons: return [Self.measurementID, 0x1d]
        default: return nil
        }
    }

    public var unit: VolumeUnit? {
        switch self {
        case .liters: return .liters
        case .milliliters: return .milliliters
        case .centiliters: return .centiliters
        case .deciliters: return .deciliters
        case .cubicMillimeters: return .cubicMillimeters
        case .cubicCentimeters: return .cubicCentimeters
        case .cubicDecimeters: return .cubicDecimeters
        case .cubicMeters: return .cubicMeters
        case .cubicInches: return .cubicInches
        case .cubicFeet: return .cubicFeet
        case .fluidOunces: return .fluidOunces
        case .gallons: return .gallons
        case .imperialFluidOunces: return .imperialFluidOunces
        case .imperialGallons: return .imperialGallons
        default: return nil
        }
    }
}
