import Foundation
import HMUtilities

/// Fluid level enum.
public enum AAFluidLevel: String, CaseIterable, Codable, HMBytesConvertable {
    case filled
    case high
    case low
    case normal
    case veryHigh
    case veryLow

    public var byteValue: UInt8 {
        switch self {
        case .low: return 0x00
        case .filled: return 0x01
        case .veryLow: return 0x02
        case .normal: return 0x03
        case .high: return 0x04
        case .veryHigh: return 0x05
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
        case 0x01: self = .filled
        case 0x02: self = .veryLow
        case 0x03: self = .normal
        case 0x04: self = .high
        case 0x05: self = .veryHigh
        default: return nil
        }
    }
}
