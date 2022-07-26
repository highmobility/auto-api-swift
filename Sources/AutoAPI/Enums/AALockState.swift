import Foundation
import HMUtilities

/// Lock state enum.
public enum AALockState: String, CaseIterable, Codable, HMBytesConvertable {
    case locked
    case unlocked

    public var byteValue: UInt8 {
        switch self {
        case .unlocked: return 0x00
        case .locked: return 0x01
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
        case 0x00: self = .unlocked
        case 0x01: self = .locked
        default: return nil
        }
    }
}
