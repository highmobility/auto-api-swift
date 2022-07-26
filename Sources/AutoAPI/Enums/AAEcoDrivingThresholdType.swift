import Foundation
import HMUtilities

/// Type enum.
public enum AAEcoDrivingThresholdType: String, CaseIterable, Codable, HMBytesConvertable {
    case one
    case zero

    public var byteValue: UInt8 {
        switch self {
        case .zero: return 0x00
        case .one: return 0x01
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
        case 0x00: self = .zero
        case 0x01: self = .one
        default: return nil
        }
    }
}
