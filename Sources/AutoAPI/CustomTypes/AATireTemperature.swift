import Foundation
import HMUtilities

public final class AATireTemperature: Codable, HMBytesConvertable {
    /// Location wheel.
    public var location: AALocationWheel
    /// Tire temperature.
    public var temperature: Measurement<UnitTemperature>

    /// Initialise `AATireTemperature` with arguments.
    ///
    /// - parameters:
    ///     - location: Location wheel.
    ///     - temperature: Tire temperature.
    public init(location: AALocationWheel, temperature: Measurement<UnitTemperature>) {
        self.bytes = [location.bytes, temperature.bytes].flatMap { $0 }
        self.location = location
        self.temperature = temperature
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AATireTemperature` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 11 else {
            return nil
        }
    
        guard let location = AALocationWheel(bytes: bytes[0..<1].bytes),
    		  let temperature = Measurement<UnitTemperature>(bytes: bytes[1..<(1 + 10)].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.location = location
        self.temperature = temperature
    }
}
