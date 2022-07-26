import Foundation
import HMUtilities

/// Location longitudinal enum.
public enum AALocationLongitudinal: String, CaseIterable, Codable, HMBytesConvertable {
    case front
    case rear

    public var byteValue: UInt8 {
        switch self {
        case .front: return 0x00
        case .rear: return 0x01
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
        case 0x00: self = .front
        case 0x01: self = .rear
        default: return nil
        }
    }
}
