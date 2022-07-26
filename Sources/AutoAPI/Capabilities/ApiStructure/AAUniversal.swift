import Foundation
import HMUtilities

public final class AAUniversal: AACapability, AAPropertyIdentifying {
    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAUniversal` was introduced to the spec.
        public static let intro: UInt8 = 13
    
        /// Level (version) of *AutoAPI* when `AAUniversal` was last updated.
        public static let updated: UInt8 = 13
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0015 }

    /// Property identifiers for `AAUniversal`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case vin = 0xa3
        case brand = 0xa4
    }

    // MARK: Getters
    /// Get `AAUniversal` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getUniversalProperties() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
}
