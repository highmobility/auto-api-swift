import Foundation
import HMUtilities

/// Status enum.
public enum AAWakeUpStatus: String, CaseIterable, Codable, HMBytesConvertable {
    case sleep
    case wakeUp

    public var byteValue: UInt8 {
        switch self {
        case .wakeUp: return 0x00
        case .sleep: return 0x01
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
        case 0x00: self = .wakeUp
        case 0x01: self = .sleep
        default: return nil
        }
    }
}
