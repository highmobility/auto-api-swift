import Foundation
import HMUtilities

/// Indicates the status of the parking light..
public enum AALightsParkingLightStatus: String, CaseIterable, Codable, HMBytesConvertable {
    case both
    case left
    case off
    case right

    public var byteValue: UInt8 {
        switch self {
        case .off: return 0x00
        case .left: return 0x01
        case .right: return 0x02
        case .both: return 0x03
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
        case 0x00: self = .off
        case 0x01: self = .left
        case 0x02: self = .right
        case 0x03: self = .both
        default: return nil
        }
    }
}
