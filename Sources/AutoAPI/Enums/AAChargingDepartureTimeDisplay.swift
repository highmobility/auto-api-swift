import Foundation
import HMUtilities

/// Departure time displayed in the vehicle..
public enum AAChargingDepartureTimeDisplay: String, CaseIterable, Codable, HMBytesConvertable {
    case noDisplay
    case notReachable
    case reachable

    public var byteValue: UInt8 {
        switch self {
        case .noDisplay: return 0x00
        case .reachable: return 0x01
        case .notReachable: return 0x02
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
        case 0x00: self = .noDisplay
        case 0x01: self = .reachable
        case 0x02: self = .notReachable
        default: return nil
        }
    }
}
