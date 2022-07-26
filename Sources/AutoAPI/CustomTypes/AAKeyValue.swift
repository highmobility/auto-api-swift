import Foundation
import HMUtilities

public final class AAKeyValue: Codable, HMBytesConvertable {
    /// Key for the value.
    public var key: String
    /// Value for the key.
    public var value: String

    /// Initialise `AAKeyValue` with arguments.
    ///
    /// - parameters:
    ///     - key: Key for the value.
    ///     - value: Value for the key.
    public init(key: String, value: String) {
        self.bytes = [key.bytes.sizeBytes(amount: 2), key.bytes, value.bytes.sizeBytes(amount: 2), value.bytes].flatMap { $0 }
        self.key = key
        self.value = value
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAKeyValue` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count >= 0 else {
            return nil
        }
    
        guard let key = bytes.extract(stringFrom: 0),
    		  let value = bytes.extract(stringFrom: (2 + key.bytes.count)) else {
            return nil
        }
    
        self.bytes = bytes
        self.key = key
        self.value = value
    }
}
