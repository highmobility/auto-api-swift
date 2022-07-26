import Foundation
import HMUtilities

/// Acoustic limitation of charging process..
public enum AAChargingAcousticLimit: String, CaseIterable, Codable, HMBytesConvertable {
    case automatic
    case limited
    case noAction
    case unlimited

    public var byteValue: UInt8 {
        switch self {
        case .noAction: return 0x00
        case .automatic: return 0x01
        case .unlimited: return 0x02
        case .limited: return 0x03
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
        case 0x00: self = .noAction
        case 0x01: self = .automatic
        case 0x02: self = .unlimited
        case 0x03: self = .limited
        default: return nil
        }
    }
}
