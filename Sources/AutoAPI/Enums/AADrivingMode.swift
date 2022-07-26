import Foundation
import HMUtilities

/// Driving mode enum.
public enum AADrivingMode: String, CaseIterable, Codable, HMBytesConvertable {
    case comfort
    case eco
    case ecoPlus
    case regular
    case sport
    case sportPlus

    public var byteValue: UInt8 {
        switch self {
        case .regular: return 0x00
        case .eco: return 0x01
        case .sport: return 0x02
        case .sportPlus: return 0x03
        case .ecoPlus: return 0x04
        case .comfort: return 0x05
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
        case 0x00: self = .regular
        case 0x01: self = .eco
        case 0x02: self = .sport
        case 0x03: self = .sportPlus
        case 0x04: self = .ecoPlus
        case 0x05: self = .comfort
        default: return nil
        }
    }
}
