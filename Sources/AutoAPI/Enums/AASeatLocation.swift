import Foundation
import HMUtilities

/// Seat location enum.
public enum AASeatLocation: String, CaseIterable, Codable, HMBytesConvertable {
    case frontLeft
    case frontRight
    case rearCenter
    case rearLeft
    case rearRight

    public var byteValue: UInt8 {
        switch self {
        case .frontLeft: return 0x00
        case .frontRight: return 0x01
        case .rearRight: return 0x02
        case .rearLeft: return 0x03
        case .rearCenter: return 0x04
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
        case 0x00: self = .frontLeft
        case 0x01: self = .frontRight
        case 0x02: self = .rearRight
        case 0x03: self = .rearLeft
        case 0x04: self = .rearCenter
        default: return nil
        }
    }
}
