import Foundation
import HMUtilities

public final class AALightConditions: AACapability, AAPropertyIdentifying {
    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AALightConditions` was introduced to the spec.
        public static let intro: UInt8 = 5
    
        /// Level (version) of *AutoAPI* when `AALightConditions` was last updated.
        public static let updated: UInt8 = 12
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0054 }

    /// Property identifiers for `AALightConditions`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case outsideLight = 0x01
        case insideLight = 0x02
    }

    // MARK: Properties
    /// Measured inside illuminance.
    public var insideLight: AAProperty<Measurement<UnitIlluminance>>?
    
    /// Measured outside illuminance.
    public var outsideLight: AAProperty<Measurement<UnitIlluminance>>?

    // MARK: Getters
    /// Get `AALightConditions` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getLightConditions() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AALightConditions` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getLightConditionsProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getLightConditions() + ids.map { $0.rawValue }
    }
    
    /// Get `AALightConditions` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getLightConditionsAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AALightConditions` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getLightConditionsPropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getLightConditionsAvailability() + ids.map { $0.rawValue }
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        insideLight = extract(property: .insideLight)
        outsideLight = extract(property: .outsideLight)
    }
}
