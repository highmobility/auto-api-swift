import Foundation
import HMUtilities

public final class AAKeyfobPosition: AACapability, AAPropertyIdentifying {
    public typealias Location = AAKeyfobPositionLocation

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAKeyfobPosition` was introduced to the spec.
        public static let intro: UInt8 = 4
    
        /// Level (version) of *AutoAPI* when `AAKeyfobPosition` was last updated.
        public static let updated: UInt8 = 11
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0048 }

    /// Property identifiers for `AAKeyfobPosition`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case location = 0x01
    }

    // MARK: Properties
    /// Location value.
    public var location: AAProperty<Location>?

    // MARK: Getters
    /// Get `AAKeyfobPosition` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getKeyfobPosition() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AAKeyfobPosition` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getKeyfobPositionAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        location = extract(property: .location)
    }
}
