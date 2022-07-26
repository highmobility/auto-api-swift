import Foundation
import HMUtilities

/// This value includes the information, if the fuel level has been calculated or measured..
public enum AADiagnosticsFuelLevelAccuracy: String, CaseIterable, Codable, HMBytesConvertable {
    case calculated
    case measured

    public var byteValue: UInt8 {
        switch self {
        case .measured: return 0x00
        case .calculated: return 0x01
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
        case 0x00: self = .measured
        case 0x01: self = .calculated
        default: return nil
        }
    }
}
