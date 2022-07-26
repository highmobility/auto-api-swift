import Foundation
import HMUtilities

/// Location enum.
public enum AALaneKeepAssistStateLocation: String, CaseIterable, Codable, HMBytesConvertable {
    case left
    case right

    public var byteValue: UInt8 {
        switch self {
        case .left: return 0x00
        case .right: return 0x01
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
        case 0x00: self = .left
        case 0x01: self = .right
        default: return nil
        }
    }
}
