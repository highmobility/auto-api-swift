import Foundation
import HMUtilities

/// The vehicle brand.
public enum AABrand: String, CaseIterable, Codable, HMBytesConvertable {
    case abarth
    case alfaromeo
    case alpine
    case audi
    case bmw
    case cadillac
    case chevrolet
    case chrysler
    case citroen
    case cupra
    case dacia
    case dodge
    case ds
    case fiat
    case ford
    case honda
    case hyundai
    case iveco
    case jaguar
    case jeep
    case kia
    case lancia
    case landRover
    case lexus
    case man
    case mazda
    case mercedesBenz
    case mini
    case mitsubishi
    case nissan
    case opel
    case peugeot
    case porsche
    case renault
    case sandbox
    case seat
    case skoda
    case smart
    case subaru
    case toyota
    case unknown
    case volkswagen
    case volvoCars

    public var byteValue: UInt8 {
        switch self {
        case .unknown: return 0x00
        case .abarth: return 0x01
        case .alfaromeo: return 0x02
        case .alpine: return 0x03
        case .audi: return 0x04
        case .bmw: return 0x05
        case .cadillac: return 0x06
        case .chevrolet: return 0x07
        case .chrysler: return 0x08
        case .citroen: return 0x09
        case .cupra: return 0x0a
        case .dacia: return 0x0b
        case .dodge: return 0x0c
        case .ds: return 0x0d
        case .fiat: return 0x0e
        case .ford: return 0x0f
        case .honda: return 0x10
        case .hyundai: return 0x11
        case .iveco: return 0x12
        case .jaguar: return 0x13
        case .jeep: return 0x14
        case .kia: return 0x15
        case .lancia: return 0x16
        case .landRover: return 0x17
        case .lexus: return 0x18
        case .man: return 0x19
        case .mazda: return 0x1a
        case .mercedesBenz: return 0x1b
        case .mini: return 0x1c
        case .mitsubishi: return 0x1d
        case .nissan: return 0x1e
        case .opel: return 0x1f
        case .peugeot: return 0x20
        case .porsche: return 0x21
        case .renault: return 0x22
        case .seat: return 0x23
        case .skoda: return 0x24
        case .smart: return 0x25
        case .subaru: return 0x26
        case .toyota: return 0x27
        case .volkswagen: return 0x28
        case .volvoCars: return 0x29
        case .sandbox: return 0x2a
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
        case 0x01: self = .abarth
        case 0x02: self = .alfaromeo
        case 0x03: self = .alpine
        case 0x04: self = .audi
        case 0x05: self = .bmw
        case 0x06: self = .cadillac
        case 0x07: self = .chevrolet
        case 0x08: self = .chrysler
        case 0x09: self = .citroen
        case 0x0a: self = .cupra
        case 0x0b: self = .dacia
        case 0x0c: self = .dodge
        case 0x0d: self = .ds
        case 0x0e: self = .fiat
        case 0x0f: self = .ford
        case 0x10: self = .honda
        case 0x11: self = .hyundai
        case 0x12: self = .iveco
        case 0x13: self = .jaguar
        case 0x14: self = .jeep
        case 0x15: self = .kia
        case 0x16: self = .lancia
        case 0x17: self = .landRover
        case 0x18: self = .lexus
        case 0x19: self = .man
        case 0x1a: self = .mazda
        case 0x1b: self = .mercedesBenz
        case 0x1c: self = .mini
        case 0x1d: self = .mitsubishi
        case 0x1e: self = .nissan
        case 0x1f: self = .opel
        case 0x20: self = .peugeot
        case 0x21: self = .porsche
        case 0x22: self = .renault
        case 0x23: self = .seat
        case 0x24: self = .skoda
        case 0x25: self = .smart
        case 0x26: self = .subaru
        case 0x27: self = .toyota
        case 0x28: self = .volkswagen
        case 0x29: self = .volvoCars
        case 0x2a: self = .sandbox
        default: return nil
        }
    }
}
