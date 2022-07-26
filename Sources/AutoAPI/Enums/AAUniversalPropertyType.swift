import Foundation

public enum AAUniversalPropertyType: UInt8, CaseIterable {
    case nonce = 0xa0
    case vehicleSignature = 0xa1
    case timestamp = 0xa2
    case vin = 0xa3
    case brand = 0xa4
}
