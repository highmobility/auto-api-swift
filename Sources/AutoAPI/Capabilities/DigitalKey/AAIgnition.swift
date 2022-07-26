import Foundation
import HMUtilities

public final class AAIgnition: AACapability, AAPropertyIdentifying {
    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAIgnition` was introduced to the spec.
        public static let intro: UInt8 = 3
    
        /// Level (version) of *AutoAPI* when `AAIgnition` was last updated.
        public static let updated: UInt8 = 12
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0035 }

    /// Property identifiers for `AAIgnition`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case state = 0x03
    }

    // MARK: Properties
    /// State value.
    public var state: AAProperty<AAIgnitionState>?
    // Deprecated/// Accessories status value.
    ///
    /// - warning: This property is deprecated in favour of *state*.
    @available(*, deprecated, renamed: "state", message: "combined with 'status'")
    public var accessoriesStatus: AAProperty<AAIgnitionState>? {
        state
    }
    
    /// Status value.
    ///
    /// - warning: This property is deprecated in favour of *state*.
    @available(*, deprecated, renamed: "state", message: "combined with 'accessories_status'")
    public var status: AAProperty<AAIgnitionState>? {
        state
    }

    // MARK: Getters
    /// Get `AAIgnition` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getIgnitionState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AAIgnition` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getIgnitionStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }

    // MARK: Setters
    /// Attempt to turn the vehicle engine ignition on or off. When the engine ignition is on, it is possible for the driver to turn on the engine and drive the vehicle.
    /// 
    /// - parameters:
    ///     - state: State value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func turnIgnitionOnOff(state: AAIgnitionState) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.state, value: state))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        state = extract(property: .state)
    }
}
