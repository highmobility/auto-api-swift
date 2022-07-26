import Foundation
import HMUtilities

/// FastenedState enum.
public enum AASeatbeltStateFastenedState: String, CaseIterable, Codable, HMBytesConvertable {
    case fastened
    case notFastened

    public var byteValue: UInt8 {
        switch self {
        case .notFastened: return 0x00
        case .fastened: return 0x01
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
        case 0x00: self = .notFastened
        case 0x01: self = .fastened
        default: return nil
        }
    }
}
