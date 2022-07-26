import Foundation
import HMUtilities

/// The system effect an inpact had on the vehicle..
public enum AACrashStatus: String, CaseIterable, Codable, HMBytesConvertable {
    case airbagTriggered
    case normal
    case restraintsEngaged

    public var byteValue: UInt8 {
        switch self {
        case .normal: return 0x00
        case .restraintsEngaged: return 0x01
        case .airbagTriggered: return 0x02
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
        case 0x00: self = .normal
        case 0x01: self = .restraintsEngaged
        case 0x02: self = .airbagTriggered
        default: return nil
        }
    }
}
