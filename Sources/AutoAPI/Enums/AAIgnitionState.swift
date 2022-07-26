import Foundation
import HMUtilities

/// Ignition state enum.
public enum AAIgnitionState: String, CaseIterable, Codable, HMBytesConvertable {
    case accessory
    case lock
    case off
    case on
    case start

    public var byteValue: UInt8 {
        switch self {
        case .lock: return 0x00
        case .off: return 0x01
        case .accessory: return 0x02
        case .on: return 0x03
        case .start: return 0x04
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
        case 0x00: self = .lock
        case 0x01: self = .off
        case 0x02: self = .accessory
        case 0x03: self = .on
        case 0x04: self = .start
        default: return nil
        }
    }
}
