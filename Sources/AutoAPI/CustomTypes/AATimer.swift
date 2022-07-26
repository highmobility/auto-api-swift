import Foundation
import HMUtilities

public final class AATimer: Codable, HMBytesConvertable {
    public typealias TimerType = AATimerTimerType

    /// TimerType.
    public var timerType: TimerType
    /// Timer date.
    public var date: Date

    /// Initialise `AATimer` with arguments.
    ///
    /// - parameters:
    ///     - timerType: TimerType.
    ///     - date: Timer date.
    public init(timerType: TimerType, date: Date) {
        self.bytes = [timerType.bytes, date.bytes].flatMap { $0 }
        self.timerType = timerType
        self.date = date
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AATimer` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 9 else {
            return nil
        }
    
        guard let timerType = TimerType(bytes: bytes[0..<1].bytes),
    		  let date = Date(bytes: bytes[1..<9].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.timerType = timerType
        self.date = date
    }
}
