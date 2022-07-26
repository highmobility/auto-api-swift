import Foundation
import HMUtilities

/// Charging status enum.
public enum AAHomeChargerChargingStatus: String, CaseIterable, Codable, HMBytesConvertable {
    case charging
    case disconnected
    case pluggedIn

    public var byteValue: UInt8 {
        switch self {
        case .disconnected: return 0x00
        case .pluggedIn: return 0x01
        case .charging: return 0x02
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
        case 0x01: self = .pluggedIn
        case 0x02: self = .charging
        default: return nil
        }
    }
}
