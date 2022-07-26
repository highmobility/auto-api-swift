import Foundation
import HMUtilities

public final class AAAcceleration: Codable, HMBytesConvertable {
    public typealias Direction = AAAccelerationDirection

    /// Direction.
    public var direction: Direction
    /// The accelaration.
    public var acceleration: Measurement<UnitAcceleration>

    /// Initialise `AAAcceleration` with arguments.
    ///
    /// - parameters:
    ///     - direction: Direction.
    ///     - acceleration: The accelaration.
    public init(direction: Direction, acceleration: Measurement<UnitAcceleration>) {
        self.bytes = [direction.bytes, acceleration.bytes].flatMap { $0 }
        self.direction = direction
        self.acceleration = acceleration
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAAcceleration` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 11 else {
            return nil
        }
    
        guard let direction = Direction(bytes: bytes[0..<1].bytes),
    		  let acceleration = Measurement<UnitAcceleration>(bytes: bytes[1..<(1 + 10)].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.direction = direction
        self.acceleration = acceleration
    }
}
