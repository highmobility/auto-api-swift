import Foundation
import HMUtilities

/// TimeState enum.
public enum AADriverTimeStateTimeState: String, CaseIterable, Codable, HMBytesConvertable {
    case fifteenMinBeforeFour
    case fifteenMinBeforeNine
    case fifteenMinBeforeSixteen
    case fourReached
    case nineReached
    case normal
    case sixteenReached

    public var byteValue: UInt8 {
        switch self {
        case .normal: return 0x00
        case .fifteenMinBeforeFour: return 0x01
        case .fourReached: return 0x02
        case .fifteenMinBeforeNine: return 0x03
        case .nineReached: return 0x04
        case .fifteenMinBeforeSixteen: return 0x05
        case .sixteenReached: return 0x06
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
        case 0x00: self = .normal
        case 0x01: self = .fifteenMinBeforeFour
        case 0x02: self = .fourReached
        case 0x03: self = .fifteenMinBeforeNine
        case 0x04: self = .nineReached
        case 0x05: self = .fifteenMinBeforeSixteen
        case 0x06: self = .sixteenReached
        default: return nil
        }
    }
}
