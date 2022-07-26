import Foundation
import HMUtilities

/// Windscreen damage enum.
public enum AAWindscreenWindscreenDamage: String, CaseIterable, Codable, HMBytesConvertable {
    case damageLargerThan1Inch
    case damageSmallerThan1Inch
    case impactButNoDamageDetected
    case noImpactDetected

    public var byteValue: UInt8 {
        switch self {
        case .noImpactDetected: return 0x00
        case .impactButNoDamageDetected: return 0x01
        case .damageSmallerThan1Inch: return 0x02
        case .damageLargerThan1Inch: return 0x03
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
        case 0x00: self = .noImpactDetected
        case 0x01: self = .impactButNoDamageDetected
        case 0x02: self = .damageSmallerThan1Inch
        case 0x03: self = .damageLargerThan1Inch
        default: return nil
        }
    }
}
