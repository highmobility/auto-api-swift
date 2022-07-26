import Foundation
import HMUtilities

public final class AALock: Codable, HMBytesConvertable {
    /// Door location.
    public var location: AALocation
    /// Lock state for the door.
    public var lockState: AALockState

    /// Initialise `AALock` with arguments.
    ///
    /// - parameters:
    ///     - location: Door location.
    ///     - lockState: Lock state for the door.
    public init(location: AALocation, lockState: AALockState) {
        self.bytes = [location.bytes, lockState.bytes].flatMap { $0 }
        self.location = location
        self.lockState = lockState
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AALock` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let location = AALocation(bytes: bytes[0..<1].bytes),
    		  let lockState = AALockState(bytes: bytes[1..<2].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.location = location
        self.lockState = lockState
    }
}
