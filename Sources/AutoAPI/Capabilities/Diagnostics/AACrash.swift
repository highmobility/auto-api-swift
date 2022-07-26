import Foundation
import HMUtilities

public final class AACrash: AACapability, AAPropertyIdentifying {
    public typealias TypeOf = AACrashType
    public typealias TippedState = AACrashTippedState
    public typealias ImpactZone = AACrashImpactZone
    public typealias Status = AACrashStatus

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AACrash` was introduced to the spec.
        public static let intro: UInt8 = 13
    
        /// Level (version) of *AutoAPI* when `AACrash` was last updated.
        public static let updated: UInt8 = 13
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x006B }

    /// Property identifiers for `AACrash`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case incidents = 0x01
        case type = 0x02
        case tippedState = 0x03
        case automaticECall = 0x04
        case severity = 0x05
        case impactZone = 0x06
        case status = 0x07
    }

    // MARK: Properties
    /// Automatic emergency call enabled state.
    public var automaticECall: AAProperty<AAEnabledState>?
    
    /// Impact zone of the crash.
    public var impactZone: [AAProperty<ImpactZone>]?
    
    /// Incidents value.
    public var incidents: [AAProperty<AACrashIncident>]?
    
    /// Severity of the crash (from 0 to 7 - very high severity).
    public var severity: AAProperty<UInt8>?
    
    /// The system effect an inpact had on the vehicle..
    public var status: AAProperty<Status>?
    
    /// Tipped state value.
    public var tippedState: AAProperty<TippedState>?
    
    /// Type value.
    public var type: AAProperty<TypeOf>?

    // MARK: Getters
    /// Get `AACrash` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getCrashState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AACrash` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getCrashStateProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getCrashState() + ids.map { $0.rawValue }
    }
    
    /// Get `AACrash` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getCrashStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AACrash` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getCrashStatePropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getCrashStateAvailability() + ids.map { $0.rawValue }
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        automaticECall = extract(property: .automaticECall)
        impactZone = extract(properties: .impactZone)
        incidents = extract(properties: .incidents)
        severity = extract(property: .severity)
        status = extract(property: .status)
        tippedState = extract(property: .tippedState)
        type = extract(property: .type)
    }
}
