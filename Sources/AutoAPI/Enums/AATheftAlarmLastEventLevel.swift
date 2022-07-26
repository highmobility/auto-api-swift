import Foundation
import HMUtilities

/// Level of impact for the last event.
public enum AATheftAlarmLastEventLevel: String, CaseIterable, Codable, HMBytesConvertable {
    case high
    case low
    case medium

    public var byteValue: UInt8 {
        switch self {
        case .low: return 0x00
        case .medium: return 0x01
        case .high: return 0x02
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
        case 0x00: self = .low
        case 0x01: self = .medium
        case 0x02: self = .high
        default: return nil
        }
    }
}
