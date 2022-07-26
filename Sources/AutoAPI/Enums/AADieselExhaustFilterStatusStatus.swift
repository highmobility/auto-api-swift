import Foundation
import HMUtilities

/// Status enum.
public enum AADieselExhaustFilterStatusStatus: String, CaseIterable, Codable, HMBytesConvertable {
    case atLimit
    case normalOperation
    case overLimit
    case overloaded
    case unknown

    public var byteValue: UInt8 {
        switch self {
        case .unknown: return 0x00
        case .normalOperation: return 0x01
        case .overloaded: return 0x02
        case .atLimit: return 0x03
        case .overLimit: return 0x04
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
        case 0x00: self = .unknown
        case 0x01: self = .normalOperation
        case 0x02: self = .overloaded
        case 0x03: self = .atLimit
        case 0x04: self = .overLimit
        default: return nil
        }
    }
}
