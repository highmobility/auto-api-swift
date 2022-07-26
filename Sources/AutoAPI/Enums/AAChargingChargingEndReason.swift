import Foundation
import HMUtilities

/// Reason for ending a charging process..
public enum AAChargingChargingEndReason: String, CaseIterable, Codable, HMBytesConvertable {
    case chargingStationFailure
    case connectorRemoved
    case goalReached
    case hvSystemFailure
    case noParkingLock
    case parkingLockFailed
    case powergridFailed
    case requestedByDriver
    case signalInvalid
    case unknown

    public var byteValue: UInt8 {
        switch self {
        case .unknown: return 0x00
        case .goalReached: return 0x01
        case .requestedByDriver: return 0x02
        case .connectorRemoved: return 0x03
        case .powergridFailed: return 0x04
        case .hvSystemFailure: return 0x05
        case .chargingStationFailure: return 0x06
        case .parkingLockFailed: return 0x07
        case .noParkingLock: return 0x08
        case .signalInvalid: return 0x09
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
        case 0x00: self = .unknown
        case 0x01: self = .goalReached
        case 0x02: self = .requestedByDriver
        case 0x03: self = .connectorRemoved
        case 0x04: self = .powergridFailed
        case 0x05: self = .hvSystemFailure
        case 0x06: self = .chargingStationFailure
        case 0x07: self = .parkingLockFailed
        case 0x08: self = .noParkingLock
        case 0x09: self = .signalInvalid
        default: return nil
        }
    }
}
