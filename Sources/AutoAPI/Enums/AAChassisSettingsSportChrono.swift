import Foundation
import HMUtilities

/// Sport chrono enum.
public enum AAChassisSettingsSportChrono: String, CaseIterable, Codable, HMBytesConvertable {
    case active
    case inactive
    case reset

    public var byteValue: UInt8 {
        switch self {
        case .inactive: return 0x00
        case .active: return 0x01
        case .reset: return 0x02
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
        case 0x01: self = .active
        case 0x02: self = .reset
        default: return nil
        }
    }
}
