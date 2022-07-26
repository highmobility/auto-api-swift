import Foundation
import HMUtilities

public final class AACoordinates: Codable, HMBytesConvertable {
    /// Latitude.
    public var latitude: Double
    /// Longitude.
    public var longitude: Double

    /// Initialise `AACoordinates` with arguments.
    ///
    /// - parameters:
    ///     - latitude: Latitude.
    ///     - longitude: Longitude.
    public init(latitude: Double, longitude: Double) {
        self.bytes = [latitude.bytes, longitude.bytes].flatMap { $0 }
        self.latitude = latitude
        self.longitude = longitude
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AACoordinates` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 16 else {
            return nil
        }
    
        guard let latitude = Double(bytes: bytes[0..<8].bytes),
    		  let longitude = Double(bytes: bytes[8..<16].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.latitude = latitude
        self.longitude = longitude
    }
}
