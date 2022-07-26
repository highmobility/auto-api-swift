import Foundation
import HMUtilities

extension Array where Element == UInt8 {
    func extract(bytesFrom idx: Int) -> [UInt8]? {
        guard count >= (idx + 1) else {
            return nil
        }

        // UInt16 initialiser can't create an invalid value with 2 bytes
        let size = Int(UInt16(bytes: self[idx ... (idx + 1)].bytes)!)

        guard count >= (idx + 2 + size) else {
            return nil
        }

        return self[(idx + 2) ..< (idx + 2 + size)].bytes
    }

    func extract(stringFrom idx: Int) -> String? {
        guard let bytes = extract(bytesFrom: idx) else {
            return nil
        }

        return String(bytes: bytes)
    }

    func generateProperties() -> [AAOpaqueProperty] {
        var bytes = self
        var properties: [AAOpaqueProperty] = []

        while let property = AAOpaqueProperty(bytes: bytes) {
            bytes.removeFirst(property.bytes.count)
            properties.append(property)
        }

        return properties
    }

    func generatePropertyComponents() -> [AAPropertyComponent] {
        var bytes = self
        var components: [AAPropertyComponent] = []

        while let component = AAPropertyComponent(bytes: bytes) {
            bytes.removeFirst(component.bytes.count)
            components.append(component)
        }

        return components
    }

    func sizeBytes(amount: Int) -> [UInt8] {
        (0..<amount).map {
            (self.count >> ($0 * 8)).uint8
        }.reversed()
    }
}

extension Array: HMBytesConvertable where Element == UInt8 {
    public var bytes: [UInt8] {
        flatMap(\.bytes)
    }

    public init?(bytes: [UInt8]) {
        self = Array(bytes)
    }
}
