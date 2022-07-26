import Foundation
import HMUtilities

/// Service-Status enum.
public enum AAServiceStatus: String, CaseIterable, Codable, HMBytesConvertable {
    case critical
    case ok
    case warning

    public var byteValue: UInt8 {
        switch self {
        case .ok: return 0x00
        case .warning: return 0x01
        case .critical: return 0x02
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
        case 0x00: self = .ok
        case 0x01: self = .warning
        case 0x02: self = .critical
        default: return nil
        }
    }
}
