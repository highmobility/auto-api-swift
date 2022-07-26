import Foundation
import HMUtilities

public final class AATrips: AACapability, AAPropertyIdentifying {
    public typealias TypeOf = AATripsType
    public typealias Event = AATripsEvent
    public typealias EcoLevel = AATripsEcoLevel
    public typealias RoadType = AATripsRoadType

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AATrips` was introduced to the spec.
        public static let intro: UInt8 = 12
    
        /// Level (version) of *AutoAPI* when `AATrips` was last updated.
        public static let updated: UInt8 = 13
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x006A }

    /// Property identifiers for `AATrips`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case type = 0x01
        case driverName = 0x02
        case description = 0x03
        case startTime = 0x04
        case endTime = 0x05
        case startAddress = 0x06
        case endAddress = 0x07
        case startCoordinates = 0x08
        case endCoordinates = 0x09
        case startOdometer = 0x0a
        case endOdometer = 0x0b
        case averageFuelConsumption = 0x0c
        case distance = 0x0d
        case startAddressComponents = 0x0e
        case endAddressComponents = 0x0f
        case event = 0x10
        case ecoLevel = 0x11
        case thresholds = 0x12
        case totalFuelConsumption = 0x13
        case totalIdleFuelConsumption = 0x14
        case maximumSpeed = 0x15
        case roadType = 0x16
    }

    // MARK: Properties
    /// Average fuel consumption during the trip.
    public var averageFuelConsumption: AAProperty<Measurement<UnitFuelEfficiency>>?
    
    /// Description of the trip.
    public var description: AAProperty<String>?
    
    /// Distance of the trip.
    public var distance: AAProperty<Measurement<UnitLength>>?
    
    /// Name of the driver of the trip.
    public var driverName: AAProperty<String>?
    
    /// Eco level value.
    public var ecoLevel: AAProperty<EcoLevel>?
    
    /// End address of the trip.
    public var endAddress: AAProperty<String>?
    
    /// End address components.
    public var endAddressComponents: [AAProperty<AAAddressComponent>]?
    
    /// End coordinates of the trip.
    public var endCoordinates: AAProperty<AACoordinates>?
    
    /// Odometer reading at the end of the trip.
    public var endOdometer: AAProperty<Measurement<UnitLength>>?
    
    /// End time of the trip.
    public var endTime: AAProperty<Date>?
    
    /// Event value.
    public var event: AAProperty<Event>?
    
    /// Maximum speed recorded since the last igntion on..
    public var maximumSpeed: AAProperty<Measurement<UnitSpeed>>?
    
    /// Type of road travelled on..
    public var roadType: AAProperty<RoadType>?
    
    /// Start address of the trip.
    public var startAddress: AAProperty<String>?
    
    /// Start address components.
    public var startAddressComponents: [AAProperty<AAAddressComponent>]?
    
    /// Start coordinates of the trip.
    public var startCoordinates: AAProperty<AACoordinates>?
    
    /// Odometer reading at the start of the trip.
    public var startOdometer: AAProperty<Measurement<UnitLength>>?
    
    /// Start time of the trip.
    public var startTime: AAProperty<Date>?
    
    /// Eco driving thresholds.
    public var thresholds: [AAProperty<AAEcoDrivingThreshold>]?
    
    /// Total fuel consumption during the trip.
    public var totalFuelConsumption: AAProperty<Measurement<UnitVolume>>?
    
    /// Fuel consumed while idle since the last ignition on..
    public var totalIdleFuelConsumption: AAProperty<Measurement<UnitVolume>>?
    
    /// Type of the trip.
    public var type: AAProperty<TypeOf>?

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        averageFuelConsumption = extract(property: .averageFuelConsumption)
        description = extract(property: .description)
        distance = extract(property: .distance)
        driverName = extract(property: .driverName)
        ecoLevel = extract(property: .ecoLevel)
        endAddress = extract(property: .endAddress)
        endAddressComponents = extract(properties: .endAddressComponents)
        endCoordinates = extract(property: .endCoordinates)
        endOdometer = extract(property: .endOdometer)
        endTime = extract(property: .endTime)
        event = extract(property: .event)
        maximumSpeed = extract(property: .maximumSpeed)
        roadType = extract(property: .roadType)
        startAddress = extract(property: .startAddress)
        startAddressComponents = extract(properties: .startAddressComponents)
        startCoordinates = extract(property: .startCoordinates)
        startOdometer = extract(property: .startOdometer)
        startTime = extract(property: .startTime)
        thresholds = extract(properties: .thresholds)
        totalFuelConsumption = extract(property: .totalFuelConsumption)
        totalIdleFuelConsumption = extract(property: .totalIdleFuelConsumption)
        type = extract(property: .type)
    }
}
