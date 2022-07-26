import Foundation
import HMUtilities

/// Vehicle moving enum.
public enum AARaceVehicleMoving: String, CaseIterable, Codable, HMBytesConvertable {
    case moving
    case notMoving

    public var byteValue: UInt8 {
        switch self {
        case .notMoving: return 0x00
        case .moving: return 0x01
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
        case 0x00: self = .notMoving
        case 0x01: self = .moving
        default: return nil
        }
    }
}
