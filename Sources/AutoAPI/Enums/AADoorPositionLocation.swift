import Foundation
import HMUtilities

/// Location enum.
public enum AADoorPositionLocation: String, CaseIterable, Codable, HMBytesConvertable {
    case all
    case frontLeft
    case frontRight
    case rearLeft
    case rearRight

    public var byteValue: UInt8 {
        switch self {
        case .frontLeft: return 0x00
        case .frontRight: return 0x01
        case .rearRight: return 0x02
        case .rearLeft: return 0x03
        case .all: return 0x05
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
        case 0x05: self = .all
        default: return nil
        }
    }
}
