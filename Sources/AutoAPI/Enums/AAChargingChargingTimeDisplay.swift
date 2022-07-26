import Foundation
import HMUtilities

/// Charging time displayed in the vehicle..
public enum AAChargingChargingTimeDisplay: String, CaseIterable, Codable, HMBytesConvertable {
    case displayDuration
    case noDisplay
    case noDisplayDuration

    public var byteValue: UInt8 {
        switch self {
        case .noDisplay: return 0x00
        case .displayDuration: return 0x01
        case .noDisplayDuration: return 0x02
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
        case 0x00: self = .noDisplay
        case 0x01: self = .displayDuration
        case 0x02: self = .noDisplayDuration
        default: return nil
        }
    }
}
