import Foundation
import HMUtilities

public final class AAEngine: AACapability, AAPropertyIdentifying {
    public typealias PreconditioningError = AAEnginePreconditioningError
    public typealias PreconditioningStatus = AAEnginePreconditioningStatus

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAEngine` was introduced to the spec.
        public static let intro: UInt8 = 11
    
        /// Level (version) of *AutoAPI* when `AAEngine` was last updated.
        public static let updated: UInt8 = 11
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0069 }

    /// Property identifiers for `AAEngine`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case status = 0x01
        case startStopState = 0x02
        case startStopEnabled = 0x03
        case preconditioningEnabled = 0x04
        case preconditioningActive = 0x05
        case preconditioningRemainingTime = 0x06
        case preconditioningError = 0x07
        case preconditioningStatus = 0x08
        case limpMode = 0x09
    }

    // MARK: Properties
    /// Indicates wheter the engine is in fail-safe mode..
    public var limpMode: AAProperty<AAActiveState>?
    
    /// Pre-conditioning is running..
    public var preconditioningActive: AAProperty<AAActiveState>?
    
    /// Use of the engine pre-conditioning is enabled..
    public var preconditioningEnabled: AAProperty<AAEnabledState>?
    
    /// Reason for not carrying out pre-conditioning..
    public var preconditioningError: AAProperty<PreconditioningError>?
    
    /// Remaining time of pre-conditioning..
    public var preconditioningRemainingTime: AAProperty<Measurement<UnitDuration>>?
    
    /// Status of the pre-conditioning system..
    public var preconditioningStatus: AAProperty<PreconditioningStatus>?
    
    /// Indicates if the automatic start-stop system is enabled or not.
    public var startStopEnabled: AAProperty<AAEnabledState>?
    
    /// Indicates wheter the start-stop system is currently active or not.
    public var startStopState: AAProperty<AAActiveState>?
    
    /// Status value.
    public var status: AAProperty<AAOnOffState>?

    // MARK: Getters
    /// Get `AAEngine` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getEngineState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AAEngine` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getEngineStateProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getEngineState() + ids.map { $0.rawValue }
    }
    
    /// Get `AAEngine` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getEngineStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AAEngine` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getEngineStatePropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getEngineStateAvailability() + ids.map { $0.rawValue }
    }

    // MARK: Setters
    /// Attempt to turn the vehicle engine on or off.
    /// 
    /// - parameters:
    ///     - status: Status value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func turnEngineOnOff(status: AAOnOffState) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.status, value: status))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Activate or deactivate the Start-Stop system of the engine. When activated, this will automatically shut down and restart the internal combustion engine when the vehicle is stopped.
    /// 
    /// - parameters:
    ///     - startStopEnabled: Indicates if the automatic start-stop system is enabled or not.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func enableDisableStartStop(startStopEnabled: AAEnabledState) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.startStopEnabled, value: startStopEnabled))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        limpMode = extract(property: .limpMode)
        preconditioningActive = extract(property: .preconditioningActive)
        preconditioningEnabled = extract(property: .preconditioningEnabled)
        preconditioningError = extract(property: .preconditioningError)
        preconditioningRemainingTime = extract(property: .preconditioningRemainingTime)
        preconditioningStatus = extract(property: .preconditioningStatus)
        startStopEnabled = extract(property: .startStopEnabled)
        startStopState = extract(property: .startStopState)
        status = extract(property: .status)
    }
}
