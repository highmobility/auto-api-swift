import Foundation
import HMUtilities

/// Time zone setting in the vehicle..
public enum AAVehicleInformationTimeZone: String, CaseIterable, Codable, HMBytesConvertable {
    case manual
    case summertime
    case utc
    case wintertime

    public var byteValue: UInt8 {
        switch self {
        case .wintertime: return 0x00
        case .summertime: return 0x01
        case .utc: return 0x02
        case .manual: return 0x03
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
        case 0x00: self = .wintertime
        case 0x01: self = .summertime
        case 0x02: self = .utc
        case 0x03: self = .manual
        default: return nil
        }
    }
}
