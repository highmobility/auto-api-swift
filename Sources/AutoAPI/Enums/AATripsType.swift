import Foundation
import HMUtilities

/// Type of the trip.
public enum AATripsType: String, CaseIterable, Codable, HMBytesConvertable {
    case eco
    case multi
    case single

    public var byteValue: UInt8 {
        switch self {
        case .single: return 0x00
        case .multi: return 0x01
        case .eco: return 0x02
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
        case 0x00: self = .single
        case 0x01: self = .multi
        case 0x02: self = .eco
        default: return nil
        }
    }
}
