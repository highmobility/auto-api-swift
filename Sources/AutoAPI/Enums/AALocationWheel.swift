import Foundation
import HMUtilities

/// Location wheel enum.
public enum AALocationWheel: String, CaseIterable, Codable, HMBytesConvertable {
    case frontLeft
    case frontRight
    case rearLeft
    case rearLeftOuter
    case rearRight
    case rearRightOuter
    case spare

    public var byteValue: UInt8 {
        switch self {
        case .frontLeft: return 0x00
        case .frontRight: return 0x01
        case .rearRight: return 0x02
        case .rearLeft: return 0x03
        case .rearRightOuter: return 0x04
        case .rearLeftOuter: return 0x05
        case .spare: return 0x06
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
        case 0x04: self = .rearRightOuter
        case 0x05: self = .rearLeftOuter
        case 0x06: self = .spare
        default: return nil
        }
    }
}
