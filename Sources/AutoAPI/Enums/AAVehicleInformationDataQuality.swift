import Foundation
import HMUtilities

/// Evaluation of the timeliness of the available vehicle data..
public enum AAVehicleInformationDataQuality: String, CaseIterable, Codable, HMBytesConvertable {
    case almostUpToDate
    case noData
    case outOfDate
    case upToDate

    public var byteValue: UInt8 {
        switch self {
        case .noData: return 0x00
        case .upToDate: return 0x01
        case .almostUpToDate: return 0x02
        case .outOfDate: return 0x03
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
        case 0x00: self = .noData
        case 0x01: self = .upToDate
        case 0x02: self = .almostUpToDate
        case 0x03: self = .outOfDate
        default: return nil
        }
    }
}
