import Foundation
import HMUtilities

/// Update rate enum.
public enum AAAvailabilityUpdateRate: String, CaseIterable, Codable, HMBytesConvertable {
    case notAvailable
    case onChange
    case trip
    case tripEnd
    case tripHigh
    case tripStartEnd
    case unknown

    public var byteValue: UInt8 {
        switch self {
        case .tripHigh: return 0x00
        case .trip: return 0x01
        case .tripStartEnd: return 0x02
        case .tripEnd: return 0x03
        case .unknown: return 0x04
        case .notAvailable: return 0x05
        case .onChange: return 0x06
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
        case 0x00: self = .tripHigh
        case 0x01: self = .trip
        case 0x02: self = .tripStartEnd
        case 0x03: self = .tripEnd
        case 0x04: self = .unknown
        case 0x05: self = .notAvailable
        case 0x06: self = .onChange
        default: return nil
        }
    }
}
