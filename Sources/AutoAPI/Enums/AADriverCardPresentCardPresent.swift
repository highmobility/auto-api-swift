import Foundation
import HMUtilities

/// CardPresent enum.
public enum AADriverCardPresentCardPresent: String, CaseIterable, Codable, HMBytesConvertable {
    case notPresent
    case present

    public var byteValue: UInt8 {
        switch self {
        case .notPresent: return 0x00
        case .present: return 0x01
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
        case 0x00: self = .notPresent
        case 0x01: self = .present
        default: return nil
        }
    }
}
