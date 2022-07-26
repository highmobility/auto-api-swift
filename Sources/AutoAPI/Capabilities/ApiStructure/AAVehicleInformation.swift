import Foundation
import HMUtilities

public final class AAVehicleInformation: AACapability, AAPropertyIdentifying {
    public typealias Gearbox = AAVehicleInformationGearbox
    public typealias DisplayUnit = AAVehicleInformationDisplayUnit
    public typealias DriverSeatLocation = AAVehicleInformationDriverSeatLocation
    public typealias Timeformat = AAVehicleInformationTimeformat
    public typealias Drive = AAVehicleInformationDrive
    public typealias DataQuality = AAVehicleInformationDataQuality
    public typealias TimeZone = AAVehicleInformationTimeZone

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAVehicleInformation` was introduced to the spec.
        public static let intro: UInt8 = 12
    
        /// Level (version) of *AutoAPI* when `AAVehicleInformation` was last updated.
        public static let updated: UInt8 = 13
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0014 }

    /// Property identifiers for `AAVehicleInformation`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case powertrain = 0x02
        case modelName = 0x03
        case name = 0x04
        case licensePlate = 0x05
        case salesDesignation = 0x06
        case modelYear = 0x07
        case colourName = 0x08
        case numberOfDoors = 0x0a
        case numberOfSeats = 0x0b
        case engineVolume = 0x0c
        case engineMaxTorque = 0x0d
        case gearbox = 0x0e
        case displayUnit = 0x0f
        case driverSeatLocation = 0x10
        case equipments = 0x11
        case power = 0x13
        case language = 0x14
        case timeformat = 0x15
        case drive = 0x16
        case powertrainSecondary = 0x17
        case fuelTankCapacity = 0x18
        case buildDate = 0x19
        case countryCode = 0x1a
        case modelKey = 0x1b
        case dataQuality = 0x1c
        case extraEquipmentCodes = 0x1d
        case series = 0x1e
        case lastDataTransferDate = 0x1f
        case timeZone = 0x20
        case vehicleMass = 0x21
    }

    // MARK: Properties
    /// Build (construction) date of the vehicle..
    public var buildDate: AAProperty<Date>?
    
    /// The colour name.
    public var colourName: AAProperty<String>?
    
    /// The country code of the vehicle..
    public var countryCode: AAProperty<String>?
    
    /// Evaluation of the timeliness of the available vehicle data..
    public var dataQuality: AAProperty<DataQuality>?
    
    /// Display unit value.
    public var displayUnit: AAProperty<DisplayUnit>?
    
    /// Wheels driven by the engine.
    public var drive: AAProperty<Drive>?
    
    /// Driver seat location value.
    public var driverSeatLocation: AAProperty<DriverSeatLocation>?
    
    /// The maximum engine torque.
    public var engineMaxTorque: AAProperty<Measurement<UnitTorque>>?
    
    /// The engine volume displacement.
    public var engineVolume: AAProperty<Measurement<UnitVolume>>?
    
    /// Names of equipment the vehicle is equipped with.
    public var equipments: [AAProperty<String>]?
    
    /// Codes of the extra equipment the vehicle has.
    public var extraEquipmentCodes: [AAProperty<String>]?
    
    /// The fuel tank capacity measured in liters.
    public var fuelTankCapacity: AAProperty<Measurement<UnitVolume>>?
    
    /// Gearbox value.
    public var gearbox: AAProperty<Gearbox>?
    
    /// The language on headunit.
    public var language: AAProperty<String>?
    
    /// The last trip date.
    public var lastDataTransferDate: AAProperty<Date>?
    
    /// The license plate number.
    public var licensePlate: AAProperty<String>?
    
    /// The model key of the vehicle..
    public var modelKey: AAProperty<String>?
    
    /// The vehicle model name.
    public var modelName: AAProperty<String>?
    
    /// The vehicle model manufacturing year number.
    public var modelYear: AAProperty<UInt16>?
    
    /// The vehicle name (nickname).
    public var name: AAProperty<String>?
    
    /// The number of doors.
    public var numberOfDoors: AAProperty<UInt8>?
    
    /// The number of seats.
    public var numberOfSeats: AAProperty<UInt8>?
    
    /// The power of the vehicle.
    public var power: AAProperty<Measurement<UnitPower>>?
    
    /// Type of the (primary) powertrain.
    public var powertrain: AAProperty<AAEngineType>?
    
    /// Powertrain secondary value.
    public var powertrainSecondary: AAProperty<AAEngineType>?
    
    /// The sales designation of the model.
    public var salesDesignation: AAProperty<String>?
    
    /// The vehicle model's series.
    public var series: AAProperty<String>?
    
    /// Time zone setting in the vehicle..
    public var timeZone: AAProperty<TimeZone>?
    
    /// The timeformat on headunit.
    public var timeformat: AAProperty<Timeformat>?
    
    /// Vehicle mass..
    public var vehicleMass: AAProperty<Measurement<UnitMass>>?
    // Deprecated/// The power of the vehicle.
    ///
    /// - warning: This property is deprecated in favour of *power*.
    @available(*, deprecated, renamed: "power", message: "removed the unit from the name")
    public var powerInKW: AAProperty<Measurement<UnitPower>>? {
        power
    }

    // MARK: Getters
    /// Get `AAVehicleInformation` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getVehicleInformation() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AAVehicleInformation` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getVehicleInformationProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getVehicleInformation() + ids.map { $0.rawValue }
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        buildDate = extract(property: .buildDate)
        colourName = extract(property: .colourName)
        countryCode = extract(property: .countryCode)
        dataQuality = extract(property: .dataQuality)
        displayUnit = extract(property: .displayUnit)
        drive = extract(property: .drive)
        driverSeatLocation = extract(property: .driverSeatLocation)
        engineMaxTorque = extract(property: .engineMaxTorque)
        engineVolume = extract(property: .engineVolume)
        equipments = extract(properties: .equipments)
        extraEquipmentCodes = extract(properties: .extraEquipmentCodes)
        fuelTankCapacity = extract(property: .fuelTankCapacity)
        gearbox = extract(property: .gearbox)
        language = extract(property: .language)
        lastDataTransferDate = extract(property: .lastDataTransferDate)
        licensePlate = extract(property: .licensePlate)
        modelKey = extract(property: .modelKey)
        modelName = extract(property: .modelName)
        modelYear = extract(property: .modelYear)
        name = extract(property: .name)
        numberOfDoors = extract(property: .numberOfDoors)
        numberOfSeats = extract(property: .numberOfSeats)
        power = extract(property: .power)
        powertrain = extract(property: .powertrain)
        powertrainSecondary = extract(property: .powertrainSecondary)
        salesDesignation = extract(property: .salesDesignation)
        series = extract(property: .series)
        timeZone = extract(property: .timeZone)
        timeformat = extract(property: .timeformat)
        vehicleMass = extract(property: .vehicleMass)
    }
}
