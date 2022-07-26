import Foundation
import HMUtilities

protocol AAPropertyIdentifying {
    associatedtype PropertyIdentifier: RawRepresentable where PropertyIdentifier.RawValue == UInt8
}

extension AAPropertyIdentifying where Self: AACapability {
    func extract<P>(property id: PropertyIdentifier) -> AAProperty<P>? where P: HMBytesConvertable {
        properties.first { $0.id == id.rawValue }?.property()
    }

    func extract<P>(properties id: PropertyIdentifier) -> [AAProperty<P>]? where P: HMBytesConvertable {
        let properties: [AAProperty<P>] = self.properties.filter { $0.id == id.rawValue }.compactMap { $0.property() }

        return properties.isEmpty ? nil : properties
    }
}
