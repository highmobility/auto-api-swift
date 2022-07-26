import Foundation
import HMUtilities

public final class AABrakeTorqueVectoring: Codable, HMBytesConvertable {
    /// Axle.
    public var axle: AAAxle
    /// Active state.
    public var state: AAActiveState

    /// Initialise `AABrakeTorqueVectoring` with arguments.
    ///
    /// - parameters:
    ///     - axle: Axle.
    ///     - state: Active state.
    public init(axle: AAAxle, state: AAActiveState) {
        self.bytes = [axle.bytes, state.bytes].flatMap { $0 }
        self.axle = axle
        self.state = state
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AABrakeTorqueVectoring` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let axle = AAAxle(bytes: bytes[0..<1].bytes),
    		  let state = AAActiveState(bytes: bytes[1..<2].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.axle = axle
        self.state = state
    }
}
