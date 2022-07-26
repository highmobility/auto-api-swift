import Foundation
import HMUtilities

/// Impact zone of the crash.
public enum AACrashImpactZone: String, CaseIterable, Codable, HMBytesConvertable {
    case frontDriverSide
    case frontPassengerSide
    case pedestrianProtection
    case rearDriverSide
    case rearPassengerSide
    case rollover
    case sideDriverSide
    case sidePassengerSide

    public var byteValue: UInt8 {
        switch self {
        case .pedestrianProtection: return 0x00
        case .rollover: return 0x01
        case .rearPassengerSide: return 0x02
        case .rearDriverSide: return 0x03
        case .sidePassengerSide: return 0x04
        case .sideDriverSide: return 0x05
        case .frontPassengerSide: return 0x06
        case .frontDriverSide: return 0x07
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
        case 0x00: self = .pedestrianProtection
        case 0x01: self = .rollover
        case 0x02: self = .rearPassengerSide
        case 0x03: self = .rearDriverSide
        case 0x04: self = .sidePassengerSide
        case 0x05: self = .sideDriverSide
        case 0x06: self = .frontPassengerSide
        case 0x07: self = .frontDriverSide
        default: return nil
        }
    }
}
