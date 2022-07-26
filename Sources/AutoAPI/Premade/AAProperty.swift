import Foundation
import HMUtilities

public class AAProperty<ValueType>: AAOpaqueProperty where ValueType: HMBytesConvertable {
    public var opaque: AAOpaqueProperty {
        self as AAOpaqueProperty
    }

    public var value: ValueType? {
        ValueType(bytes: components.first(type: .data)?.value)
    }

    init?(id: UInt8, value: ValueType?, components: [AAPropertyComponent] = []) {
        if value == nil && components.isEmpty {
            return nil
        }

        var combinedComponents: [AAPropertyComponent] = []

        if let value = value {
            combinedComponents.append(AAPropertyComponent(type: .data, value: value.bytes))
        }

        combinedComponents += components.filter { $0.type != .data }

        super.init(id: id, components: combinedComponents)
    }

    // MARK: AAOpaqueProperty
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    }
}

extension AAProperty {
    convenience init?<R>(id: R, value: ValueType?, components: [AAPropertyComponent] = []) where R: RawRepresentable, R.RawValue == UInt8 {
        self.init(id: id.rawValue, value: value, components: components)
    }
}
