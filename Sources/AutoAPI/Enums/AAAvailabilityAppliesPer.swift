import Foundation
import HMUtilities

/// Rate limit applies per.
public enum AAAvailabilityAppliesPer: String, CaseIterable, Codable, HMBytesConvertable {
    case app
    case vehicle

    public var byteValue: UInt8 {
        switch self {
        case .app: return 0x00
        case .vehicle: return 0x01
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
        case 0x00: self = .app
        case 0x01: self = .vehicle
        default: return nil
        }
    }
}
