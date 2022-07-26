import Foundation
import HMUtilities

/// Type enum.
public enum AACrashType: String, CaseIterable, Codable, HMBytesConvertable {
    case nonPedestrian
    case pedestrian

    public var byteValue: UInt8 {
        switch self {
        case .pedestrian: return 0x00
        case .nonPedestrian: return 0x01
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
        case 0x00: self = .pedestrian
        case 0x01: self = .nonPedestrian
        default: return nil
        }
    }
}
