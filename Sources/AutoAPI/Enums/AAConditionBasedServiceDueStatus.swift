import Foundation
import HMUtilities

/// DueStatus enum.
public enum AAConditionBasedServiceDueStatus: String, CaseIterable, Codable, HMBytesConvertable {
    case ok
    case overdue
    case pending

    public var byteValue: UInt8 {
        switch self {
        case .ok: return 0x00
        case .pending: return 0x01
        case .overdue: return 0x02
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
        case 0x01: self = .pending
        case 0x02: self = .overdue
        default: return nil
        }
    }
}
