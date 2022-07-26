import Foundation
import HMUtilities

/// Charging window chosen enum.
public enum AAChargingChargingWindowChosen: String, CaseIterable, Codable, HMBytesConvertable {
    case chosen
    case notChosen

    public var byteValue: UInt8 {
        switch self {
        case .notChosen: return 0x00
        case .chosen: return 0x01
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
        case 0x00: self = .notChosen
        case 0x01: self = .chosen
        default: return nil
        }
    }
}
