import Foundation
import HMUtilities

/// Component enum.
public enum AADieselExhaustFilterStatusComponent: String, CaseIterable, Codable, HMBytesConvertable {
    case dieselParticulateFilter
    case exhaustFilter
    case offBoardRegeneration
    case overboostCodeRegulator
    case unknown

    public var byteValue: UInt8 {
        switch self {
        case .unknown: return 0x00
        case .exhaustFilter: return 0x01
        case .dieselParticulateFilter: return 0x02
        case .overboostCodeRegulator: return 0x03
        case .offBoardRegeneration: return 0x04
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
        case 0x00: self = .unknown
        case 0x01: self = .exhaustFilter
        case 0x02: self = .dieselParticulateFilter
        case 0x03: self = .overboostCodeRegulator
        case 0x04: self = .offBoardRegeneration
        default: return nil
        }
    }
}
