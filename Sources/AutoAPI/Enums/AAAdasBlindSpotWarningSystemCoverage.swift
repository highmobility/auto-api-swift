import Foundation
import HMUtilities

/// Blind spot warning system coverage..
public enum AAAdasBlindSpotWarningSystemCoverage: String, CaseIterable, Codable, HMBytesConvertable {
    case regular
    case trailer

    public var byteValue: UInt8 {
        switch self {
        case .regular: return 0x00
        case .trailer: return 0x01
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
        case 0x01: self = .trailer
        default: return nil
        }
    }
}
