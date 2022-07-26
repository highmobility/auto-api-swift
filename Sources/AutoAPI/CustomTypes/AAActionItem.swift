import Foundation
import HMUtilities

public final class AAActionItem: Codable, HMBytesConvertable {
    /// Action identifier.
    public var id: UInt8
    /// Name of the action.
    public var name: String

    /// Initialise `AAActionItem` with arguments.
    ///
    /// - parameters:
    ///     - id: Action identifier.
    ///     - name: Name of the action.
    public init(id: UInt8, name: String) {
        self.bytes = [id.bytes, name.bytes.sizeBytes(amount: 2), name.bytes].flatMap { $0 }
        self.id = id
        self.name = name
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAActionItem` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count >= 1 else {
            return nil
        }
    
        guard let id = UInt8(bytes: bytes[0..<1].bytes),
    		  let name = bytes.extract(stringFrom: 1) else {
            return nil
        }
    
        self.bytes = bytes
        self.id = id
        self.name = name
    }
}
