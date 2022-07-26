import Foundation
import HMUtilities

public final class AAWeekdayTime: Codable, HMBytesConvertable {
    /// Weekday.
    public var weekday: AAWeekday
    /// Time.
    public var time: AATime

    /// Initialise `AAWeekdayTime` with arguments.
    ///
    /// - parameters:
    ///     - weekday: Weekday.
    ///     - time: Time.
    public init(weekday: AAWeekday, time: AATime) {
        self.bytes = [weekday.bytes, time.bytes].flatMap { $0 }
        self.weekday = weekday
        self.time = time
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAWeekdayTime` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 3 else {
            return nil
        }
    
        guard let weekday = AAWeekday(bytes: bytes[0..<1].bytes),
    		  let time = AATime(bytes: bytes[1..<3].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.weekday = weekday
        self.time = time
    }
}
