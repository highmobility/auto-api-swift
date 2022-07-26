import Foundation
import HMUtilities

/// Convertible roof state enum.
public enum AARooftopControlConvertibleRoofState: String, CaseIterable, Codable, HMBytesConvertable {
    case closed
    case closedSecured
    case emergencyLocked
    case hardTopMounted
    case intermediatePosition
    case loadingPosition
    case loadingPositionImmediate
    case open
    case openSecured

    public var byteValue: UInt8 {
        switch self {
        case .closed: return 0x00
        case .open: return 0x01
        case .emergencyLocked: return 0x02
        case .closedSecured: return 0x03
        case .openSecured: return 0x04
        case .hardTopMounted: return 0x05
        case .intermediatePosition: return 0x06
        case .loadingPosition: return 0x07
        case .loadingPositionImmediate: return 0x08
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
        case 0x01: self = .open
        case 0x02: self = .emergencyLocked
        case 0x03: self = .closedSecured
        case 0x04: self = .openSecured
        case 0x05: self = .hardTopMounted
        case 0x06: self = .intermediatePosition
        case 0x07: self = .loadingPosition
        case 0x08: self = .loadingPositionImmediate
        default: return nil
        }
    }
}
