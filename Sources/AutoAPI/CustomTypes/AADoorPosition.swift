import Foundation
import HMUtilities

public final class AADoorPosition: Codable, HMBytesConvertable {
    public typealias Location = AADoorPositionLocation

    /// Location.
    public var location: Location
    /// Position.
    public var position: AAPosition

    /// Initialise `AADoorPosition` with arguments.
    ///
    /// - parameters:
    ///     - location: Location.
    ///     - position: Position.
    public init(location: Location, position: AAPosition) {
        self.bytes = [location.bytes, position.bytes].flatMap { $0 }
        self.location = location
        self.position = position
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AADoorPosition` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let location = Location(bytes: bytes[0..<1].bytes),
    		  let position = AAPosition(bytes: bytes[1..<2].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.location = location
        self.position = position
    }
}
