import Foundation
import HMUtilities

/// Eco level enum.
public enum AATripsEcoLevel: String, CaseIterable, Codable, HMBytesConvertable {
    case high
    case medium

    public var byteValue: UInt8 {
        switch self {
        case .high: return 0x00
        case .medium: return 0x01
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
        case 0x00: self = .high
        case 0x01: self = .medium
        default: return nil
        }
    }
}
