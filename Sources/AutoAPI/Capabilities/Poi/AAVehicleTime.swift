import Foundation
import HMUtilities

public final class AAVehicleTime: AACapability, AAPropertyIdentifying {
    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAVehicleTime` was introduced to the spec.
        public static let intro: UInt8 = 5
    
        /// Level (version) of *AutoAPI* when `AAVehicleTime` was last updated.
        public static let updated: UInt8 = 11
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0050 }

    /// Property identifiers for `AAVehicleTime`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case vehicleTime = 0x01
    }

    // MARK: Properties
    /// Vehicle time in a 24h format.
    public var vehicleTime: AAProperty<AATime>?

    // MARK: Getters
    /// Get `AAVehicleTime` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getVehicleTime() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AAVehicleTime` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getVehicleTimeAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        vehicleTime = extract(property: .vehicleTime)
    }
}
