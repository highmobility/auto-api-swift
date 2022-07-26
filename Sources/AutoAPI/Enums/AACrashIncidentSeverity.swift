import Foundation
import HMUtilities

/// Severity enum.
public enum AACrashIncidentSeverity: String, CaseIterable, Codable, HMBytesConvertable {
    case high
    case low
    case medium
    case unknown
    case veryHigh

    public var byteValue: UInt8 {
        switch self {
        case .veryHigh: return 0x00
        case .high: return 0x01
        case .medium: return 0x02
        case .low: return 0x03
        case .unknown: return 0x04
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
        case 0x00: self = .veryHigh
        case 0x01: self = .high
        case 0x02: self = .medium
        case 0x03: self = .low
        case 0x04: self = .unknown
        default: return nil
        }
    }
}
