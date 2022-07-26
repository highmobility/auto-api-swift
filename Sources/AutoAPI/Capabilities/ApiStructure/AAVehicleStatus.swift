import Foundation
import HMUtilities

public final class AAVehicleStatus: AACapability, AAPropertyIdentifying {
    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAVehicleStatus` was introduced to the spec.
        public static let intro: UInt8 = 2
    
        /// Level (version) of *AutoAPI* when `AAVehicleStatus` was last updated.
        public static let updated: UInt8 = 12
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0011 }

    /// Property identifiers for `AAVehicleStatus`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case states = 0x99
    }

    // MARK: Properties
    /// The bytes of a Capability state.
    public var states: [AAProperty<AACapabilityState>]?

    // MARK: Getters
    /// Get `AAVehicleStatus` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getVehicleStatus() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        states = extract(properties: .states)
    }
}
