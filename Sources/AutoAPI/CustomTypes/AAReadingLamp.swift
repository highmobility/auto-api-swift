import Foundation
import HMUtilities

public final class AAReadingLamp: Codable, HMBytesConvertable {
    /// Location.
    public var location: AALocation
    /// Active state.
    public var state: AAActiveState

    /// Initialise `AAReadingLamp` with arguments.
    ///
    /// - parameters:
    ///     - location: Location.
    ///     - state: Active state.
    public init(location: AALocation, state: AAActiveState) {
        self.bytes = [location.bytes, state.bytes].flatMap { $0 }
        self.location = location
        self.state = state
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAReadingLamp` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let location = AALocation(bytes: bytes[0..<1].bytes),
    		  let state = AAActiveState(bytes: bytes[1..<2].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.location = location
        self.state = state
    }
}
