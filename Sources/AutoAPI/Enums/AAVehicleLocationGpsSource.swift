import Foundation
import HMUtilities

/// Type of GPS source.
public enum AAVehicleLocationGpsSource: String, CaseIterable, Codable, HMBytesConvertable {
    case deadReckoning
    case none
    case real

    public var byteValue: UInt8 {
        switch self {
        case .deadReckoning: return 0x00
        case .real: return 0x01
        case .none: return 0x02
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
        case 0x00: self = .deadReckoning
        case 0x01: self = .real
        case 0x02: self = .none
        default: return nil
        }
    }
}
