import Foundation
import HMUtilities

public final class AAReductionTime: Codable, HMBytesConvertable {
    /// Start-Stop.
    public var startStop: AAStartStop
    /// Time.
    public var time: AATime

    /// Initialise `AAReductionTime` with arguments.
    ///
    /// - parameters:
    ///     - startStop: Start-Stop.
    ///     - time: Time.
    public init(startStop: AAStartStop, time: AATime) {
        self.bytes = [startStop.bytes, time.bytes].flatMap { $0 }
        self.startStop = startStop
        self.time = time
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAReductionTime` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 3 else {
            return nil
        }
    
        guard let startStop = AAStartStop(bytes: bytes[0..<1].bytes),
    		  let time = AATime(bytes: bytes[1..<3].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.startStop = startStop
        self.time = time
    }
}
