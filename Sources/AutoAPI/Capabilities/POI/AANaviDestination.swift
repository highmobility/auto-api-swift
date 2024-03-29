import Foundation
import HMUtilities

public final class AANaviDestination: AACapability, AAPropertyIdentifying {
    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AANaviDestination` was introduced to the spec.
        public static let intro: UInt8 = 4
    
        /// Level (version) of *AutoAPI* when `AANaviDestination` was last updated.
        public static let updated: UInt8 = 12
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0031 }

    /// Property identifiers for `AANaviDestination`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case coordinates = 0x01
        case destinationName = 0x02
        case dataSlotsFree = 0x03
        case dataSlotsMax = 0x04
        case arrivalDuration = 0x05
        case distanceToDestination = 0x06
    }

    // MARK: Properties
    /// Remaining time until reaching the destination..
    public var arrivalDuration: AAProperty<Measurement<UnitDuration>>?
    
    /// Coordinates value.
    public var coordinates: AAProperty<AACoordinates>?
    
    /// Remaining number of POI data slots available..
    public var dataSlotsFree: AAProperty<UInt8>?
    
    /// Maximum number of POI data slots..
    public var dataSlotsMax: AAProperty<UInt8>?
    
    /// Destination name.
    public var destinationName: AAProperty<String>?
    
    /// Remaining distance to reach the destination..
    public var distanceToDestination: AAProperty<Measurement<UnitLength>>?

    // MARK: Getters
    /// Get `AANaviDestination` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getNaviDestination() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AANaviDestination` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getNaviDestinationProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getNaviDestination() + ids.map { $0.rawValue }
    }
    
    /// Get `AANaviDestination` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getNaviDestinationAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AANaviDestination` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getNaviDestinationPropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getNaviDestinationAvailability() + ids.map { $0.rawValue }
    }

    // MARK: Setters
    /// Set the navigation destination. This will be forwarded to the navigation system of the vehicle.
    /// 
    /// - parameters:
    ///     - coordinates: Coordinates value.
    ///     - destinationName: Destination name.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func setNaviDestination(coordinates: AACoordinates, destinationName: String? = nil) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.coordinates, value: coordinates))
        properties.append(AAProperty(id: PropertyIdentifier.destinationName, value: destinationName))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        arrivalDuration = extract(property: .arrivalDuration)
        coordinates = extract(property: .coordinates)
        dataSlotsFree = extract(property: .dataSlotsFree)
        dataSlotsMax = extract(property: .dataSlotsMax)
        destinationName = extract(property: .destinationName)
        distanceToDestination = extract(property: .distanceToDestination)
    }
}
