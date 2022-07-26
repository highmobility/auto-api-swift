import Foundation
import HMUtilities

public final class AAPowerTakeoff: AACapability, AAPropertyIdentifying {
    public typealias Engaged = AAPowerTakeoffEngaged

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAPowerTakeoff` was introduced to the spec.
        public static let intro: UInt8 = 7
    
        /// Level (version) of *AutoAPI* when `AAPowerTakeoff` was last updated.
        public static let updated: UInt8 = 11
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0065 }

    /// Property identifiers for `AAPowerTakeoff`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case status = 0x01
        case engaged = 0x02
    }

    // MARK: Properties
    /// Engaged value.
    public var engaged: AAProperty<Engaged>?
    
    /// Status value.
    public var status: AAProperty<AAActiveState>?

    // MARK: Getters
    /// Get `AAPowerTakeoff` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getPowerTakeoffState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AAPowerTakeoff` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getPowerTakeoffStateProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getPowerTakeoffState() + ids.map { $0.rawValue }
    }
    
    /// Get `AAPowerTakeoff` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getPowerTakeoffStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AAPowerTakeoff` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getPowerTakeoffStatePropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getPowerTakeoffStateAvailability() + ids.map { $0.rawValue }
    }

    // MARK: Setters
    /// Activate or deactivate power take-off.
    /// 
    /// - parameters:
    ///     - status: Status value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func activateDeactivatePowerTakeoff(status: AAActiveState) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.status, value: status))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        engaged = extract(property: .engaged)
        status = extract(property: .status)
    }
}
