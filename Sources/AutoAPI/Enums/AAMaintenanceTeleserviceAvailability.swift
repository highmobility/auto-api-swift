import Foundation
import HMUtilities

/// Teleservice availability enum.
public enum AAMaintenanceTeleserviceAvailability: String, CaseIterable, Codable, HMBytesConvertable {
    case error
    case idle
    case pending
    case successful

    public var byteValue: UInt8 {
        switch self {
        case .pending: return 0x00
        case .idle: return 0x01
        case .successful: return 0x02
        case .error: return 0x03
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
        case 0x00: self = .pending
        case 0x01: self = .idle
        case 0x02: self = .successful
        case 0x03: self = .error
        default: return nil
        }
    }
}
