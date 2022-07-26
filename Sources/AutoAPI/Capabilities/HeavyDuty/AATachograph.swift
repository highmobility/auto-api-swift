import Foundation
import HMUtilities

public final class AATachograph: AACapability, AAPropertyIdentifying {
    public typealias VehicleOverspeed = AATachographVehicleOverspeed
    public typealias VehicleDirection = AATachographVehicleDirection

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AATachograph` was introduced to the spec.
        public static let intro: UInt8 = 7
    
        /// Level (version) of *AutoAPI* when `AATachograph` was last updated.
        public static let updated: UInt8 = 12
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0064 }

    /// Property identifiers for `AATachograph`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case driversWorkingStates = 0x01
        case driversTimeStates = 0x02
        case driversCardsPresent = 0x03
        case vehicleMotion = 0x04
        case vehicleOverspeed = 0x05
        case vehicleDirection = 0x06
        case vehicleSpeed = 0x07
    }

    // MARK: Properties
    /// Drivers cards present value.
    public var driversCardsPresent: [AAProperty<AADriverCardPresent>]?
    
    /// Drivers time states value.
    public var driversTimeStates: [AAProperty<AADriverTimeState>]?
    
    /// Drivers working states value.
    public var driversWorkingStates: [AAProperty<AADriverWorkingState>]?
    
    /// Vehicle direction value.
    public var vehicleDirection: AAProperty<VehicleDirection>?
    
    /// Vehicle motion value.
    public var vehicleMotion: AAProperty<AADetected>?
    
    /// Vehicle overspeed value.
    public var vehicleOverspeed: AAProperty<VehicleOverspeed>?
    
    /// The tachograph vehicle speed.
    public var vehicleSpeed: AAProperty<Measurement<UnitSpeed>>?

    // MARK: Getters
    /// Get `AATachograph` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getTachographState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AATachograph` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getTachographStateProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getTachographState() + ids.map { $0.rawValue }
    }
    
    /// Get `AATachograph` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getTachographStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AATachograph` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getTachographStatePropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getTachographStateAvailability() + ids.map { $0.rawValue }
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        driversCardsPresent = extract(properties: .driversCardsPresent)
        driversTimeStates = extract(properties: .driversTimeStates)
        driversWorkingStates = extract(properties: .driversWorkingStates)
        vehicleDirection = extract(property: .vehicleDirection)
        vehicleMotion = extract(property: .vehicleMotion)
        vehicleOverspeed = extract(property: .vehicleOverspeed)
        vehicleSpeed = extract(property: .vehicleSpeed)
    }
}
