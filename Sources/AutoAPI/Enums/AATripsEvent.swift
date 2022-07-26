import Foundation
import HMUtilities

/// Event enum.
public enum AATripsEvent: String, CaseIterable, Codable, HMBytesConvertable {
    case harshAcceleration
    case harshBraking
    case idlingEngineOn
    case overRpm
    case overspeed
    case sharpTurn

    public var byteValue: UInt8 {
        switch self {
        case .harshBraking: return 0x00
        case .harshAcceleration: return 0x01
        case .sharpTurn: return 0x02
        case .overRpm: return 0x03
        case .overspeed: return 0x04
        case .idlingEngineOn: return 0x05
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
        case 0x00: self = .harshBraking
        case 0x01: self = .harshAcceleration
        case 0x02: self = .sharpTurn
        case 0x03: self = .overRpm
        case 0x04: self = .overspeed
        case 0x05: self = .idlingEngineOn
        default: return nil
        }
    }
}
