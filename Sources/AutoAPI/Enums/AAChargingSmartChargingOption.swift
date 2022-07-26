import Foundation
import HMUtilities

/// Smart charging option being used to charge with..
public enum AAChargingSmartChargingOption: String, CaseIterable, Codable, HMBytesConvertable {
    case co2Optimized
    case priceOptimized
    case renewableEnergy

    public var byteValue: UInt8 {
        switch self {
        case .priceOptimized: return 0x00
        case .renewableEnergy: return 0x01
        case .co2Optimized: return 0x02
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
        case 0x00: self = .priceOptimized
        case 0x01: self = .renewableEnergy
        case 0x02: self = .co2Optimized
        default: return nil
        }
    }
}
