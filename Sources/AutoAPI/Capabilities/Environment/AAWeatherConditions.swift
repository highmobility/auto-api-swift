import Foundation
import HMUtilities

public final class AAWeatherConditions: AACapability, AAPropertyIdentifying {
    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAWeatherConditions` was introduced to the spec.
        public static let intro: UInt8 = 5
    
        /// Level (version) of *AutoAPI* when `AAWeatherConditions` was last updated.
        public static let updated: UInt8 = 11
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0055 }

    /// Property identifiers for `AAWeatherConditions`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case rainIntensity = 0x01
    }

    // MARK: Properties
    /// Measured raining intensity percentage, whereas 0% is no rain and 100% is maximum rain.
    public var rainIntensity: AAProperty<AAPercentage>?

    // MARK: Getters
    /// Get `AAWeatherConditions` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getWeatherConditions() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AAWeatherConditions` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getWeatherConditionsAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        rainIntensity = extract(property: .rainIntensity)
    }
}
