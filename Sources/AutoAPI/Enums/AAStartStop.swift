import Foundation
import HMUtilities

/// Start-Stop enum.
public enum AAStartStop: String, CaseIterable, Codable, HMBytesConvertable {
    case start
    case stop

    public var byteValue: UInt8 {
        switch self {
        case .start: return 0x00
        case .stop: return 0x01
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
        case 0x00: self = .start
        case 0x01: self = .stop
        default: return nil
        }
    }
}
