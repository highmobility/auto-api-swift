import Foundation
import HMUtilities

public final class AATirePressureStatus: Codable, HMBytesConvertable {
    public typealias Status = AATirePressureStatusStatus

    /// Location wheel.
    public var location: AALocationWheel
    /// Status.
    public var status: Status

    /// Initialise `AATirePressureStatus` with arguments.
    ///
    /// - parameters:
    ///     - location: Location wheel.
    ///     - status: Status.
    public init(location: AALocationWheel, status: Status) {
        self.bytes = [location.bytes, status.bytes].flatMap { $0 }
        self.location = location
        self.status = status
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AATirePressureStatus` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let location = AALocationWheel(bytes: bytes[0..<1].bytes),
    		  let status = Status(bytes: bytes[1..<2].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.location = location
        self.status = status
    }
}
