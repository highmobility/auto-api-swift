import Foundation
import HMUtilities

public final class AATime: Codable, HMBytesConvertable {
    /// Value between 0 and 23.
    public var hour: UInt8
    /// Value between 0 and 59.
    public var minute: UInt8

    /// Initialise `AATime` with arguments.
    ///
    /// - parameters:
    ///     - hour: Value between 0 and 23.
    ///     - minute: Value between 0 and 59.
    public init(hour: UInt8, minute: UInt8) {
        self.bytes = [hour.bytes, minute.bytes].flatMap { $0 }
        self.hour = hour
        self.minute = minute
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AATime` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let hour = UInt8(bytes: bytes[0..<1].bytes),
    		  let minute = UInt8(bytes: bytes[1..<2].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.hour = hour
        self.minute = minute
    }
}
