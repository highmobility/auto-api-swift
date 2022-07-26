import Foundation
import HMUtilities

extension Collection where Element == AAOpaqueProperty {
    func property<R, P>(id: R) -> AAProperty<P>? where P: HMBytesConvertable, R: RawRepresentable, R.RawValue == UInt8 {
        first { $0.id == id.rawValue }?.property()
    }

    func properties<R, P>(id: R) -> [AAProperty<P>]? where P: HMBytesConvertable, R: RawRepresentable, R.RawValue == UInt8 {
        let properties: [AAProperty<P>] = filter { $0.id == id.rawValue }.compactMap { $0.property() }

        return properties.isEmpty ? nil : properties
    }
}

extension Collection where Element == AAPropertyComponent {
    func first(type: AAPropertyComponentType) -> AAPropertyComponent? {
        first { $0.type == type }
    }
}
