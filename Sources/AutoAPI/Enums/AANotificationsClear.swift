import Foundation
import HMUtilities

/// Clear enum.
public enum AANotificationsClear: String, CaseIterable, Codable, HMBytesConvertable {
    case clear

    public var byteValue: UInt8 {
        switch self {
        case .clear: return 0x00
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
        case 0x00: self = .clear
        default: return nil
        }
    }
}
