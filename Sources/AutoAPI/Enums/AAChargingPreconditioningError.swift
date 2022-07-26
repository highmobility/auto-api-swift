import Foundation
import HMUtilities

/// Preconditioning error if one is encountered.
public enum AAChargingPreconditioningError: String, CaseIterable, Codable, HMBytesConvertable {
    case availableAfterEngineRestart
    case generalError
    case noChange
    case notPossibleFinished
    case notPossibleLow

    public var byteValue: UInt8 {
        switch self {
        case .noChange: return 0x00
        case .notPossibleLow: return 0x01
        case .notPossibleFinished: return 0x02
        case .availableAfterEngineRestart: return 0x03
        case .generalError: return 0x04
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
        case 0x00: self = .noChange
        case 0x01: self = .notPossibleLow
        case 0x02: self = .notPossibleFinished
        case 0x03: self = .availableAfterEngineRestart
        case 0x04: self = .generalError
        default: return nil
        }
    }
}
