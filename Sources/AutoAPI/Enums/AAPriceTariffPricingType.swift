import Foundation
import HMUtilities

/// PricingType enum.
public enum AAPriceTariffPricingType: String, CaseIterable, Codable, HMBytesConvertable {
    case perKwh
    case perMinute
    case startingFee

    public var byteValue: UInt8 {
        switch self {
        case .startingFee: return 0x00
        case .perMinute: return 0x01
        case .perKwh: return 0x02
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
        case 0x00: self = .startingFee
        case 0x01: self = .perMinute
        case 0x02: self = .perKwh
        default: return nil
        }
    }
}
