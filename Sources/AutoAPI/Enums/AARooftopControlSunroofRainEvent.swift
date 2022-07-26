import Foundation
import HMUtilities

/// Sunroof event happened in case of rain.
public enum AARooftopControlSunroofRainEvent: String, CaseIterable, Codable, HMBytesConvertable {
    case automaticallyInStrokePosition
    case inStrokePositionBecauseOfRain
    case noEvent
    case timer

    public var byteValue: UInt8 {
        switch self {
        case .noEvent: return 0x00
        case .inStrokePositionBecauseOfRain: return 0x01
        case .automaticallyInStrokePosition: return 0x02
        case .timer: return 0x03
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
        case 0x00: self = .noEvent
        case 0x01: self = .inStrokePositionBecauseOfRain
        case 0x02: self = .automaticallyInStrokePosition
        case 0x03: self = .timer
        default: return nil
        }
    }
}
