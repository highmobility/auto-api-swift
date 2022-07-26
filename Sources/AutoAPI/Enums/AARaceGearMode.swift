import Foundation
import HMUtilities

/// Gear mode enum.
public enum AARaceGearMode: String, CaseIterable, Codable, HMBytesConvertable {
    case drive
    case lowGear
    case manual
    case neutral
    case park
    case reverse
    case sport

    public var byteValue: UInt8 {
        switch self {
        case .manual: return 0x00
        case .park: return 0x01
        case .reverse: return 0x02
        case .neutral: return 0x03
        case .drive: return 0x04
        case .lowGear: return 0x05
        case .sport: return 0x06
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
        case 0x00: self = .manual
        case 0x01: self = .park
        case 0x02: self = .reverse
        case 0x03: self = .neutral
        case 0x04: self = .drive
        case 0x05: self = .lowGear
        case 0x06: self = .sport
        default: return nil
        }
    }
}
