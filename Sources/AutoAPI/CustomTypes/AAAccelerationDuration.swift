import Foundation
import HMUtilities

public final class AAAccelerationDuration: Codable, HMBytesConvertable {
    public typealias Direction = AAAccelerationDurationDirection
    public typealias TypeOf = AAAccelerationDurationType

    /// Direction.
    public var direction: Direction
    /// Type.
    public var type: TypeOf
    /// The duration of the acceleration.
    public var duration: Measurement<UnitDuration>

    /// Initialise `AAAccelerationDuration` with arguments.
    ///
    /// - parameters:
    ///     - direction: Direction.
    ///     - type: Type.
    ///     - duration: The duration of the acceleration.
    public init(direction: Direction, type: TypeOf, duration: Measurement<UnitDuration>) {
        self.bytes = [direction.bytes, type.bytes, duration.bytes].flatMap { $0 }
        self.direction = direction
        self.type = type
        self.duration = duration
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAAccelerationDuration` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 12 else {
            return nil
        }
    
        guard let direction = Direction(bytes: bytes[0..<1].bytes),
    		  let type = TypeOf(bytes: bytes[1..<2].bytes),
    		  let duration = Measurement<UnitDuration>(bytes: bytes[2..<(2 + 10)].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.direction = direction
        self.type = type
        self.duration = duration
    }
}
