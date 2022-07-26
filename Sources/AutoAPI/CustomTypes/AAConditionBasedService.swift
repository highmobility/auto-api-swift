import Foundation
import HMUtilities

public final class AAConditionBasedService: Codable, HMBytesConvertable {
    public typealias DueStatus = AAConditionBasedServiceDueStatus

    /// The year.
    public var year: UInt16
    /// Value between 1 and 12.
    public var month: UInt8
    /// CBS identifier.
    public var id: UInt16
    /// DueStatus.
    public var dueStatus: DueStatus
    /// CBS text.
    public var text: String
    /// Description.
    public var description: String

    /// Initialise `AAConditionBasedService` with arguments.
    ///
    /// - parameters:
    ///     - year: The year.
    ///     - month: Value between 1 and 12.
    ///     - id: CBS identifier.
    ///     - dueStatus: DueStatus.
    ///     - text: CBS text.
    ///     - description: Description.
    public init(year: UInt16, month: UInt8, id: UInt16, dueStatus: DueStatus, text: String, description: String) {
        self.bytes = [year.bytes, month.bytes, id.bytes, dueStatus.bytes, text.bytes.sizeBytes(amount: 2), text.bytes, description.bytes.sizeBytes(amount: 2), description.bytes].flatMap { $0 }
        self.year = year
        self.month = month
        self.id = id
        self.dueStatus = dueStatus
        self.text = text
        self.description = description
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAConditionBasedService` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count >= 6 else {
            return nil
        }
    
        guard let year = UInt16(bytes: bytes[0..<2].bytes),
    		  let month = UInt8(bytes: bytes[2..<3].bytes),
    		  let id = UInt16(bytes: bytes[3..<5].bytes),
    		  let dueStatus = DueStatus(bytes: bytes[5..<6].bytes),
    		  let text = bytes.extract(stringFrom: 6),
    		  let description = bytes.extract(stringFrom: (8 + text.bytes.count)) else {
            return nil
        }
    
        self.bytes = bytes
        self.year = year
        self.month = month
        self.id = id
        self.dueStatus = dueStatus
        self.text = text
        self.description = description
    }
}
