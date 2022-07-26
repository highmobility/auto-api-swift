import Foundation
import HMUtilities

/// Active selected state enum.
public enum AAActiveSelectedState: String, CaseIterable, Codable, HMBytesConvertable {
    case active
    case inactiveNotSelected
    case inactiveSelected

    public var byteValue: UInt8 {
        switch self {
        case .inactiveSelected: return 0x00
        case .inactiveNotSelected: return 0x01
        case .active: return 0x02
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
        case 0x00: self = .inactiveSelected
        case 0x01: self = .inactiveNotSelected
        case 0x02: self = .active
        default: return nil
        }
    }
}
