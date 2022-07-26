import Foundation
import HMUtilities

struct AAPropertyComponent: Encodable, HMBytesConvertable {
    let type: AAPropertyComponentType

    var value: [UInt8] {
        bytes.suffix(from: 3).bytes
    }

    init(type: AAPropertyComponentType, value: [UInt8]) {
        self.bytes = type.bytes + value.sizeBytes(amount: 2) + value
        self.type = type
    }

    // MARK: HMBytesConvertable
    let bytes: [UInt8]

    init?(bytes: [UInt8]) {
        guard bytes.count >= 3 else {
            return nil
        }

        let size = 3 + Int(UInt16(bytes: bytes[1...2])!)

        guard bytes.count >= size,
            let type = AAPropertyComponentType(rawValue: bytes[0]) else {
                return nil
        }

        self.bytes = bytes.prefix(upTo: size).bytes
        self.type = type
    }
}
