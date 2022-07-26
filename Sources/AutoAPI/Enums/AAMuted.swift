import Foundation
import HMUtilities

/// Muted enum.
public enum AAMuted: String, CaseIterable, Codable, HMBytesConvertable {
    case muted
    case notMuted

    public var byteValue: UInt8 {
        switch self {
        case .notMuted: return 0x00
        case .muted: return 0x01
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
        case 0x00: self = .notMuted
        case 0x01: self = .muted
        default: return nil
        }
    }
}
