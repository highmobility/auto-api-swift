import Foundation
import HMUtilities

/// Direction enum.
public enum AAAccelerationDurationDirection: String, CaseIterable, Codable, HMBytesConvertable {
    case lateral
    case longitudinal

    public var byteValue: UInt8 {
        switch self {
        case .longitudinal: return 0x00
        case .lateral: return 0x01
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
        case 0x00: self = .longitudinal
        case 0x01: self = .lateral
        default: return nil
        }
    }
}
