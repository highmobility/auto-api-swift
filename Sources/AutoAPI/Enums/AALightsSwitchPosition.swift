import Foundation
import HMUtilities

/// Position of the rotary light switch.
public enum AALightsSwitchPosition: String, CaseIterable, Codable, HMBytesConvertable {
    case automatic
    case dippedHeadlights
    case parkingLightLeft
    case parkingLightRight
    case sidelights

    public var byteValue: UInt8 {
        switch self {
        case .automatic: return 0x00
        case .dippedHeadlights: return 0x01
        case .parkingLightRight: return 0x02
        case .parkingLightLeft: return 0x03
        case .sidelights: return 0x04
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
        case 0x00: self = .automatic
        case 0x01: self = .dippedHeadlights
        case 0x02: self = .parkingLightRight
        case 0x03: self = .parkingLightLeft
        case 0x04: self = .sidelights
        default: return nil
        }
    }
}
