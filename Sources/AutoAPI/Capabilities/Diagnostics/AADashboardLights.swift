import Foundation
import HMUtilities

public final class AADashboardLights: AACapability, AAPropertyIdentifying {
    public typealias BulbFailures = AADashboardLightsBulbFailures

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AADashboardLights` was introduced to the spec.
        public static let intro: UInt8 = 7
    
        /// Level (version) of *AutoAPI* when `AADashboardLights` was last updated.
        public static let updated: UInt8 = 11
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0061 }

    /// Property identifiers for `AADashboardLights`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case dashboardLights = 0x01
        case bulbFailures = 0x02
    }

    // MARK: Properties
    /// Vehicle light bulb failure.
    public var bulbFailures: [AAProperty<BulbFailures>]?
    
    /// Dashboard lights value.
    public var dashboardLights: [AAProperty<AADashboardLight>]?

    // MARK: Getters
    /// Get `AADashboardLights` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getDashboardLights() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AADashboardLights` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getDashboardLightsProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getDashboardLights() + ids.map { $0.rawValue }
    }
    
    /// Get `AADashboardLights` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getDashboardLightsAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AADashboardLights` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getDashboardLightsPropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getDashboardLightsAvailability() + ids.map { $0.rawValue }
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        bulbFailures = extract(properties: .bulbFailures)
        dashboardLights = extract(properties: .dashboardLights)
    }
}
