import Foundation
import HMUtilities

/// Status of the pre-conditioning system..
public enum AAEnginePreconditioningStatus: String, CaseIterable, Codable, HMBytesConvertable {
    case cooling
    case heating
    case inactive
    case standby
    case ventilation

    public var byteValue: UInt8 {
        switch self {
        case .standby: return 0x00
        case .heating: return 0x01
        case .cooling: return 0x02
        case .ventilation: return 0x03
        case .inactive: return 0x04
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
        case 0x00: self = .standby
        case 0x01: self = .heating
        case 0x02: self = .cooling
        case 0x03: self = .ventilation
        case 0x04: self = .inactive
        default: return nil
        }
    }
}
