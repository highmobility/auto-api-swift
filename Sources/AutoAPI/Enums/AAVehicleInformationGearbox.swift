import Foundation
import HMUtilities

/// Gearbox enum.
public enum AAVehicleInformationGearbox: String, CaseIterable, Codable, HMBytesConvertable {
    case automatic
    case manual
    case semiAutomatic

    public var byteValue: UInt8 {
        switch self {
        case .manual: return 0x00
        case .automatic: return 0x01
        case .semiAutomatic: return 0x02
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
        case 0x00: self = .manual
        case 0x01: self = .automatic
        case 0x02: self = .semiAutomatic
        default: return nil
        }
    }
}
