import Foundation
import HMUtilities

public final class AASpringRate: Codable, HMBytesConvertable {
    /// Axle.
    public var axle: AAAxle
    /// The suspension spring rate.
    public var springRate: Measurement<UnitTorque>

    /// Initialise `AASpringRate` with arguments.
    ///
    /// - parameters:
    ///     - axle: Axle.
    ///     - springRate: The suspension spring rate.
    public init(axle: AAAxle, springRate: Measurement<UnitTorque>) {
        self.bytes = [axle.bytes, springRate.bytes].flatMap { $0 }
        self.axle = axle
        self.springRate = springRate
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AASpringRate` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 11 else {
            return nil
        }
    
        guard let axle = AAAxle(bytes: bytes[0..<1].bytes),
    		  let springRate = Measurement<UnitTorque>(bytes: bytes[1..<(1 + 10)].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.axle = axle
        self.springRate = springRate
    }
}
