import Foundation
import HMUtilities

/// Tipped state enum.
public enum AACrashTippedState: String, CaseIterable, Codable, HMBytesConvertable {
    case notTipped
    case tippedOver

    public var byteValue: UInt8 {
        switch self {
        case .tippedOver: return 0x00
        case .notTipped: return 0x01
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
        case 0x00: self = .tippedOver
        case 0x01: self = .notTipped
        default: return nil
        }
    }
}
