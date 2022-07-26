import Foundation
import HMUtilities

/// Battery state..
public enum AAChargingBatteryStatus: String, CaseIterable, Codable, HMBytesConvertable {
    case active
    case balancing
    case conditioning
    case error
    case externalLoad
    case inactive
    case initialising
    case load

    public var byteValue: UInt8 {
        switch self {
        case .inactive: return 0x00
        case .active: return 0x01
        case .balancing: return 0x02
        case .externalLoad: return 0x03
        case .load: return 0x04
        case .error: return 0x05
        case .initialising: return 0x06
        case .conditioning: return 0x07
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
        case 0x00: self = .inactive
        case 0x01: self = .active
        case 0x02: self = .balancing
        case 0x03: self = .externalLoad
        case 0x04: self = .load
        case 0x05: self = .error
        case 0x06: self = .initialising
        case 0x07: self = .conditioning
        default: return nil
        }
    }
}
