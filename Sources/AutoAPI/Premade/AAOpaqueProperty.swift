import Foundation
import HMUtilities

public class AAOpaqueProperty: Encodable, HMBytesConvertable {
    let components: [AAPropertyComponent]

    public var id: UInt8 {
        bytes[0]
    }

    public var valueBytes: [UInt8]? {
        components.first(type: .data)?.value
    }

    func property<P>() -> AAProperty<P>? where P: HMBytesConvertable {
        AAProperty(id: id, value: P(bytes: valueBytes), components: components)
    }

    init(id: UInt8, components: [AAPropertyComponent]) {
        let componentBytes = components.flatMap { $0.bytes }

        self.bytes = id.bytes + componentBytes.sizeBytes(amount: 2) + componentBytes
        self.components = components
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]

    public required init?(bytes: [UInt8]) {
        guard bytes.count >= 3 else {
            return nil
        }

        let size = 3 + Int(UInt16(bytes: bytes[1...2])!)

        guard bytes.count >= size else {
            return nil
        }

        self.bytes = bytes.prefix(size).bytes
        self.components = self.bytes.suffix(from: 3).bytes.generatePropertyComponents()
    }
}
