import Foundation
import HMUtilities

/// Triggered enum.
public enum AATriggered: String, CaseIterable, Codable, HMBytesConvertable {
    case notTriggered
    case triggered

    public var byteValue: UInt8 {
        switch self {
        case .notTriggered: return 0x00
        case .triggered: return 0x01
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
        case 0x00: self = .notTriggered
        case 0x01: self = .triggered
        default: return nil
        }
    }
}
