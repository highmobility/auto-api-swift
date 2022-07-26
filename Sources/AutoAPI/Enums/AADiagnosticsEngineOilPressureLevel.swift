import Foundation
import HMUtilities

/// Engine oil pressure level.
public enum AADiagnosticsEngineOilPressureLevel: String, CaseIterable, Codable, HMBytesConvertable {
    case high
    case low
    case lowHard
    case lowSoft
    case noSensor
    case normal
    case systemFault

    public var byteValue: UInt8 {
        switch self {
        case .low: return 0x00
        case .normal: return 0x01
        case .high: return 0x02
        case .lowSoft: return 0x03
        case .lowHard: return 0x04
        case .noSensor: return 0x05
        case .systemFault: return 0x06
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
        case 0x00: self = .low
        case 0x01: self = .normal
        case 0x02: self = .high
        case 0x03: self = .lowSoft
        case 0x04: self = .lowHard
        case 0x05: self = .noSensor
        case 0x06: self = .systemFault
        default: return nil
        }
    }
}
