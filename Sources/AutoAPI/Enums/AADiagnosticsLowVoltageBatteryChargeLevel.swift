import Foundation
import HMUtilities

/// Indicates if the charge level of the low voltage battery is too low to use other systems.
public enum AADiagnosticsLowVoltageBatteryChargeLevel: String, CaseIterable, Codable, HMBytesConvertable {
    case deactivationLevel1
    case deactivationLevel2
    case deactivationLevel3
    case ok

    public var byteValue: UInt8 {
        switch self {
        case .ok: return 0x00
        case .deactivationLevel1: return 0x01
        case .deactivationLevel2: return 0x02
        case .deactivationLevel3: return 0x03
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
        case 0x00: self = .ok
        case 0x01: self = .deactivationLevel1
        case 0x02: self = .deactivationLevel2
        case 0x03: self = .deactivationLevel3
        default: return nil
        }
    }
}
