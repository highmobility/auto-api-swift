import Foundation
import HMUtilities

/// Type enum.
public enum AAAccelerationDurationType: String, CaseIterable, Codable, HMBytesConvertable {
    case negativeOutlier
    case positiveOutlier
    case regular

    public var byteValue: UInt8 {
        switch self {
        case .regular: return 0x00
        case .positiveOutlier: return 0x01
        case .negativeOutlier: return 0x02
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
        case 0x00: self = .regular
        case 0x01: self = .positiveOutlier
        case 0x02: self = .negativeOutlier
        default: return nil
        }
    }
}
