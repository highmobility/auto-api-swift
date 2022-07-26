import Foundation
import HMUtilities

/// The timeformat on headunit.
public enum AAVehicleInformationTimeformat: String, CaseIterable, Codable, HMBytesConvertable {
    case twelveH
    case twentyFourH

    public var byteValue: UInt8 {
        switch self {
        case .twelveH: return 0x00
        case .twentyFourH: return 0x01
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
        case 0x00: self = .twelveH
        case 0x01: self = .twentyFourH
        default: return nil
        }
    }
}
