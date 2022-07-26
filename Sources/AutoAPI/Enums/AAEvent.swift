import Foundation
import HMUtilities

/// Triggered event.
public enum AAEvent: String, CaseIterable, Codable, HMBytesConvertable {
    case accidentReported
    case authorizationChanged
    case batteryGuardWarning
    case breakdownReported
    case dashboardLightsChanged
    case emergencyReported
    case engineChanged
    case fleetClearanceChanged
    case ignitionChanged
    case maintenanceChanged
    case ping
    case seatBeltTriggered
    case tirePressureChanged
    case tripEnded
    case tripStarted
    case vehicleLocationChanged

    public var byteValue: UInt8 {
        switch self {
        case .ping: return 0x00
        case .tripStarted: return 0x01
        case .tripEnded: return 0x02
        case .vehicleLocationChanged: return 0x03
        case .authorizationChanged: return 0x04
        case .tirePressureChanged: return 0x05
        case .seatBeltTriggered: return 0x0a
        case .maintenanceChanged: return 0x0b
        case .dashboardLightsChanged: return 0x0c
        case .ignitionChanged: return 0x0d
        case .accidentReported: return 0x0e
        case .emergencyReported: return 0x0f
        case .breakdownReported: return 0x10
        case .batteryGuardWarning: return 0x11
        case .engineChanged: return 0x12
        case .fleetClearanceChanged: return 0x13
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
        case 0x00: self = .ping
        case 0x01: self = .tripStarted
        case 0x02: self = .tripEnded
        case 0x03: self = .vehicleLocationChanged
        case 0x04: self = .authorizationChanged
        case 0x05: self = .tirePressureChanged
        case 0x0a: self = .seatBeltTriggered
        case 0x0b: self = .maintenanceChanged
        case 0x0c: self = .dashboardLightsChanged
        case 0x0d: self = .ignitionChanged
        case 0x0e: self = .accidentReported
        case 0x0f: self = .emergencyReported
        case 0x10: self = .breakdownReported
        case 0x11: self = .batteryGuardWarning
        case 0x12: self = .engineChanged
        case 0x13: self = .fleetClearanceChanged
        default: return nil
        }
    }
}
