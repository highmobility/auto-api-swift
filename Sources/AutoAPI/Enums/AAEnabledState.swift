import Foundation
import HMUtilities

/// Enabled state enum.
public enum AAEnabledState: String, CaseIterable, Codable, HMBytesConvertable {
    case disabled
    case enabled

    public var byteValue: UInt8 {
        switch self {
        case .disabled: return 0x00
        case .enabled: return 0x01
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
        case 0x00: self = .disabled
        case 0x01: self = .enabled
        default: return nil
        }
    }
}
