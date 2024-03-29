import Foundation
import HMUtilities

public final class AACruiseControl: AACapability, AAPropertyIdentifying {
    public typealias Limiter = AACruiseControlLimiter

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AACruiseControl` was introduced to the spec.
        public static let intro: UInt8 = 7
    
        /// Level (version) of *AutoAPI* when `AACruiseControl` was last updated.
        public static let updated: UInt8 = 12
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0062 }

    /// Property identifiers for `AACruiseControl`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case cruiseControl = 0x01
        case limiter = 0x02
        case targetSpeed = 0x03
        case adaptiveCruiseControl = 0x04
        case accTargetSpeed = 0x05
    }

    // MARK: Properties
    /// The target speed of the Adaptive Cruise Control.
    public var accTargetSpeed: AAProperty<Measurement<UnitSpeed>>?
    
    /// Adaptive Cruise Control value.
    public var adaptiveCruiseControl: AAProperty<AAActiveState>?
    
    /// Cruise control value.
    public var cruiseControl: AAProperty<AAActiveState>?
    
    /// Limiter value.
    public var limiter: AAProperty<Limiter>?
    
    /// The target speed.
    public var targetSpeed: AAProperty<Measurement<UnitSpeed>>?

    // MARK: Getters
    /// Get `AACruiseControl` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getCruiseControlState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AACruiseControl` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getCruiseControlStateProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getCruiseControlState() + ids.map { $0.rawValue }
    }
    
    /// Get `AACruiseControl` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getCruiseControlStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AACruiseControl` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getCruiseControlStatePropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getCruiseControlStateAvailability() + ids.map { $0.rawValue }
    }

    // MARK: Setters
    /// Activate or deactivate cruise control.
    /// 
    /// - parameters:
    ///     - cruiseControl: Cruise control value.
    ///     - targetSpeed: The target speed.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func activateDeactivateCruiseControl(cruiseControl: AAActiveState, targetSpeed: Measurement<UnitSpeed>? = nil) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.cruiseControl, value: cruiseControl))
        properties.append(AAProperty(id: PropertyIdentifier.targetSpeed, value: targetSpeed))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        accTargetSpeed = extract(property: .accTargetSpeed)
        adaptiveCruiseControl = extract(property: .adaptiveCruiseControl)
        cruiseControl = extract(property: .cruiseControl)
        limiter = extract(property: .limiter)
        targetSpeed = extract(property: .targetSpeed)
    }
}
