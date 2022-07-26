import Foundation
import HMUtilities

/// Location enum.
public enum AAKeyfobPositionLocation: String, CaseIterable, Codable, HMBytesConvertable {
    case insideCar
    case notInside
    case outOfRange
    case outsideBehindCar
    case outsideDriverSide
    case outsideInFrontOfCar
    case outsidePassengerSide

    public var byteValue: UInt8 {
        switch self {
        case .outOfRange: return 0x00
        case .outsideDriverSide: return 0x01
        case .outsideInFrontOfCar: return 0x02
        case .outsidePassengerSide: return 0x03
        case .outsideBehindCar: return 0x04
        case .insideCar: return 0x05
        case .notInside: return 0x06
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
        case 0x00: self = .outOfRange
        case 0x01: self = .outsideDriverSide
        case 0x02: self = .outsideInFrontOfCar
        case 0x03: self = .outsidePassengerSide
        case 0x04: self = .outsideBehindCar
        case 0x05: self = .insideCar
        case 0x06: self = .notInside
        default: return nil
        }
    }
}
