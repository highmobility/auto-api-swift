import Foundation
import HMUtilities

/// Repairs enum.
public enum AACrashIncidentRepairs: String, CaseIterable, Codable, HMBytesConvertable {
    case needed
    case notNeeded
    case unknown

    public var byteValue: UInt8 {
        switch self {
        case .unknown: return 0x00
        case .needed: return 0x01
        case .notNeeded: return 0x02
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
        case 0x00: self = .unknown
        case 0x01: self = .needed
        case 0x02: self = .notNeeded
        default: return nil
        }
    }
}
