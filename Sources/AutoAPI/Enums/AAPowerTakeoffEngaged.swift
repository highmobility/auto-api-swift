import Foundation
import HMUtilities

/// Engaged enum.
public enum AAPowerTakeoffEngaged: String, CaseIterable, Codable, HMBytesConvertable {
    case engaged
    case notEngaged

    public var byteValue: UInt8 {
        switch self {
        case .notEngaged: return 0x00
        case .engaged: return 0x01
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
        case 0x00: self = .notEngaged
        case 0x01: self = .engaged
        default: return nil
        }
    }
}
