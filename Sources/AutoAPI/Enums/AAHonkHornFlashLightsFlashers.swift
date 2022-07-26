import Foundation
import HMUtilities

/// Flashers enum.
public enum AAHonkHornFlashLightsFlashers: String, CaseIterable, Codable, HMBytesConvertable {
    case emergencyFlasherActive
    case inactive
    case leftFlasherActive
    case rightFlasherActive

    public var byteValue: UInt8 {
        switch self {
        case .inactive: return 0x00
        case .emergencyFlasherActive: return 0x01
        case .leftFlasherActive: return 0x02
        case .rightFlasherActive: return 0x03
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
        case 0x00: self = .inactive
        case 0x01: self = .emergencyFlasherActive
        case 0x02: self = .leftFlasherActive
        case 0x03: self = .rightFlasherActive
        default: return nil
        }
    }
}
