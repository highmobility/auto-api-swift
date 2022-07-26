import Foundation
import HMUtilities

/// Weekday enum.
public enum AAWeekday: String, CaseIterable, Codable, HMBytesConvertable {
    case automatic
    case friday
    case monday
    case saturday
    case sunday
    case thursday
    case tuesday
    case wednesday

    public var byteValue: UInt8 {
        switch self {
        case .monday: return 0x00
        case .tuesday: return 0x01
        case .wednesday: return 0x02
        case .thursday: return 0x03
        case .friday: return 0x04
        case .saturday: return 0x05
        case .sunday: return 0x06
        case .automatic: return 0x07
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
        case 0x00: self = .monday
        case 0x01: self = .tuesday
        case 0x02: self = .wednesday
        case 0x03: self = .thursday
        case 0x04: self = .friday
        case 0x05: self = .saturday
        case 0x06: self = .sunday
        case 0x07: self = .automatic
        default: return nil
        }
    }
}
