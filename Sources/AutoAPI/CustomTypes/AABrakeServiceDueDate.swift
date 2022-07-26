import Foundation
import HMUtilities

public final class AABrakeServiceDueDate: Codable, HMBytesConvertable {
    /// Axle.
    public var axle: AAAxle
    /// DueDate.
    public var dueDate: Date

    /// Initialise `AABrakeServiceDueDate` with arguments.
    ///
    /// - parameters:
    ///     - axle: Axle.
    ///     - dueDate: DueDate.
    public init(axle: AAAxle, dueDate: Date) {
        self.bytes = [axle.bytes, dueDate.bytes.sizeBytes(amount: 2), dueDate.bytes].flatMap { $0 }
        self.axle = axle
        self.dueDate = dueDate
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AABrakeServiceDueDate` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 9 else {
            return nil
        }
    
        guard let axle = AAAxle(bytes: bytes[0..<1].bytes),
    		  let dueDate = Date(bytes: bytes[1..<3].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.axle = axle
        self.dueDate = dueDate
    }
}
