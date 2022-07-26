import Foundation
import HMUtilities

/// Display unit enum.
public enum AAVehicleInformationDisplayUnit: String, CaseIterable, Codable, HMBytesConvertable {
    case km
    case miles

    public var byteValue: UInt8 {
        switch self {
        case .km: return 0x00
        case .miles: return 0x01
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
        case 0x00: self = .km
        case 0x01: self = .miles
        default: return nil
        }
    }
}
