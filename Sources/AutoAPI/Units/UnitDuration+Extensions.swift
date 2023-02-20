import Foundation

public extension UnitDuration {
    static let days = UnitDuration(symbol: "hm_d", converter: UnitConverterLinear(coefficient: 86400.0))
    static let weeks = UnitDuration(symbol: "hm_w", converter: UnitConverterLinear(coefficient: 604800.0))
    static let months = UnitDuration(symbol: "hm_m", converter: UnitConverterLinear(coefficient: 2629800.0))
}

extension UnitDuration: AAUnitType {
    public enum DurationUnit: String, Codable {
        case seconds
        case minutes
        case hours
        case days
        case weeks
        case months
        case milliseconds
    }

    public static let measurementID: UInt8 = 0x07

    public static func create(id: UInt8) -> Self? {
        switch id {
        case 0x00:  return UnitDuration.seconds as? Self
        case 0x01:  return UnitDuration.minutes as? Self
        case 0x02:  return UnitDuration.hours as? Self
        case 0x03:  return UnitDuration.days as? Self
        case 0x04:  return UnitDuration.weeks as? Self
        case 0x05:  return UnitDuration.months as? Self
        case 0x06:  return UnitDuration.milliseconds as? Self
        default:    return nil
        }
    }

    public static func create(unit: DurationUnit) -> UnitDuration {
        switch unit {
        case .seconds: return Self.seconds
        case .minutes: return Self.minutes
        case .hours: return Self.hours
        case .days: return Self.days
        case .weeks: return Self.weeks
        case .months: return Self.months
        case .milliseconds: return Self.milliseconds
        }
    }

    public var identifiers: [UInt8]? {
        switch self {
        case .seconds: return [Self.measurementID, 0x00]
        case .minutes: return [Self.measurementID, 0x01]
        case .hours: return [Self.measurementID, 0x02]
        case .days: return [Self.measurementID, 0x03]
        case .weeks: return [Self.measurementID, 0x04]
        case .months: return [Self.measurementID, 0x05]
        case .milliseconds: return [Self.measurementID, 0x06]
        default: return nil
        }
    }

    public var unit: DurationUnit? {
        switch self {
        case .seconds: return .seconds
        case .minutes: return .minutes
        case .hours: return .hours
        case .days: return .days
        case .weeks: return .weeks
        case .months: return .months
        case .milliseconds: return .milliseconds
        default: return nil
        }
    }
}
