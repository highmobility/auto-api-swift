import Foundation
import HMUtilities

public final class AAAcceleratorDuration: Codable, HMBytesConvertable {
    /// The accelerator pedal position threshold percentage.
    public var pedalPositionThreshold: AAPercentage
    /// The duration of the accelerator pedal position.
    public var duration: Measurement<UnitDuration>

    /// Initialise `AAAcceleratorDuration` with arguments.
    ///
    /// - parameters:
    ///     - pedalPositionThreshold: The accelerator pedal position threshold percentage.
    ///     - duration: The duration of the accelerator pedal position.
    public init(pedalPositionThreshold: AAPercentage, duration: Measurement<UnitDuration>) {
        self.bytes = [pedalPositionThreshold.bytes, duration.bytes].flatMap { $0 }
        self.pedalPositionThreshold = pedalPositionThreshold
        self.duration = duration
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAAcceleratorDuration` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 18 else {
            return nil
        }
    
        guard let pedalPositionThreshold = AAPercentage(bytes: bytes[0..<8].bytes),
    		  let duration = Measurement<UnitDuration>(bytes: bytes[8..<(8 + 10)].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.pedalPositionThreshold = pedalPositionThreshold
        self.duration = duration
    }
}
