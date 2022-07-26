import Foundation
import HMUtilities

/// Status enum.
public enum AATirePressureStatusStatus: String, CaseIterable, Codable, HMBytesConvertable {
    case alert
    case deflation
    case low
    case normal
    case soft

    public var byteValue: UInt8 {
        switch self {
        case .normal: return 0x00
        case .low: return 0x01
        case .alert: return 0x02
        case .soft: return 0x03
        case .deflation: return 0x04
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
        case 0x00: self = .normal
        case 0x01: self = .low
        case 0x02: self = .alert
        case 0x03: self = .soft
        case 0x04: self = .deflation
        default: return nil
        }
    }
}
