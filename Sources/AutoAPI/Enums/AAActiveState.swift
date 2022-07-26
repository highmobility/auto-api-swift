import Foundation
import HMUtilities

/// Active state enum.
public enum AAActiveState: String, CaseIterable, Codable, HMBytesConvertable {
    case active
    case inactive

    public var byteValue: UInt8 {
        switch self {
        case .inactive: return 0x00
        case .active: return 0x01
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
        default: return nil
        }
    }
}
