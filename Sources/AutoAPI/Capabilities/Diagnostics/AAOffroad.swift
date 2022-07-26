import Foundation
import HMUtilities

public final class AAOffroad: AACapability, AAPropertyIdentifying {
    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAOffroad` was introduced to the spec.
        public static let intro: UInt8 = 5
    
        /// Level (version) of *AutoAPI* when `AAOffroad` was last updated.
        public static let updated: UInt8 = 12
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0052 }

    /// Property identifiers for `AAOffroad`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case routeIncline = 0x01
        case wheelSuspension = 0x02
    }

    // MARK: Properties
    /// The route elevation incline.
    public var routeIncline: AAProperty<Measurement<UnitAngle>>?
    
    /// The wheel suspension level percentage, whereas 0.0 is no suspension and 1.0 maximum suspension.
    public var wheelSuspension: AAProperty<AAPercentage>?

    // MARK: Getters
    /// Get `AAOffroad` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getOffroadState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AAOffroad` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getOffroadStateProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getOffroadState() + ids.map { $0.rawValue }
    }
    
    /// Get `AAOffroad` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getOffroadStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AAOffroad` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getOffroadStatePropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getOffroadStateAvailability() + ids.map { $0.rawValue }
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        routeIncline = extract(property: .routeIncline)
        wheelSuspension = extract(property: .wheelSuspension)
    }
}
