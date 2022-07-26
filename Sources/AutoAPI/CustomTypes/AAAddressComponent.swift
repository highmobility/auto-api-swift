import Foundation
import HMUtilities

public final class AAAddressComponent: Codable, HMBytesConvertable {
    public typealias TypeOf = AAAddressComponentType

    /// Component type.
    public var type: TypeOf
    /// Value for the component.
    public var value: String

    /// Initialise `AAAddressComponent` with arguments.
    ///
    /// - parameters:
    ///     - type: Component type.
    ///     - value: Value for the component.
    public init(type: TypeOf, value: String) {
        self.bytes = [type.bytes, value.bytes.sizeBytes(amount: 2), value.bytes].flatMap { $0 }
        self.type = type
        self.value = value
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAAddressComponent` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count >= 1 else {
            return nil
        }
    
        guard let type = TypeOf(bytes: bytes[0..<1].bytes),
    		  let value = bytes.extract(stringFrom: 1) else {
            return nil
        }
    
        self.bytes = bytes
        self.type = type
        self.value = value
    }
}
