import Foundation
import HMUtilities

public final class AAClimate: AACapability, AAPropertyIdentifying {
    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAClimate` was introduced to the spec.
        public static let intro: UInt8 = 2
    
        /// Level (version) of *AutoAPI* when `AAClimate` was last updated.
        public static let updated: UInt8 = 12
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0024 }

    /// Property identifiers for `AAClimate`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case insideTemperature = 0x01
        case outsideTemperature = 0x02
        case driverTemperatureSetting = 0x03
        case passengerTemperatureSetting = 0x04
        case hvacState = 0x05
        case defoggingState = 0x06
        case defrostingState = 0x07
        case ionisingState = 0x08
        case defrostingTemperatureSetting = 0x09
        case hvacWeekdayStartingTimes = 0x0b
        case rearTemperatureSetting = 0x0c
        case humidity = 0x0d
        case airConditionerCompressorPower = 0x0e
    }

    // MARK: Properties
    /// Electric air conditioner compressor power..
    public var airConditionerCompressorPower: AAProperty<Measurement<UnitPower>>?
    
    /// Defogging state value.
    public var defoggingState: AAProperty<AAActiveState>?
    
    /// Defrosting state value.
    public var defrostingState: AAProperty<AAActiveState>?
    
    /// The defrosting temperature setting.
    public var defrostingTemperatureSetting: AAProperty<Measurement<UnitTemperature>>?
    
    /// The driver temperature setting.
    public var driverTemperatureSetting: AAProperty<Measurement<UnitTemperature>>?
    
    /// Measured relative humidity between 0.0 - 1.0..
    public var humidity: AAProperty<AAPercentage>?
    
    /// HVAC state value.
    public var hvacState: AAProperty<AAActiveState>?
    
    /// HVAC weekday starting times value.
    public var hvacWeekdayStartingTimes: [AAProperty<AAWeekdayTime>]?
    
    /// The inside temperature.
    public var insideTemperature: AAProperty<Measurement<UnitTemperature>>?
    
    /// Ionising state value.
    public var ionisingState: AAProperty<AAActiveState>?
    
    /// The outside temperature.
    public var outsideTemperature: AAProperty<Measurement<UnitTemperature>>?
    
    /// The passenger temperature setting.
    public var passengerTemperatureSetting: AAProperty<Measurement<UnitTemperature>>?
    
    /// The rear temperature.
    public var rearTemperatureSetting: AAProperty<Measurement<UnitTemperature>>?

    // MARK: Getters
    /// Get `AAClimate` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getClimateState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AAClimate` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getClimateStateProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getClimateState() + ids.map { $0.rawValue }
    }
    
    /// Get `AAClimate` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getClimateStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AAClimate` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getClimateStatePropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getClimateStateAvailability() + ids.map { $0.rawValue }
    }

    // MARK: Setters
    /// Set the HVAC (Heating, ventilation, and air conditioning) automated starting times.
    /// 
    /// - parameters:
    ///     - hvacWeekdayStartingTimes: HVAC weekday starting times value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func changeStartingTimes(hvacWeekdayStartingTimes: [AAWeekdayTime]) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(contentsOf: hvacWeekdayStartingTimes.compactMap { AAProperty(id: PropertyIdentifier.hvacWeekdayStartingTimes, value: $0) })
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Start or stop the HVAC system to reach driver and passenger set temperatures. The vehicle will use cooling, defrosting and defogging as appropriate.
    /// 
    /// - parameters:
    ///     - hvacState: HVAC state value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func startStopHvac(hvacState: AAActiveState) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.hvacState, value: hvacState))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Manually start or stop defogging.
    /// 
    /// - parameters:
    ///     - defoggingState: Defogging state value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func startStopDefogging(defoggingState: AAActiveState) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.defoggingState, value: defoggingState))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Manually start or stop defrosting.
    /// 
    /// - parameters:
    ///     - defrostingState: Defrosting state value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func startStopDefrosting(defrostingState: AAActiveState) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.defrostingState, value: defrostingState))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Manually start or stop ionising.
    /// 
    /// - parameters:
    ///     - ionisingState: Ionising state value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func startStopIonising(ionisingState: AAActiveState) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.ionisingState, value: ionisingState))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Set the preferred temperature settings.
    /// 
    /// - parameters:
    ///     - driverTemperatureSetting: The driver temperature setting.
    ///     - passengerTemperatureSetting: The passenger temperature setting.
    ///     - rearTemperatureSetting: The rear temperature.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func setTemperatureSettings(driverTemperatureSetting: Measurement<UnitTemperature>? = nil, passengerTemperatureSetting: Measurement<UnitTemperature>? = nil, rearTemperatureSetting: Measurement<UnitTemperature>? = nil) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.driverTemperatureSetting, value: driverTemperatureSetting))
        properties.append(AAProperty(id: PropertyIdentifier.passengerTemperatureSetting, value: passengerTemperatureSetting))
        properties.append(AAProperty(id: PropertyIdentifier.rearTemperatureSetting, value: rearTemperatureSetting))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        airConditionerCompressorPower = extract(property: .airConditionerCompressorPower)
        defoggingState = extract(property: .defoggingState)
        defrostingState = extract(property: .defrostingState)
        defrostingTemperatureSetting = extract(property: .defrostingTemperatureSetting)
        driverTemperatureSetting = extract(property: .driverTemperatureSetting)
        humidity = extract(property: .humidity)
        hvacState = extract(property: .hvacState)
        hvacWeekdayStartingTimes = extract(properties: .hvacWeekdayStartingTimes)
        insideTemperature = extract(property: .insideTemperature)
        ionisingState = extract(property: .ionisingState)
        outsideTemperature = extract(property: .outsideTemperature)
        passengerTemperatureSetting = extract(property: .passengerTemperatureSetting)
        rearTemperatureSetting = extract(property: .rearTemperatureSetting)
    }
}
