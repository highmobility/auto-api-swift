import Foundation
import HMUtilities

public final class AAWheelRPM: Codable, HMBytesConvertable {
    /// Wheel location.
    public var location: AALocationWheel
    /// The RPM measured at this wheel.
    public var RPM: Measurement<UnitAngularVelocity>

    /// Initialise `AAWheelRPM` with arguments.
    ///
    /// - parameters:
    ///     - location: Wheel location.
    ///     - RPM: The RPM measured at this wheel.
    public init(location: AALocationWheel, RPM: Measurement<UnitAngularVelocity>) {
        self.bytes = [location.bytes, RPM.bytes].flatMap { $0 }
        self.location = location
        self.RPM = RPM
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAWheelRPM` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 11 else {
            return nil
        }
    
        guard let location = AALocationWheel(bytes: bytes[0..<1].bytes),
    		  let RPM = Measurement<UnitAngularVelocity>(bytes: bytes[1..<(1 + 10)].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.location = location
        self.RPM = RPM
    }
}
