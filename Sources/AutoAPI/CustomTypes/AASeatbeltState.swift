import Foundation
import HMUtilities

public final class AASeatbeltState: Codable, HMBytesConvertable {
    public typealias FastenedState = AASeatbeltStateFastenedState

    /// Seat location.
    public var location: AASeatLocation
    /// FastenedState.
    public var fastenedState: FastenedState

    /// Initialise `AASeatbeltState` with arguments.
    ///
    /// - parameters:
    ///     - location: Seat location.
    ///     - fastenedState: FastenedState.
    public init(location: AASeatLocation, fastenedState: FastenedState) {
        self.bytes = [location.bytes, fastenedState.bytes].flatMap { $0 }
        self.location = location
        self.fastenedState = fastenedState
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AASeatbeltState` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let location = AASeatLocation(bytes: bytes[0..<1].bytes),
    		  let fastenedState = FastenedState(bytes: bytes[1..<2].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.location = location
        self.fastenedState = fastenedState
    }
}
