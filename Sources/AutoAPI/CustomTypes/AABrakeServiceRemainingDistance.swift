import Foundation
import HMUtilities

public final class AABrakeServiceRemainingDistance: Codable, HMBytesConvertable {
    /// Axle.
    public var axle: AAAxle
    /// Distance.
    public var distance: Measurement<UnitLength>

    /// Initialise `AABrakeServiceRemainingDistance` with arguments.
    ///
    /// - parameters:
    ///     - axle: Axle.
    ///     - distance: Distance.
    public init(axle: AAAxle, distance: Measurement<UnitLength>) {
        self.bytes = [axle.bytes, distance.bytes].flatMap { $0 }
        self.axle = axle
        self.distance = distance
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AABrakeServiceRemainingDistance` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 11 else {
            return nil
        }
    
        guard let axle = AAAxle(bytes: bytes[0..<1].bytes),
    		  let distance = Measurement<UnitLength>(bytes: bytes[1..<(1 + 10)].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.axle = axle
        self.distance = distance
    }
}
