import Foundation
import HMUtilities

/// Failure reason enum.
public enum AAFailureMessageFailureReason: String, CaseIterable, Codable, HMBytesConvertable {
    case executionTimeout
    case incorrectState
    case invalidCommand
    case oemError
    case pending
    case privacyModeActive
    case rateLimit
    case unauthorised
    case unsupportedCapability
    case vehicleAsleep

    public var byteValue: UInt8 {
        switch self {
        case .unsupportedCapability: return 0x00
        case .unauthorised: return 0x01
        case .incorrectState: return 0x02
        case .executionTimeout: return 0x03
        case .vehicleAsleep: return 0x04
        case .invalidCommand: return 0x05
        case .pending: return 0x06
        case .rateLimit: return 0x07
        case .oemError: return 0x08
        case .privacyModeActive: return 0x09
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
        case 0x00: self = .unsupportedCapability
        case 0x01: self = .unauthorised
        case 0x02: self = .incorrectState
        case 0x03: self = .executionTimeout
        case 0x04: self = .vehicleAsleep
        case 0x05: self = .invalidCommand
        case 0x06: self = .pending
        case 0x07: self = .rateLimit
        case 0x08: self = .oemError
        case 0x09: self = .privacyModeActive
        default: return nil
        }
    }
}
