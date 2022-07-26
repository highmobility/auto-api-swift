import Foundation
import HMUtilities

/// Type of current in use.
public enum AAChargingCurrentType: String, CaseIterable, Codable, HMBytesConvertable {
    case alternatingCurrent
    case directCurrent

    public var byteValue: UInt8 {
        switch self {
        case .alternatingCurrent: return 0x00
        case .directCurrent: return 0x01
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
        case 0x00: self = .alternatingCurrent
        case 0x01: self = .directCurrent
        default: return nil
        }
    }
}
