import Foundation
import HMUtilities

/// Status of optimized/intelligent charging.
public enum AAChargingSmartChargingStatus: String, CaseIterable, Codable, HMBytesConvertable {
    case peakSettingActive
    case sccIsActive
    case wallboxIsActive

    public var byteValue: UInt8 {
        switch self {
        case .wallboxIsActive: return 0x00
        case .sccIsActive: return 0x01
        case .peakSettingActive: return 0x02
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
        case 0x00: self = .wallboxIsActive
        case 0x01: self = .sccIsActive
        case 0x02: self = .peakSettingActive
        default: return nil
        }
    }
}
