import Foundation
import HMUtilities

public final class AADriverTimeState: Codable, HMBytesConvertable {
    public typealias TimeState = AADriverTimeStateTimeState

    /// The driver number.
    public var driverNumber: UInt8
    /// TimeState.
    public var timeState: TimeState

    /// Initialise `AADriverTimeState` with arguments.
    ///
    /// - parameters:
    ///     - driverNumber: The driver number.
    ///     - timeState: TimeState.
    public init(driverNumber: UInt8, timeState: TimeState) {
        self.bytes = [driverNumber.bytes, timeState.bytes].flatMap { $0 }
        self.driverNumber = driverNumber
        self.timeState = timeState
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AADriverTimeState` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let driverNumber = UInt8(bytes: bytes[0..<1].bytes),
    		  let timeState = TimeState(bytes: bytes[1..<2].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.driverNumber = driverNumber
        self.timeState = timeState
    }
}
