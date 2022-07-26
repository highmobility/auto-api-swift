import Foundation
import HMUtilities

/// Plug type enum.
public enum AAChargingPlugType: String, CaseIterable, Codable, HMBytesConvertable {
    case ccs
    case chademo
    case type1
    case type2

    public var byteValue: UInt8 {
        switch self {
        case .type1: return 0x00
        case .type2: return 0x01
        case .ccs: return 0x02
        case .chademo: return 0x03
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
        case 0x00: self = .type1
        case 0x01: self = .type2
        case 0x02: self = .ccs
        case 0x03: self = .chademo
        default: return nil
        }
    }
}
