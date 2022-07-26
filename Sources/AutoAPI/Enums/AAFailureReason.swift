import Foundation
import HMUtilities

/// Reason enum.
public enum AAFailureReason: String, CaseIterable, Codable, HMBytesConvertable {
    case executionTimeout
    case formatError
    case oemError
    case pending
    case privacyModeActive
    case rateLimit
    case unauthorised
    case unknown

    public var byteValue: UInt8 {
        switch self {
        case .rateLimit: return 0x00
        case .executionTimeout: return 0x01
        case .formatError: return 0x02
        case .unauthorised: return 0x03
        case .unknown: return 0x04
        case .pending: return 0x05
        case .oemError: return 0x06
        case .privacyModeActive: return 0x07
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
        case 0x00: self = .rateLimit
        case 0x01: self = .executionTimeout
        case 0x02: self = .formatError
        case 0x03: self = .unauthorised
        case 0x04: self = .unknown
        case 0x05: self = .pending
        case 0x06: self = .oemError
        case 0x07: self = .privacyModeActive
        default: return nil
        }
    }
}
