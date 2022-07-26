import Foundation
import HMUtilities

public final class AAFailure: Codable, HMBytesConvertable {
    public typealias Reason = AAFailureReason

    /// Reason.
    public var reason: Reason
    /// Failure description.
    public var description: String

    /// Initialise `AAFailure` with arguments.
    ///
    /// - parameters:
    ///     - reason: Reason.
    ///     - description: Failure description.
    public init(reason: Reason, description: String) {
        self.bytes = [reason.bytes, description.bytes.sizeBytes(amount: 2), description.bytes].flatMap { $0 }
        self.reason = reason
        self.description = description
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAFailure` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count >= 1 else {
            return nil
        }
    
        guard let reason = Reason(bytes: bytes[0..<1].bytes),
    		  let description = bytes.extract(stringFrom: 1) else {
            return nil
        }
    
        self.bytes = bytes
        self.reason = reason
        self.description = description
    }
}
