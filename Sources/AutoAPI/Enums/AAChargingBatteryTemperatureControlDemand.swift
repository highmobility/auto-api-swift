import Foundation
import HMUtilities

/// Current demand of HV battery temperature control system..
public enum AAChargingBatteryTemperatureControlDemand: String, CaseIterable, Codable, HMBytesConvertable {
    case circulationRequirement
    case highCooling
    case highHeating
    case lowCooling
    case lowHeating
    case mediumCooling
    case mediumHeating
    case noTemperatureRequirement

    public var byteValue: UInt8 {
        switch self {
        case .highCooling: return 0x00
        case .mediumCooling: return 0x01
        case .lowCooling: return 0x02
        case .noTemperatureRequirement: return 0x03
        case .lowHeating: return 0x04
        case .mediumHeating: return 0x05
        case .highHeating: return 0x06
        case .circulationRequirement: return 0x07
        }
    }

    // MARK: HMBytesConvertable
    public var bytes: [UInt8] {
        [byteValue]
    }

    public init?(bytes: [UInt8]) {
        guard let uint8 = UInt8(bytes: bytes) else {
            return nil
        }

        switch uint8 {
        case 0x00: self = .highCooling
        case 0x01: self = .mediumCooling
        case 0x02: self = .lowCooling
        case 0x03: self = .noTemperatureRequirement
        case 0x04: self = .lowHeating
        case 0x05: self = .mediumHeating
        case 0x06: self = .highHeating
        case 0x07: self = .circulationRequirement
        default: return nil
        }
    }
}
