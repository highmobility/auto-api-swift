import Foundation
import HMUtilities

/// Engine type enum.
public enum AAEngineType: String, CaseIterable, Codable, HMBytesConvertable {
    case allElectric
    case cng
    case combustionEngine
    case diesel
    case electric
    case gas
    case gasoline
    case hybrid
    case hydrogen
    case hydrogenHybrid
    case lpg
    case petrol
    case phev
    case unknown

    public var byteValue: UInt8 {
        switch self {
        case .unknown: return 0x00
        case .allElectric: return 0x01
        case .combustionEngine: return 0x02
        case .phev: return 0x03
        case .hydrogen: return 0x04
        case .hydrogenHybrid: return 0x05
        case .petrol: return 0x06
        case .electric: return 0x07
        case .gas: return 0x08
        case .diesel: return 0x09
        case .gasoline: return 0x0a
        case .cng: return 0x0b
        case .lpg: return 0x0c
        case .hybrid: return 0x0d
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
        case 0x01: self = .allElectric
        case 0x02: self = .combustionEngine
        case 0x03: self = .phev
        case 0x04: self = .hydrogen
        case 0x05: self = .hydrogenHybrid
        case 0x06: self = .petrol
        case 0x07: self = .electric
        case 0x08: self = .gas
        case 0x09: self = .diesel
        case 0x0a: self = .gasoline
        case 0x0b: self = .cng
        case 0x0c: self = .lpg
        case 0x0d: self = .hybrid
        default: return nil
        }
    }
}
