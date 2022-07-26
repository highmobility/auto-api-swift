import Foundation
import HMUtilities

public final class AAOemTroubleCodeValue: Codable, HMBytesConvertable {
    /// Identifier for the trouble code.
    public var ID: String
    /// Key-value pair for the trouble code.
    public var keyValue: AAKeyValue

    /// Initialise `AAOemTroubleCodeValue` with arguments.
    ///
    /// - parameters:
    ///     - ID: Identifier for the trouble code.
    ///     - keyValue: Key-value pair for the trouble code.
    public init(ID: String, keyValue: AAKeyValue) {
        self.bytes = [ID.bytes.sizeBytes(amount: 2), ID.bytes, keyValue.bytes.sizeBytes(amount: 2), keyValue.bytes].flatMap { $0 }
        self.ID = ID
        self.keyValue = keyValue
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAOemTroubleCodeValue` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count >= 0 else {
            return nil
        }
    
        guard let ID = bytes.extract(stringFrom: 0),
    		  let keyValue = AAKeyValue(bytes: bytes.extract(bytesFrom: (2 + ID.bytes.count))) else {
            return nil
        }
    
        self.bytes = bytes
        self.ID = ID
        self.keyValue = keyValue
    }
}
