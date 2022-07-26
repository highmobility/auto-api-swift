import Foundation
import HMUtilities

public final class AADrivingModeActivationPeriod: Codable, HMBytesConvertable {
    /// Driving mode.
    public var drivingMode: AADrivingMode
    /// Percentage of the period used for a driving mode.
    public var period: AAPercentage

    /// Initialise `AADrivingModeActivationPeriod` with arguments.
    ///
    /// - parameters:
    ///     - drivingMode: Driving mode.
    ///     - period: Percentage of the period used for a driving mode.
    public init(drivingMode: AADrivingMode, period: AAPercentage) {
        self.bytes = [drivingMode.bytes, period.bytes].flatMap { $0 }
        self.drivingMode = drivingMode
        self.period = period
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AADrivingModeActivationPeriod` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 9 else {
            return nil
        }
    
        guard let drivingMode = AADrivingMode(bytes: bytes[0..<1].bytes),
    		  let period = AAPercentage(bytes: bytes[1..<9].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.drivingMode = drivingMode
        self.period = period
    }
}
