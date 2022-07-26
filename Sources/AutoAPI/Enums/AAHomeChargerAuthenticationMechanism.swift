import Foundation
import HMUtilities

/// Authentication mechanism enum.
public enum AAHomeChargerAuthenticationMechanism: String, CaseIterable, Codable, HMBytesConvertable {
    case app
    case pin

    public var byteValue: UInt8 {
        switch self {
        case .pin: return 0x00
        case .app: return 0x01
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
        case 0x00: self = .pin
        case 0x01: self = .app
        default: return nil
        }
    }
}
