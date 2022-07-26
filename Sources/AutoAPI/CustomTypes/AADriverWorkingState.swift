import Foundation
import HMUtilities

public final class AADriverWorkingState: Codable, HMBytesConvertable {
    public typealias WorkingState = AADriverWorkingStateWorkingState

    /// The driver number.
    public var driverNumber: UInt8
    /// WorkingState.
    public var workingState: WorkingState

    /// Initialise `AADriverWorkingState` with arguments.
    ///
    /// - parameters:
    ///     - driverNumber: The driver number.
    ///     - workingState: WorkingState.
    public init(driverNumber: UInt8, workingState: WorkingState) {
        self.bytes = [driverNumber.bytes, workingState.bytes].flatMap { $0 }
        self.driverNumber = driverNumber
        self.workingState = workingState
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AADriverWorkingState` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let driverNumber = UInt8(bytes: bytes[0..<1].bytes),
    		  let workingState = WorkingState(bytes: bytes[1..<2].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.driverNumber = driverNumber
        self.workingState = workingState
    }
}
