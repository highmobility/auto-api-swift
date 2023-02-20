import Foundation
import HMUtilities

/// Battery charge type..
public enum AAChargingBatteryChargeType: String, CaseIterable, Codable, HMBytesConvertable {
    case accelerated
    case fast
    case noCharge
    case normal
    case notUsed
    case quick
    case ultraFast
    case vehicleToGrid
    case vehicleToHome

    public var byteValue: UInt8 {
        switch self {
        case .noCharge: return 0x00
        case .normal: return 0x01
        case .accelerated: return 0x02
        case .fast: return 0x03
        case .quick: return 0x04
        case .ultraFast: return 0x05
        case .notUsed: return 0x06
        case .vehicleToHome: return 0x07
        case .vehicleToGrid: return 0x08
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
        case 0x00: self = .noCharge
        case 0x01: self = .normal
        case 0x02: self = .accelerated
        case 0x03: self = .fast
        case 0x04: self = .quick
        case 0x05: self = .ultraFast
        case 0x06: self = .notUsed
        case 0x07: self = .vehicleToHome
        case 0x08: self = .vehicleToGrid
        default: return nil
        }
    }
}
