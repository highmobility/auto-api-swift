import Foundation
import HMUtilities

public final class AATemperatureExtreme: Codable, HMBytesConvertable {
    public typealias Extreme = AATemperatureExtremeExtreme

    /// Extreme.
    public var extreme: Extreme
    /// Temperature.
    public var temperature: Measurement<UnitTemperature>

    /// Initialise `AATemperatureExtreme` with arguments.
    ///
    /// - parameters:
    ///     - extreme: Extreme.
    ///     - temperature: Temperature.
    public init(extreme: Extreme, temperature: Measurement<UnitTemperature>) {
        self.bytes = [extreme.bytes, temperature.bytes.sizeBytes(amount: 2), temperature.bytes].flatMap { $0 }
        self.extreme = extreme
        self.temperature = temperature
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AATemperatureExtreme` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 11 else {
            return nil
        }
    
        guard let extreme = Extreme(bytes: bytes[0..<1].bytes),
    		  let temperature = Measurement<UnitTemperature>(bytes: bytes[1..<(1 + 10)].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.extreme = extreme
        self.temperature = temperature
    }
}
