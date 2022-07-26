import Foundation
import HMUtilities

/// On-Off State enum.
public enum AAOnOffState: String, CaseIterable, Codable, HMBytesConvertable {
    case off
    case on

    public var byteValue: UInt8 {
        switch self {
        case .off: return 0x00
        case .on: return 0x01
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
        case 0x00: self = .off
        case 0x01: self = .on
        default: return nil
        }
    }
}
