import Foundation
import HMUtilities

/// Limiter enum.
public enum AACruiseControlLimiter: String, CaseIterable, Codable, HMBytesConvertable {
    case higherSpeedRequested
    case lowerSpeedRequested
    case notSet
    case speedFixed

    public var byteValue: UInt8 {
        switch self {
        case .notSet: return 0x00
        case .higherSpeedRequested: return 0x01
        case .lowerSpeedRequested: return 0x02
        case .speedFixed: return 0x03
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
        case 0x00: self = .notSet
        case 0x01: self = .higherSpeedRequested
        case 0x02: self = .lowerSpeedRequested
        case 0x03: self = .speedFixed
        default: return nil
        }
    }
}
