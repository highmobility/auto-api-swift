import Foundation
import HMUtilities

/// Driver seat location enum.
public enum AAVehicleInformationDriverSeatLocation: String, CaseIterable, Codable, HMBytesConvertable {
    case center
    case left
    case right

    public var byteValue: UInt8 {
        switch self {
        case .left: return 0x00
        case .right: return 0x01
        case .center: return 0x02
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
        case 0x00: self = .left
        case 0x01: self = .right
        case 0x02: self = .center
        default: return nil
        }
    }
}
