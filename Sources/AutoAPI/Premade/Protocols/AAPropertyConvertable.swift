import Foundation
import HMUtilities

protocol AAPropertyConvertable {
    func property<P, R>(id: R) -> AAProperty<P>? where P: HMBytesConvertable, R: RawRepresentable, R.RawValue == UInt8
}

extension AAPropertyConvertable where Self: HMBytesConvertable {
    func property<P, R>(id: R) -> AAProperty<P>? where P: HMBytesConvertable, R: RawRepresentable, R.RawValue == UInt8 {
        AAProperty(id: id, value: self as? P)
    }
}

extension Array where Element: HMBytesConvertable {
    func properties<P, R>(id: R) -> [AAProperty<P>] where P: HMBytesConvertable, R: RawRepresentable, R.RawValue == UInt8 {
        compactMap { AAProperty(id: id, value: $0 as? P) }
    }
}
