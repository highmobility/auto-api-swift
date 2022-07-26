import Foundation
import HMUtilities

/// Detected enum.
public enum AADetected: String, CaseIterable, Codable, HMBytesConvertable {
    case detected
    case notDetected

    public var byteValue: UInt8 {
        switch self {
        case .notDetected: return 0x00
        case .detected: return 0x01
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
        case 0x00: self = .notDetected
        case 0x01: self = .detected
        default: return nil
        }
    }
}
