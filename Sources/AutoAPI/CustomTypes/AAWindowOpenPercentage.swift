import Foundation
import HMUtilities

public final class AAWindowOpenPercentage: Codable, HMBytesConvertable {
    /// Window location.
    public var location: AAWindowLocation
    /// Percentage value between 0.0 - 1.0 (0% - 100%).
    public var openPercentage: AAPercentage

    /// Initialise `AAWindowOpenPercentage` with arguments.
    ///
    /// - parameters:
    ///     - location: Window location.
    ///     - openPercentage: Percentage value between 0.0 - 1.0 (0% - 100%).
    public init(location: AAWindowLocation, openPercentage: AAPercentage) {
        self.bytes = [location.bytes, openPercentage.bytes].flatMap { $0 }
        self.location = location
        self.openPercentage = openPercentage
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAWindowOpenPercentage` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 9 else {
            return nil
        }
    
        guard let location = AAWindowLocation(bytes: bytes[0..<1].bytes),
    		  let openPercentage = AAPercentage(bytes: bytes[1..<9].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.location = location
        self.openPercentage = openPercentage
    }
}
