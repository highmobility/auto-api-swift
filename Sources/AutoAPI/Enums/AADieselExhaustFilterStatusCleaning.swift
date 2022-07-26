import Foundation
import HMUtilities

/// Cleaning enum.
public enum AADieselExhaustFilterStatusCleaning: String, CaseIterable, Codable, HMBytesConvertable {
    case complete
    case inProgress
    case interrupted
    case unknown

    public var byteValue: UInt8 {
        switch self {
        case .unknown: return 0x00
        case .inProgress: return 0x01
        case .complete: return 0x02
        case .interrupted: return 0x03
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
        case 0x01: self = .inProgress
        case 0x02: self = .complete
        case 0x03: self = .interrupted
        default: return nil
        }
    }
}
