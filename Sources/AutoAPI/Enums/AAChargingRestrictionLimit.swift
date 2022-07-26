import Foundation
import HMUtilities

/// Limit enum.
public enum AAChargingRestrictionLimit: String, CaseIterable, Codable, HMBytesConvertable {
    case max
    case min
    case reduced

    public var byteValue: UInt8 {
        switch self {
        case .max: return 0x00
        case .reduced: return 0x01
        case .min: return 0x02
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
        case 0x00: self = .max
        case 0x01: self = .reduced
        case 0x02: self = .min
        default: return nil
        }
    }
}
