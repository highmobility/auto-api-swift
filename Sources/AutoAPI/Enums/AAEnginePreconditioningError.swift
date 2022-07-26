import Foundation
import HMUtilities

/// Reason for not carrying out pre-conditioning..
public enum AAEnginePreconditioningError: String, CaseIterable, Codable, HMBytesConvertable {
    case componentFailure
    case heaterFailure
    case lowBattery
    case lowFuel
    case ok
    case openOrUnlocked
    case quotaExceeded

    public var byteValue: UInt8 {
        switch self {
        case .lowFuel: return 0x00
        case .lowBattery: return 0x01
        case .quotaExceeded: return 0x02
        case .heaterFailure: return 0x03
        case .componentFailure: return 0x04
        case .openOrUnlocked: return 0x05
        case .ok: return 0x06
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
        case 0x00: self = .lowFuel
        case 0x01: self = .lowBattery
        case 0x02: self = .quotaExceeded
        case 0x03: self = .heaterFailure
        case 0x04: self = .componentFailure
        case 0x05: self = .openOrUnlocked
        case 0x06: self = .ok
        default: return nil
        }
    }
}
