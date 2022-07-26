import Foundation
import HMUtilities

public final class AASeats: AACapability, AAPropertyIdentifying {
    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AASeats` was introduced to the spec.
        public static let intro: UInt8 = 5
    
        /// Level (version) of *AutoAPI* when `AASeats` was last updated.
        public static let updated: UInt8 = 11
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0056 }

    /// Property identifiers for `AASeats`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case personsDetected = 0x02
        case seatbeltsState = 0x03
    }

    // MARK: Properties
    /// Persons detected value.
    public var personsDetected: [AAProperty<AAPersonDetected>]?
    
    /// Seatbelts state value.
    public var seatbeltsState: [AAProperty<AASeatbeltState>]?

    // MARK: Getters
    /// Get `AASeats` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getSeatsState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AASeats` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getSeatsStateProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getSeatsState() + ids.map { $0.rawValue }
    }
    
    /// Get `AASeats` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getSeatsStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AASeats` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getSeatsStatePropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getSeatsStateAvailability() + ids.map { $0.rawValue }
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        personsDetected = extract(properties: .personsDetected)
        seatbeltsState = extract(properties: .seatbeltsState)
    }
}
