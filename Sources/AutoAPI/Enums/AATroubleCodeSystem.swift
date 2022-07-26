import Foundation
import HMUtilities

/// System enum.
public enum AATroubleCodeSystem: String, CaseIterable, Codable, HMBytesConvertable {
    case body
    case chassis
    case network
    case powertrain
    case unknown

    public var byteValue: UInt8 {
        switch self {
        case .unknown: return 0x00
        case .body: return 0x01
        case .chassis: return 0x02
        case .powertrain: return 0x03
        case .network: return 0x04
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
        case 0x01: self = .body
        case 0x02: self = .chassis
        case 0x03: self = .powertrain
        case 0x04: self = .network
        default: return nil
        }
    }
}
