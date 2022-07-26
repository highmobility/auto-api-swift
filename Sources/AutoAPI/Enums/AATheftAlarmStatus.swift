import Foundation
import HMUtilities

/// Status enum.
public enum AATheftAlarmStatus: String, CaseIterable, Codable, HMBytesConvertable {
    case armed
    case triggered
    case unarmed

    public var byteValue: UInt8 {
        switch self {
        case .unarmed: return 0x00
        case .armed: return 0x01
        case .triggered: return 0x02
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
        case 0x00: self = .unarmed
        case 0x01: self = .armed
        case 0x02: self = .triggered
        default: return nil
        }
    }
}
