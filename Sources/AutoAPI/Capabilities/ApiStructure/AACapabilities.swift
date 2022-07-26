import Foundation
import HMUtilities

public final class AACapabilities: AACapability, AAPropertyIdentifying {
    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AACapabilities` was introduced to the spec.
        public static let intro: UInt8 = 2
    
        /// Level (version) of *AutoAPI* when `AACapabilities` was last updated.
        public static let updated: UInt8 = 12
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0010 }

    /// Property identifiers for `AACapabilities`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case capabilities = 0x01
        case webhooks = 0x02
    }

    // MARK: Properties
    /// Capabilities value.
    public var capabilities: [AAProperty<AASupportedCapability>]?
    
    /// Webhooks value.
    public var webhooks: [AAProperty<AAWebhook>]?

    // MARK: Getters
    /// Get `AACapabilities` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getCapabilities() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AACapabilities` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getCapabilitiesProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getCapabilities() + ids.map { $0.rawValue }
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        capabilities = extract(properties: .capabilities)
        webhooks = extract(properties: .webhooks)
    }
}
