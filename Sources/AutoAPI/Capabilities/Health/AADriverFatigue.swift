import Foundation
import HMUtilities

public final class AADriverFatigue: AACapability, AAPropertyIdentifying {
    public typealias DetectedFatigueLevel = AADriverFatigueDetectedFatigueLevel

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AADriverFatigue` was introduced to the spec.
        public static let intro: UInt8 = 4
    
        /// Level (version) of *AutoAPI* when `AADriverFatigue` was last updated.
        public static let updated: UInt8 = 11
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0041 }

    /// Property identifiers for `AADriverFatigue`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case detectedFatigueLevel = 0x01
    }

    // MARK: Properties
    /// Detected fatigue level value.
    public var detectedFatigueLevel: AAProperty<DetectedFatigueLevel>?

    // MARK: Getters
    /// Get `AADriverFatigue` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getDriverFatigueState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AADriverFatigue` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getDriverFatigueStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        detectedFatigueLevel = extract(property: .detectedFatigueLevel)
    }
}
