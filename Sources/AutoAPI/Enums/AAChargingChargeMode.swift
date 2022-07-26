import Foundation
import HMUtilities

/// Charge mode enum.
public enum AAChargingChargeMode: String, CaseIterable, Codable, HMBytesConvertable {
    case conductive
    case immediate
    case inductive
    case pushButton
    case timerBased

    public var byteValue: UInt8 {
        switch self {
        case .immediate: return 0x00
        case .timerBased: return 0x01
        case .inductive: return 0x02
        case .conductive: return 0x03
        case .pushButton: return 0x04
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
        case 0x00: self = .immediate
        case 0x01: self = .timerBased
        case 0x02: self = .inductive
        case 0x03: self = .conductive
        case 0x04: self = .pushButton
        default: return nil
        }
    }
}
