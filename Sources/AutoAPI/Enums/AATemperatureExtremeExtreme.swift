import Foundation
import HMUtilities

/// Extreme enum.
public enum AATemperatureExtremeExtreme: String, CaseIterable, Codable, HMBytesConvertable {
    case highest
    case lowest

    public var byteValue: UInt8 {
        switch self {
        case .highest: return 0x00
        case .lowest: return 0x01
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
        case 0x00: self = .highest
        case 0x01: self = .lowest
        default: return nil
        }
    }
}
