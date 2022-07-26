import Foundation
import HMUtilities

/// Control mode enum.
public enum AARemoteControlControlMode: String, CaseIterable, Codable, HMBytesConvertable {
    case aborted
    case available
    case ended
    case failedToStart
    case started
    case unavailable

    public var byteValue: UInt8 {
        switch self {
        case .unavailable: return 0x00
        case .available: return 0x01
        case .started: return 0x02
        case .failedToStart: return 0x03
        case .aborted: return 0x04
        case .ended: return 0x05
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
        case 0x00: self = .unavailable
        case 0x01: self = .available
        case 0x02: self = .started
        case 0x03: self = .failedToStart
        case 0x04: self = .aborted
        case 0x05: self = .ended
        default: return nil
        }
    }
}
