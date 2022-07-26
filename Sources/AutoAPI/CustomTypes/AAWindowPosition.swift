import Foundation
import HMUtilities

public final class AAWindowPosition: Codable, HMBytesConvertable {
    public typealias Position = AAWindowPositionPosition

    /// Window location.
    public var location: AAWindowLocation
    /// Position.
    public var position: Position

    /// Initialise `AAWindowPosition` with arguments.
    ///
    /// - parameters:
    ///     - location: Window location.
    ///     - position: Position.
    public init(location: AAWindowLocation, position: Position) {
        self.bytes = [location.bytes, position.bytes].flatMap { $0 }
        self.location = location
        self.position = position
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAWindowPosition` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let location = AAWindowLocation(bytes: bytes[0..<1].bytes),
    		  let position = Position(bytes: bytes[1..<2].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.location = location
        self.position = position
    }
}
