import Foundation

extension UnitTorque: AAUnitType {
    public enum TorqueUnit: String, Codable {
        case newtonMeters
        case newtonMillimeters
        case poundFeet
    }

    public static let measurementID: UInt8 = 0x18

    public static func create(id: UInt8) -> Self? {
        switch id {
        case 0x00:  return UnitTorque.newtonMeters as? Self
        case 0x01:  return UnitTorque.newtonMillimeters as? Self
        case 0x02:  return UnitTorque.poundFeet as? Self
        default:    return nil
        }
    }

    public static func create(unit: TorqueUnit) -> UnitTorque {
        switch unit {
        case .newtonMeters: return Self.newtonMeters
        case .newtonMillimeters: return Self.newtonMillimeters
        case .poundFeet: return Self.poundFeet
        }
    }

    public var identifiers: [UInt8]? {
        switch self {
        case .newtonMeters: return [Self.measurementID, 0x00]
        case .newtonMillimeters: return [Self.measurementID, 0x01]
        case .poundFeet: return [Self.measurementID, 0x02]
        default: return nil
        }
    }

    public var unit: TorqueUnit? {
        switch self {
        case .newtonMeters: return .newtonMeters
        case .newtonMillimeters: return .newtonMillimeters
        case .poundFeet: return .poundFeet
        default: return nil
        }
    }
}
