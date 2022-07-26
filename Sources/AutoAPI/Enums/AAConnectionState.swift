import Foundation
import HMUtilities

/// Connection state enum.
public enum AAConnectionState: String, CaseIterable, Codable, HMBytesConvertable {
    case connected
    case disconnected

    public var byteValue: UInt8 {
        switch self {
        case .disconnected: return 0x00
        case .connected: return 0x01
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
        case 0x00: self = .disconnected
        case 0x01: self = .connected
        default: return nil
        }
    }
}
