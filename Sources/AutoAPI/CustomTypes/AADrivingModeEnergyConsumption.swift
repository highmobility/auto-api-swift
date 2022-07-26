import Foundation
import HMUtilities

public final class AADrivingModeEnergyConsumption: Codable, HMBytesConvertable {
    /// Driving mode.
    public var drivingMode: AADrivingMode
    /// Energy consumption in the driving mode.
    public var consumption: Measurement<UnitEnergy>

    /// Initialise `AADrivingModeEnergyConsumption` with arguments.
    ///
    /// - parameters:
    ///     - drivingMode: Driving mode.
    ///     - consumption: Energy consumption in the driving mode.
    public init(drivingMode: AADrivingMode, consumption: Measurement<UnitEnergy>) {
        self.bytes = [drivingMode.bytes, consumption.bytes].flatMap { $0 }
        self.drivingMode = drivingMode
        self.consumption = consumption
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AADrivingModeEnergyConsumption` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 11 else {
            return nil
        }
    
        guard let drivingMode = AADrivingMode(bytes: bytes[0..<1].bytes),
    		  let consumption = Measurement<UnitEnergy>(bytes: bytes[1..<(1 + 10)].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.drivingMode = drivingMode
        self.consumption = consumption
    }
}
