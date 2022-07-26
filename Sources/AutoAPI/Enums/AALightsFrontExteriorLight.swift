import Foundation
import HMUtilities

/// Front exterior light enum.
public enum AALightsFrontExteriorLight: String, CaseIterable, Codable, HMBytesConvertable {
    case active
    case activeWithFullBeam
    case automatic
    case drl
    case inactive

    public var byteValue: UInt8 {
        switch self {
        case .inactive: return 0x00
        case .active: return 0x01
        case .activeWithFullBeam: return 0x02
        case .drl: return 0x03
        case .automatic: return 0x04
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
        case 0x00: self = .inactive
        case 0x01: self = .active
        case 0x02: self = .activeWithFullBeam
        case 0x03: self = .drl
        case 0x04: self = .automatic
        default: return nil
        }
    }
}
