import Foundation
import HMUtilities

/// Charging process count of the high-voltage battery (phases)..
public enum AAChargingChargingPhases: String, CaseIterable, Codable, HMBytesConvertable {
    case noCharging
    case one
    case three
    case two

    public var byteValue: UInt8 {
        switch self {
        case .noCharging: return 0x00
        case .one: return 0x01
        case .two: return 0x02
        case .three: return 0x03
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
        case 0x00: self = .noCharging
        case 0x01: self = .one
        case 0x02: self = .two
        case 0x03: self = .three
        default: return nil
        }
    }
}
