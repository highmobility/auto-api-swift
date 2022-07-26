import Foundation
import HMUtilities

/// State of the starter battery.
public enum AAChargingStarterBatteryState: String, CaseIterable, Codable, HMBytesConvertable {
    case green
    case greenYellow
    case orange
    case red
    case yellow

    public var byteValue: UInt8 {
        switch self {
        case .red: return 0x00
        case .yellow: return 0x01
        case .green: return 0x02
        case .orange: return 0x03
        case .greenYellow: return 0x04
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
        case 0x00: self = .red
        case 0x01: self = .yellow
        case 0x02: self = .green
        case 0x03: self = .orange
        case 0x04: self = .greenYellow
        default: return nil
        }
    }
}
