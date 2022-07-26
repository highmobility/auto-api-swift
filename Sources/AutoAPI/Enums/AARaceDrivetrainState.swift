import Foundation
import HMUtilities

/// State of the drivetrain for starts..
public enum AARaceDrivetrainState: String, CaseIterable, Codable, HMBytesConvertable {
    case comfortStart
    case eLaunch
    case inactive
    case lowSpeedMode
    case raceStart
    case raceStartPreparation
    case readyForOverpressing
    case start
    case startIdleRunControl

    public var byteValue: UInt8 {
        switch self {
        case .inactive: return 0x00
        case .raceStartPreparation: return 0x01
        case .raceStart: return 0x02
        case .start: return 0x03
        case .comfortStart: return 0x04
        case .startIdleRunControl: return 0x05
        case .readyForOverpressing: return 0x06
        case .lowSpeedMode: return 0x07
        case .eLaunch: return 0x08
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
        case 0x01: self = .raceStartPreparation
        case 0x02: self = .raceStart
        case 0x03: self = .start
        case 0x04: self = .comfortStart
        case 0x05: self = .startIdleRunControl
        case 0x06: self = .readyForOverpressing
        case 0x07: self = .lowSpeedMode
        case 0x08: self = .eLaunch
        default: return nil
        }
    }
}
