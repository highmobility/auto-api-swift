import Foundation
import HMUtilities

public final class AAHeartRate: AACapability, AAPropertyIdentifying {
    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAHeartRate` was introduced to the spec.
        public static let intro: UInt8 = 4
    
        /// Level (version) of *AutoAPI* when `AAHeartRate` was last updated.
        public static let updated: UInt8 = 12
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0029 }

    /// Property identifiers for `AAHeartRate`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case heartRate = 0x01		// Non-state property (can't be retrieved)
    }

    // MARK: Setters
    /// Send the driver heart rate to the vehicle.
    /// 
    /// - parameters:
    ///     - heartRate: Heart rate value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func sendHeartRate(heartRate: Measurement<UnitFrequency>) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.heartRate, value: heartRate))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
}
