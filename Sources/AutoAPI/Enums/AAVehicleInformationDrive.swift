import Foundation
import HMUtilities

/// Wheels driven by the engine.
public enum AAVehicleInformationDrive: String, CaseIterable, Codable, HMBytesConvertable {
    case awd
    case fourWd
    case fwd
    case rwd

    public var byteValue: UInt8 {
        switch self {
        case .fwd: return 0x00
        case .rwd: return 0x01
        case .fourWd: return 0x02
        case .awd: return 0x03
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
        case 0x00: self = .fwd
        case 0x01: self = .rwd
        case 0x02: self = .fourWd
        case 0x03: self = .awd
        default: return nil
        }
    }
}
