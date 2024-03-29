import Foundation
import HMUtilities

public final class AAWindscreen: AACapability, AAPropertyIdentifying {
    public typealias WipersStatus = AAWindscreenWipersStatus
    public typealias WipersIntensity = AAWindscreenWipersIntensity
    public typealias WindscreenDamage = AAWindscreenWindscreenDamage
    public typealias WindscreenNeedsReplacement = AAWindscreenWindscreenNeedsReplacement

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAWindscreen` was introduced to the spec.
        public static let intro: UInt8 = 4
    
        /// Level (version) of *AutoAPI* when `AAWindscreen` was last updated.
        public static let updated: UInt8 = 11
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0042 }

    /// Property identifiers for `AAWindscreen`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case wipersStatus = 0x01
        case wipersIntensity = 0x02
        case windscreenDamage = 0x03
        case windscreenZoneMatrix = 0x04
        case windscreenDamageZone = 0x05
        case windscreenNeedsReplacement = 0x06
        case windscreenDamageConfidence = 0x07
        case windscreenDamageDetectionTime = 0x08
    }

    // MARK: Properties
    /// Windscreen damage value.
    public var windscreenDamage: AAProperty<WindscreenDamage>?
    
    /// Confidence of damage detection, 0% if no impact detected.
    public var windscreenDamageConfidence: AAProperty<AAPercentage>?
    
    /// Windscreen damage detection date.
    public var windscreenDamageDetectionTime: AAProperty<Date>?
    
    /// Representing the position in the zone, seen from the inside of the vehicle (1-based index).
    public var windscreenDamageZone: AAProperty<AAZone>?
    
    /// Windscreen needs replacement value.
    public var windscreenNeedsReplacement: AAProperty<WindscreenNeedsReplacement>?
    
    /// Representing the size of the matrix, seen from the inside of the vehicle.
    public var windscreenZoneMatrix: AAProperty<AAZone>?
    
    /// Wipers intensity value.
    public var wipersIntensity: AAProperty<WipersIntensity>?
    
    /// Wipers status value.
    public var wipersStatus: AAProperty<WipersStatus>?

    // MARK: Getters
    /// Get `AAWindscreen` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getWindscreenState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AAWindscreen` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getWindscreenStateProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getWindscreenState() + ids.map { $0.rawValue }
    }
    
    /// Get `AAWindscreen` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getWindscreenStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AAWindscreen` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getWindscreenStatePropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getWindscreenStateAvailability() + ids.map { $0.rawValue }
    }

    // MARK: Setters
    /// Set the windscreen damage. This is for instance used to reset the glass damage or correct it. Damage confidence percentage is automatically set to either 0% or 100%.
    /// 
    /// - parameters:
    ///     - windscreenDamage: Windscreen damage value.
    ///     - windscreenDamageZone: Representing the position in the zone, seen from the inside of the vehicle (1-based index).
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func setWindscreenDamage(windscreenDamage: WindscreenDamage, windscreenDamageZone: AAZone? = nil) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.windscreenDamage, value: windscreenDamage))
        properties.append(AAProperty(id: PropertyIdentifier.windscreenDamageZone, value: windscreenDamageZone))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Set if the windscreen needs replacement.
    /// 
    /// - parameters:
    ///     - windscreenNeedsReplacement: Windscreen needs replacement value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func setWindscreenReplacementNeeded(windscreenNeedsReplacement: WindscreenNeedsReplacement) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.windscreenNeedsReplacement, value: windscreenNeedsReplacement))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Control the wipers.
    /// 
    /// - parameters:
    ///     - wipersStatus: Wipers status value.
    ///     - wipersIntensity: Wipers intensity value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func controlWipers(wipersStatus: WipersStatus, wipersIntensity: WipersIntensity? = nil) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.wipersStatus, value: wipersStatus))
        properties.append(AAProperty(id: PropertyIdentifier.wipersIntensity, value: wipersIntensity))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        windscreenDamage = extract(property: .windscreenDamage)
        windscreenDamageConfidence = extract(property: .windscreenDamageConfidence)
        windscreenDamageDetectionTime = extract(property: .windscreenDamageDetectionTime)
        windscreenDamageZone = extract(property: .windscreenDamageZone)
        windscreenNeedsReplacement = extract(property: .windscreenNeedsReplacement)
        windscreenZoneMatrix = extract(property: .windscreenZoneMatrix)
        wipersIntensity = extract(property: .wipersIntensity)
        wipersStatus = extract(property: .wipersStatus)
    }
}
