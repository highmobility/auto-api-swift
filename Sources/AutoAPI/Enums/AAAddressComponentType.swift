import Foundation
import HMUtilities

/// Component type.
public enum AAAddressComponentType: String, CaseIterable, Codable, HMBytesConvertable {
    case city
    case country
    case countryShort
    case district
    case other
    case postalCode
    case stateProvince
    case street

    public var byteValue: UInt8 {
        switch self {
        case .city: return 0x00
        case .country: return 0x01
        case .countryShort: return 0x02
        case .district: return 0x03
        case .postalCode: return 0x04
        case .street: return 0x05
        case .stateProvince: return 0x06
        case .other: return 0x07
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
        case 0x00: self = .city
        case 0x01: self = .country
        case 0x02: self = .countryShort
        case 0x03: self = .district
        case 0x04: self = .postalCode
        case 0x05: self = .street
        case 0x06: self = .stateProvince
        case 0x07: self = .other
        default: return nil
        }
    }
}
