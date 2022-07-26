import Foundation
import HMUtilities

/// Authentication state enum.
public enum AAHomeChargerAuthenticationState: String, CaseIterable, Codable, HMBytesConvertable {
    case authenticated
    case unauthenticated

    public var byteValue: UInt8 {
        switch self {
        case .unauthenticated: return 0x00
        case .authenticated: return 0x01
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
        case 0x00: self = .unauthenticated
        case 0x01: self = .authenticated
        default: return nil
        }
    }
}
