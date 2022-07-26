import Foundation
import HMUtilities

/// Type of road travelled on..
public enum AATripsRoadType: String, CaseIterable, Codable, HMBytesConvertable {
    case country
    case county
    case federalHighway
    case highway
    case local
    case national
    case privateOrGravel
    case rural

    public var byteValue: UInt8 {
        switch self {
        case .privateOrGravel: return 0x00
        case .local: return 0x01
        case .county: return 0x02
        case .rural: return 0x03
        case .federalHighway: return 0x04
        case .highway: return 0x05
        case .country: return 0x06
        case .national: return 0x07
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
        case 0x00: self = .privateOrGravel
        case 0x01: self = .local
        case 0x02: self = .county
        case 0x03: self = .rural
        case 0x04: self = .federalHighway
        case 0x05: self = .highway
        case 0x06: self = .country
        case 0x07: self = .national
        default: return nil
        }
    }
}
