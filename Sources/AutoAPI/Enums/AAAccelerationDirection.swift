import Foundation
import HMUtilities

/// Direction enum.
public enum AAAccelerationDirection: String, CaseIterable, Codable, HMBytesConvertable {
    case frontLateral
    case lateral
    case longitudinal
    case rearLateral

    public var byteValue: UInt8 {
        switch self {
        case .longitudinal: return 0x00
        case .lateral: return 0x01
        case .frontLateral: return 0x02
        case .rearLateral: return 0x03
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
        case 0x02: self = .frontLateral
        case 0x03: self = .rearLateral
        default: return nil
        }
    }
}
