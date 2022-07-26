import Foundation
import HMUtilities

/// TimerType enum.
public enum AATimerTimerType: String, CaseIterable, Codable, HMBytesConvertable {
    case departureDate
    case preferredEndTime
    case preferredStartTime

    public var byteValue: UInt8 {
        switch self {
        case .preferredStartTime: return 0x00
        case .preferredEndTime: return 0x01
        case .departureDate: return 0x02
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
        case 0x00: self = .preferredStartTime
        case 0x01: self = .preferredEndTime
        case 0x02: self = .departureDate
        default: return nil
        }
    }
}
