import Foundation
import HMUtilities

/// Network security enum.
public enum AANetworkSecurity: String, CaseIterable, Codable, HMBytesConvertable {
    case none
    case wep
    case wpa
    case wpa2Personal

    public var byteValue: UInt8 {
        switch self {
        case .none: return 0x00
        case .wep: return 0x01
        case .wpa: return 0x02
        case .wpa2Personal: return 0x03
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
        case 0x00: self = .none
        case 0x01: self = .wep
        case 0x02: self = .wpa
        case 0x03: self = .wpa2Personal
        default: return nil
        }
    }
}
