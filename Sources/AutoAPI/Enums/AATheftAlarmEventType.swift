import Foundation
import HMUtilities

/// Position of the last even relative to the vehicle.
public enum AATheftAlarmEventType: String, CaseIterable, Codable, HMBytesConvertable {
    case frontLeft
    case frontMiddle
    case frontRight
    case idle
    case left
    case rearLeft
    case rearMiddle
    case rearRight
    case right
    case unknown

    public var byteValue: UInt8 {
        switch self {
        case .idle: return 0x00
        case .frontLeft: return 0x01
        case .frontMiddle: return 0x02
        case .frontRight: return 0x03
        case .right: return 0x04
        case .rearRight: return 0x05
        case .rearMiddle: return 0x06
        case .rearLeft: return 0x07
        case .left: return 0x08
        case .unknown: return 0x09
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
        case 0x00: self = .idle
        case 0x01: self = .frontLeft
        case 0x02: self = .frontMiddle
        case 0x03: self = .frontRight
        case 0x04: self = .right
        case 0x05: self = .rearRight
        case 0x06: self = .rearMiddle
        case 0x07: self = .rearLeft
        case 0x08: self = .left
        case 0x09: self = .unknown
        default: return nil
        }
    }
}
