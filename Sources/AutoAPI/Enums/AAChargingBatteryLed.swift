import Foundation
import HMUtilities

/// State of LED for the battery..
public enum AAChargingBatteryLed: String, CaseIterable, Codable, HMBytesConvertable {
    case error
    case green
    case greenFlashing
    case greenPulsing
    case greenRedPulsing
    case initialising
    case noColour
    case red
    case redPulsing
    case white
    case yellow
    case yellowPulsing

    public var byteValue: UInt8 {
        switch self {
        case .noColour: return 0x00
        case .white: return 0x01
        case .yellow: return 0x02
        case .green: return 0x03
        case .red: return 0x04
        case .yellowPulsing: return 0x05
        case .greenPulsing: return 0x06
        case .redPulsing: return 0x07
        case .greenRedPulsing: return 0x08
        case .greenFlashing: return 0x09
        case .initialising: return 0x0a
        case .error: return 0x0b
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
        case 0x00: self = .noColour
        case 0x01: self = .white
        case 0x02: self = .yellow
        case 0x03: self = .green
        case 0x04: self = .red
        case 0x05: self = .yellowPulsing
        case 0x06: self = .greenPulsing
        case 0x07: self = .redPulsing
        case 0x08: self = .greenRedPulsing
        case 0x09: self = .greenFlashing
        case 0x0a: self = .initialising
        case 0x0b: self = .error
        default: return nil
        }
    }
}
