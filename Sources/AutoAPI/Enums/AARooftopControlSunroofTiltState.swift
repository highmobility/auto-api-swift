import Foundation
import HMUtilities

/// Sunroof tilt state enum.
public enum AARooftopControlSunroofTiltState: String, CaseIterable, Codable, HMBytesConvertable {
    case closed
    case halfTilted
    case tilted

    public var byteValue: UInt8 {
        switch self {
        case .closed: return 0x00
        case .tilted: return 0x01
        case .halfTilted: return 0x02
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
        case 0x00: self = .closed
        case 0x01: self = .tilted
        case 0x02: self = .halfTilted
        default: return nil
        }
    }
}
