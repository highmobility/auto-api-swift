import Foundation
import HMUtilities

/// Windscreen needs replacement enum.
public enum AAWindscreenWindscreenNeedsReplacement: String, CaseIterable, Codable, HMBytesConvertable {
    case noReplacementNeeded
    case replacementNeeded
    case unknown

    public var byteValue: UInt8 {
        switch self {
        case .unknown: return 0x00
        case .noReplacementNeeded: return 0x01
        case .replacementNeeded: return 0x02
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
        case 0x01: self = .noReplacementNeeded
        case 0x02: self = .replacementNeeded
        default: return nil
        }
    }
}
