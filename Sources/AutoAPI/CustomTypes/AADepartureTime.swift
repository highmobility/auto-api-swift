import Foundation
import HMUtilities

public final class AADepartureTime: Codable, HMBytesConvertable {
    /// Active state.
    public var state: AAActiveState
    /// Time.
    public var time: AATime

    /// Initialise `AADepartureTime` with arguments.
    ///
    /// - parameters:
    ///     - state: Active state.
    ///     - time: Time.
    public init(state: AAActiveState, time: AATime) {
        self.bytes = [state.bytes, time.bytes].flatMap { $0 }
        self.state = state
        self.time = time
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AADepartureTime` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 3 else {
            return nil
        }
    
        guard let state = AAActiveState(bytes: bytes[0..<1].bytes),
    		  let time = AATime(bytes: bytes[1..<3].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.state = state
        self.time = time
    }
}
