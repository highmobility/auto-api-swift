import Foundation
import HMUtilities

/// Vehicle overspeed enum.
public enum AATachographVehicleOverspeed: String, CaseIterable, Codable, HMBytesConvertable {
    case noOverspeed
    case overspeed

    public var byteValue: UInt8 {
        switch self {
        case .noOverspeed: return 0x00
        case .overspeed: return 0x01
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
        case 0x00: self = .noOverspeed
        case 0x01: self = .overspeed
        default: return nil
        }
    }
}
