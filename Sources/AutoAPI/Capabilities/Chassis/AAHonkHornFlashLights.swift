import Foundation
import HMUtilities

public final class AAHonkHornFlashLights: AACapability, AAPropertyIdentifying {
    public typealias Flashers = AAHonkHornFlashLightsFlashers

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAHonkHornFlashLights` was introduced to the spec.
        public static let intro: UInt8 = 2
    
        /// Level (version) of *AutoAPI* when `AAHonkHornFlashLights` was last updated.
        public static let updated: UInt8 = 12
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0026 }

    /// Property identifiers for `AAHonkHornFlashLights`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case flashers = 0x01
        case flashTimes = 0x03		// Non-state property (can't be retrieved)
        case emergencyFlashersState = 0x04		// Non-state property (can't be retrieved)
        case honkTime = 0x05		// Non-state property (can't be retrieved)
    }

    // MARK: Properties
    /// Flashers value.
    public var flashers: AAProperty<Flashers>?

    // MARK: Getters
    /// Get `AAHonkHornFlashLights` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getFlashersState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AAHonkHornFlashLights` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getFlashersStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }

    // MARK: Setters
    /// Honk the horn and/or flash the blinker lights. This can be done simultaneously or just one action at the time. It is also possible to pass in how many times the lights should be flashed and how many seconds the horn should be honked.
    /// 
    /// - parameters:
    ///     - flashTimes: Number of times to flash the lights.
    ///     - honkTime: Time to honk the horn.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func honkFlash(flashTimes: UInt8? = nil, honkTime: Measurement<UnitDuration>? = nil) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.flashTimes, value: flashTimes))
        properties.append(AAProperty(id: PropertyIdentifier.honkTime, value: honkTime))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// This activates or deactivates the emergency flashers of the vehicle, typically the blinkers to alarm other drivers.
    /// 
    /// - parameters:
    ///     - emergencyFlashersState: Emergency flasher state value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func activateDeactivateEmergencyFlasher(emergencyFlashersState: AAActiveState) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.emergencyFlashersState, value: emergencyFlashersState))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        flashers = extract(property: .flashers)
    }
}
