import Foundation
import HMUtilities

/// Detected fatigue level enum.
public enum AADriverFatigueDetectedFatigueLevel: String, CaseIterable, Codable, HMBytesConvertable {
    case actionNeeded
    case carReadyToTakeOver
    case light
    case pauseRecommended

    public var byteValue: UInt8 {
        switch self {
        case .light: return 0x00
        case .pauseRecommended: return 0x01
        case .actionNeeded: return 0x02
        case .carReadyToTakeOver: return 0x03
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
        case 0x00: self = .light
        case 0x01: self = .pauseRecommended
        case 0x02: self = .actionNeeded
        case 0x03: self = .carReadyToTakeOver
        default: return nil
        }
    }
}
