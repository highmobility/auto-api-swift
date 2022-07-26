import Foundation
import HMUtilities

/// Wipers intensity enum.
public enum AAWindscreenWipersIntensity: String, CaseIterable, Codable, HMBytesConvertable {
    case level0
    case level1
    case level2
    case level3

    public var byteValue: UInt8 {
        switch self {
        case .level0: return 0x00
        case .level1: return 0x01
        case .level2: return 0x02
        case .level3: return 0x03
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
        case 0x00: self = .level0
        case 0x01: self = .level1
        case 0x02: self = .level2
        case 0x03: self = .level3
        default: return nil
        }
    }
}
