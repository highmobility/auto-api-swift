import Foundation
import HMUtilities

public final class AADistanceOverTime: Codable, HMBytesConvertable {
    /// Distance driven.
    public var distance: Measurement<UnitLength>
    /// Duration of time for the given distance.
    public var time: Measurement<UnitDuration>

    /// Initialise `AADistanceOverTime` with arguments.
    ///
    /// - parameters:
    ///     - distance: Distance driven.
    ///     - time: Duration of time for the given distance.
    public init(distance: Measurement<UnitLength>, time: Measurement<UnitDuration>) {
        self.bytes = [distance.bytes, time.bytes].flatMap { $0 }
        self.distance = distance
        self.time = time
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AADistanceOverTime` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 20 else {
            return nil
        }
    
        guard let distance = Measurement<UnitLength>(bytes: bytes[0..<(0 + 10)].bytes),
    		  let time = Measurement<UnitDuration>(bytes: bytes[10..<(10 + 10)].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.distance = distance
        self.time = time
    }
}
