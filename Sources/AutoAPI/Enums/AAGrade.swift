import Foundation
import HMUtilities

/// Grade enum.
public enum AAGrade: String, CaseIterable, Codable, HMBytesConvertable {
    case excellent
    case normal
    case warning

    public var byteValue: UInt8 {
        switch self {
        case .excellent: return 0x00
        case .normal: return 0x01
        case .warning: return 0x02
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
        case 0x00: self = .excellent
        case 0x01: self = .normal
        case 0x02: self = .warning
        default: return nil
        }
    }
}
