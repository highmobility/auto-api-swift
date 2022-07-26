import Foundation
import HMUtilities

/// WorkingState enum.
public enum AADriverWorkingStateWorkingState: String, CaseIterable, Codable, HMBytesConvertable {
    case driverAvailable
    case driving
    case resting
    case working

    public var byteValue: UInt8 {
        switch self {
        case .resting: return 0x00
        case .driverAvailable: return 0x01
        case .working: return 0x02
        case .driving: return 0x03
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
        case 0x00: self = .resting
        case 0x01: self = .driverAvailable
        case 0x02: self = .working
        case 0x03: self = .driving
        default: return nil
        }
    }
}
