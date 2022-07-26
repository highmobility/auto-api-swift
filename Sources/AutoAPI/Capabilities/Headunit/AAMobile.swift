import Foundation
import HMUtilities

public final class AAMobile: AACapability, AAPropertyIdentifying {
    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAMobile` was introduced to the spec.
        public static let intro: UInt8 = 8
    
        /// Level (version) of *AutoAPI* when `AAMobile` was last updated.
        public static let updated: UInt8 = 11
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0066 }

    /// Property identifiers for `AAMobile`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case connection = 0x01
    }

    // MARK: Properties
    /// Connection value.
    public var connection: AAProperty<AAConnectionState>?

    // MARK: Getters
    /// Get `AAMobile` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getMobileState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AAMobile` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getMobileStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        connection = extract(property: .connection)
    }
}
