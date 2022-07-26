import Foundation
import HMUtilities

public final class AAFirmwareVersion: AACapability, AAPropertyIdentifying {
    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAFirmwareVersion` was introduced to the spec.
        public static let intro: UInt8 = 4
    
        /// Level (version) of *AutoAPI* when `AAFirmwareVersion` was last updated.
        public static let updated: UInt8 = 11
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0003 }

    /// Property identifiers for `AAFirmwareVersion`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case hmKitVersion = 0x01
        case hmKitBuildName = 0x02
        case applicationVersion = 0x03
    }

    // MARK: Properties
    /// Application version.
    public var applicationVersion: AAProperty<String>?
    
    /// HMKit version build name.
    public var hmKitBuildName: AAProperty<String>?
    
    /// HMKit version.
    public var hmKitVersion: AAProperty<AAHMKitVersion>?

    // MARK: Getters
    /// Get `AAFirmwareVersion` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getFirmwareVersion() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AAFirmwareVersion` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getFirmwareVersionProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getFirmwareVersion() + ids.map { $0.rawValue }
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        applicationVersion = extract(property: .applicationVersion)
        hmKitBuildName = extract(property: .hmKitBuildName)
        hmKitVersion = extract(property: .hmKitVersion)
    }
}
