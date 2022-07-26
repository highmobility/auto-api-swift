import Foundation
import HMUtilities

/// Position enum.
public enum AAPosition: String, CaseIterable, Codable, HMBytesConvertable {
    case closed
    case open

    public var byteValue: UInt8 {
        switch self {
        case .closed: return 0x00
        case .open: return 0x01
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
        case 0x00: self = .closed
        case 0x01: self = .open
        default: return nil
        }
    }
}
