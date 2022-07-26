import Foundation
import HMUtilities

public final class AAVehicleLocation: AACapability, AAPropertyIdentifying {
    public typealias GpsSource = AAVehicleLocationGpsSource

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAVehicleLocation` was introduced to the spec.
        public static let intro: UInt8 = 2
    
        /// Level (version) of *AutoAPI* when `AAVehicleLocation` was last updated.
        public static let updated: UInt8 = 13
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0030 }

    /// Property identifiers for `AAVehicleLocation`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case coordinates = 0x04
        case heading = 0x05
        case altitude = 0x06
        case precision = 0x07
        case gpsSource = 0x08
        case gpsSignalStrength = 0x09
        case fuzzyCoordinates = 0x0a
    }

    // MARK: Properties
    /// Altitude above the WGS 84 reference ellipsoid.
    public var altitude: AAProperty<Measurement<UnitLength>>?
    
    /// Coordinates value.
    public var coordinates: AAProperty<AACoordinates>?
    
    /// Fuzzy coordinates for the vehicle location..
    public var fuzzyCoordinates: AAProperty<AACoordinates>?
    
    /// GPS signal strength percentage between 0.0-1.0.
    public var gpsSignalStrength: AAProperty<AAPercentage>?
    
    /// Type of GPS source.
    public var gpsSource: AAProperty<GpsSource>?
    
    /// Heading angle.
    public var heading: AAProperty<Measurement<UnitAngle>>?
    
    /// Precision value.
    public var precision: AAProperty<Measurement<UnitLength>>?

    // MARK: Getters
    /// Get `AAVehicleLocation` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getVehicleLocation() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AAVehicleLocation` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getVehicleLocationProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getVehicleLocation() + ids.map { $0.rawValue }
    }
    
    /// Get `AAVehicleLocation` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getVehicleLocationAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AAVehicleLocation` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getVehicleLocationPropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getVehicleLocationAvailability() + ids.map { $0.rawValue }
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        altitude = extract(property: .altitude)
        coordinates = extract(property: .coordinates)
        fuzzyCoordinates = extract(property: .fuzzyCoordinates)
        gpsSignalStrength = extract(property: .gpsSignalStrength)
        gpsSource = extract(property: .gpsSource)
        heading = extract(property: .heading)
        precision = extract(property: .precision)
    }
}
