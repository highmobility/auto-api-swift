import Foundation
import HMUtilities

public final class AAPersonDetected: Codable, HMBytesConvertable {
    /// Seat location.
    public var location: AASeatLocation
    /// Detected.
    public var detected: AADetected

    /// Initialise `AAPersonDetected` with arguments.
    ///
    /// - parameters:
    ///     - location: Seat location.
    ///     - detected: Detected.
    public init(location: AASeatLocation, detected: AADetected) {
        self.bytes = [location.bytes, detected.bytes].flatMap { $0 }
        self.location = location
        self.detected = detected
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAPersonDetected` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let location = AASeatLocation(bytes: bytes[0..<1].bytes),
    		  let detected = AADetected(bytes: bytes[1..<2].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.location = location
        self.detected = detected
    }
}
