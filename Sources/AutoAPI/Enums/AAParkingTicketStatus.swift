import Foundation
import HMUtilities

/// Status enum.
public enum AAParkingTicketStatus: String, CaseIterable, Codable, HMBytesConvertable {
    case ended
    case started

    public var byteValue: UInt8 {
        switch self {
        case .ended: return 0x00
        case .started: return 0x01
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
        case 0x00: self = .ended
        case 0x01: self = .started
        default: return nil
        }
    }
}
