import Foundation
import HMUtilities

/// Vehicle direction enum.
public enum AATachographVehicleDirection: String, CaseIterable, Codable, HMBytesConvertable {
    case forward
    case reverse

    public var byteValue: UInt8 {
        switch self {
        case .forward: return 0x00
        case .reverse: return 0x01
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
        case 0x00: self = .forward
        case 0x01: self = .reverse
        default: return nil
        }
    }
}
