import Foundation
import HMUtilities

public enum AAPropertyComponentType: UInt8, CaseIterable, Encodable, HMBytesConvertable {
    case data = 0x01
    case timestamp = 0x02
    case failure = 0x03
    case availability = 0x05
}
