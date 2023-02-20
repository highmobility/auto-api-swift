import Foundation
import HMUtilities

/// Driving mode PHEV enum.
public enum AADrivingModePHEV: String, CaseIterable, Codable, HMBytesConvertable {
    case fullElectric
    case hybridParallel
    case hybridSerial
    case inCharge
    case notInTraction
    case thermic

    public var byteValue: UInt8 {
        switch self {
        case .notInTraction: return 0x00
        case .inCharge: return 0x01
        case .fullElectric: return 0x02
        case .hybridSerial: return 0x03
        case .thermic: return 0x04
        case .hybridParallel: return 0x05
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
        case 0x00: self = .notInTraction
        case 0x01: self = .inCharge
        case 0x02: self = .fullElectric
        case 0x03: self = .hybridSerial
        case 0x04: self = .thermic
        case 0x05: self = .hybridParallel
        default: return nil
        }
    }
}
