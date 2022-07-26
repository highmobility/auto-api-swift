import Foundation
import HMUtilities

public final class AATirePressure: Codable, HMBytesConvertable {
    /// Location wheel.
    public var location: AALocationWheel
    /// Tire pressure.
    public var pressure: Measurement<UnitPressure>

    /// Initialise `AATirePressure` with arguments.
    ///
    /// - parameters:
    ///     - location: Location wheel.
    ///     - pressure: Tire pressure.
    public init(location: AALocationWheel, pressure: Measurement<UnitPressure>) {
        self.bytes = [location.bytes, pressure.bytes].flatMap { $0 }
        self.location = location
        self.pressure = pressure
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AATirePressure` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 11 else {
            return nil
        }
    
        guard let location = AALocationWheel(bytes: bytes[0..<1].bytes),
    		  let pressure = Measurement<UnitPressure>(bytes: bytes[1..<(1 + 10)].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.location = location
        self.pressure = pressure
    }
}
