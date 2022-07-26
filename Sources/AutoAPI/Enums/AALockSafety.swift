import Foundation
import HMUtilities

/// Lock safety enum.
public enum AALockSafety: String, CaseIterable, Codable, HMBytesConvertable {
    case safe
    case unsafe

    public var byteValue: UInt8 {
        switch self {
        case .safe: return 0x00
        case .unsafe: return 0x01
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
        case 0x00: self = .safe
        case 0x01: self = .unsafe
        default: return nil
        }
    }
}
