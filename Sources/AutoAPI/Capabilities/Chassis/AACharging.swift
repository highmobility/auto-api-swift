import Foundation
import HMUtilities

public final class AACharging: AACapability, AAPropertyIdentifying {
    public typealias ChargeMode = AAChargingChargeMode
    public typealias PlugType = AAChargingPlugType
    public typealias ChargingWindowChosen = AAChargingChargingWindowChosen
    public typealias PluggedIn = AAChargingPluggedIn
    public typealias Status = AAChargingStatus
    public typealias CurrentType = AAChargingCurrentType
    public typealias StarterBatteryState = AAChargingStarterBatteryState
    public typealias SmartChargingStatus = AAChargingSmartChargingStatus
    public typealias PreconditioningError = AAChargingPreconditioningError
    public typealias ChargingEndReason = AAChargingChargingEndReason
    public typealias ChargingPhases = AAChargingChargingPhases
    public typealias ChargingTimeDisplay = AAChargingChargingTimeDisplay
    public typealias DepartureTimeDisplay = AAChargingDepartureTimeDisplay
    public typealias SmartChargingOption = AAChargingSmartChargingOption
    public typealias AcousticLimit = AAChargingAcousticLimit
    public typealias BatteryTemperatureControlDemand = AAChargingBatteryTemperatureControlDemand
    public typealias BatteryStatus = AAChargingBatteryStatus
    public typealias BatteryLed = AAChargingBatteryLed
    public typealias BatteryChargeType = AAChargingBatteryChargeType

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AACharging` was introduced to the spec.
        public static let intro: UInt8 = 2
    
        /// Level (version) of *AutoAPI* when `AACharging` was last updated.
        public static let updated: UInt8 = 12
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0023 }

    /// Property identifiers for `AACharging`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case estimatedRange = 0x02
        case batteryLevel = 0x03
        case chargeLimit = 0x08
        case timeToCompleteCharge = 0x09
        case chargePortState = 0x0b
        case chargeMode = 0x0c
        case maxChargingCurrent = 0x0e
        case plugType = 0x0f
        case chargingWindowChosen = 0x10
        case departureTimes = 0x11
        case reductionTimes = 0x13
        case batteryTemperature = 0x14
        case timers = 0x15
        case pluggedIn = 0x16
        case status = 0x17
        case chargingRate = 0x18
        case batteryCurrent = 0x19
        case chargerVoltage = 0x1a
        case currentType = 0x1b
        case maxRange = 0x1c
        case starterBatteryState = 0x1d
        case smartChargingStatus = 0x1e
        case batteryLevelAtDeparture = 0x1f
        case preconditioningDepartureStatus = 0x20
        case preconditioningImmediateStatus = 0x21
        case preconditioningDepartureEnabled = 0x22
        case preconditioningError = 0x23
        case batteryCapacity = 0x24
        case auxiliaryPower = 0x25
        case chargingCompleteLock = 0x26
        case batteryMaxAvailable = 0x27
        case chargingEndReason = 0x28
        case chargingPhases = 0x29
        case batteryEnergy = 0x2a
        case batteryEnergyChargable = 0x2b
        case chargingSingleImmediate = 0x2c
        case chargingTimeDisplay = 0x2d
        case departureTimeDisplay = 0x2e
        case restriction = 0x2f
        case limitStatus = 0x30
        case currentLimit = 0x31
        case smartChargingOption = 0x32
        case plugLockStatus = 0x33
        case flapLockStatus = 0x34
        case acousticLimit = 0x35
        case minChargingCurrent = 0x36
        case estimatedRangeTarget = 0x37
        case fullyChargedEndTimes = 0x38
        case preconditioningScheduledTime = 0x39
        case preconditioningRemainingTime = 0x3a
        case batteryVoltage = 0x3b
        case batteryTemperatureControlDemand = 0x3d
        case chargingCurrent = 0x3e
        case batteryStatus = 0x3f
        case batteryLed = 0x40
        case batteryCoolingTemperature = 0x41
        case batteryTemperatureExtremes = 0x42
        case drivingModePHEV = 0x43
        case batteryChargeType = 0x44
        case distanceToCompleteCharge = 0x45
    }

    // MARK: Properties
    /// Acoustic limitation of charging process..
    public var acousticLimit: AAProperty<AcousticLimit>?
    
    /// Auxiliary power used for predictions..
    public var auxiliaryPower: AAProperty<Measurement<UnitPower>>?
    
    /// Indicates the battery capacity.
    public var batteryCapacity: AAProperty<Measurement<UnitEnergy>>?
    
    /// Battery charge type..
    public var batteryChargeType: AAProperty<BatteryChargeType>?
    
    /// Battery cooling temperature..
    public var batteryCoolingTemperature: AAProperty<Measurement<UnitTemperature>>?
    
    /// Battery current - charging if posititive and discharning when negative..
    public var batteryCurrent: AAProperty<Measurement<UnitElectricCurrent>>?
    
    /// Energy content of the high-voltage battery..
    public var batteryEnergy: AAProperty<Measurement<UnitEnergy>>?
    
    /// Energy required until high-voltage battery is fully charged..
    public var batteryEnergyChargable: AAProperty<Measurement<UnitEnergy>>?
    
    /// State of LED for the battery..
    public var batteryLed: AAProperty<BatteryLed>?
    
    /// Battery level percentage between 0.0-1.0.
    public var batteryLevel: AAProperty<AAPercentage>?
    
    /// Battery charge level expected at time of departure.
    public var batteryLevelAtDeparture: AAProperty<AAPercentage>?
    
    /// Maximum available energy content of the high-voltage battery..
    public var batteryMaxAvailable: AAProperty<Measurement<UnitEnergy>>?
    
    /// Battery state..
    public var batteryStatus: AAProperty<BatteryStatus>?
    
    /// Battery temperature.
    public var batteryTemperature: AAProperty<Measurement<UnitTemperature>>?
    
    /// Current demand of HV battery temperature control system..
    public var batteryTemperatureControlDemand: AAProperty<BatteryTemperatureControlDemand>?
    
    /// Current highest-lowest temperature inside the battery..
    public var batteryTemperatureExtremes: AAProperty<AATemperatureExtreme>?
    
    /// High-voltage battery electric potential difference (aka voltage)..
    public var batteryVoltage: AAProperty<Measurement<UnitElectricPotentialDifference>>?
    
    /// Charge limit percentage between 0.0-1.0.
    public var chargeLimit: AAProperty<AAPercentage>?
    
    /// Charge mode value.
    public var chargeMode: AAProperty<ChargeMode>?
    
    /// Charge port state value.
    public var chargePortState: AAProperty<AAPosition>?
    
    /// Charger voltage.
    public var chargerVoltage: AAProperty<Measurement<UnitElectricPotentialDifference>>?
    
    /// Locking status of the charging plug after charging complete..
    public var chargingCompleteLock: AAProperty<AAActiveState>?
    
    /// Charging electric current..
    public var chargingCurrent: AAProperty<Measurement<UnitElectricCurrent>>?
    
    /// Reason for ending a charging process..
    public var chargingEndReason: AAProperty<ChargingEndReason>?
    
    /// Charging process count of the high-voltage battery (phases)..
    public var chargingPhases: AAProperty<ChargingPhases>?
    
    /// Charge rate when charging.
    public var chargingRate: AAProperty<Measurement<UnitPower>>?
    
    /// Single instant charging function status..
    public var chargingSingleImmediate: AAProperty<AAActiveState>?
    
    /// Charging time displayed in the vehicle..
    public var chargingTimeDisplay: AAProperty<ChargingTimeDisplay>?
    
    /// Charging window chosen value.
    public var chargingWindowChosen: AAProperty<ChargingWindowChosen>?
    
    /// Limit for the charging current..
    public var currentLimit: AAProperty<Measurement<UnitElectricCurrent>>?
    
    /// Type of current in use.
    public var currentType: AAProperty<CurrentType>?
    
    /// Departure time displayed in the vehicle..
    public var departureTimeDisplay: AAProperty<DepartureTimeDisplay>?
    
    /// Departure times value.
    public var departureTimes: [AAProperty<AADepartureTime>]?
    
    /// Distance until charging completed.
    public var distanceToCompleteCharge: AAProperty<Measurement<UnitLength>>?
    
    /// Indicates the current driving mode for Plug-In Hybrid Vehicle..
    public var drivingModePHEV: AAProperty<AADrivingModePHEV>?
    
    /// Estimated range.
    public var estimatedRange: AAProperty<Measurement<UnitLength>>?
    
    /// Remaining electric range depending on target charging status..
    public var estimatedRangeTarget: AAProperty<Measurement<UnitLength>>?
    
    /// Locking status of charging flap..
    public var flapLockStatus: AAProperty<AALockState>?
    
    /// Time and weekday when the vehicle will be fully charged..
    public var fullyChargedEndTimes: AAProperty<AAWeekdayTime>?
    
    /// Indicates whether charging limit is active..
    public var limitStatus: AAProperty<AAActiveState>?
    
    /// Maximum charging current.
    public var maxChargingCurrent: AAProperty<Measurement<UnitElectricCurrent>>?
    
    /// Maximum electric range with 100% of battery.
    public var maxRange: AAProperty<Measurement<UnitLength>>?
    
    /// Minimum charging current..
    public var minChargingCurrent: AAProperty<Measurement<UnitElectricCurrent>>?
    
    /// Locking status of charging plug..
    public var plugLockStatus: AAProperty<AALockState>?
    
    /// Plug type value.
    public var plugType: AAProperty<PlugType>?
    
    /// Plugged in value.
    public var pluggedIn: AAProperty<PluggedIn>?
    
    /// Preconditioning activation status at departure.
    public var preconditioningDepartureEnabled: AAProperty<AAEnabledState>?
    
    /// Status of preconditioning at departure time.
    public var preconditioningDepartureStatus: AAProperty<AAActiveState>?
    
    /// Preconditioning error if one is encountered.
    public var preconditioningError: AAProperty<PreconditioningError>?
    
    /// Status of immediate preconditioning.
    public var preconditioningImmediateStatus: AAProperty<AAActiveState>?
    
    /// Time until preconditioning is complete..
    public var preconditioningRemainingTime: AAProperty<Measurement<UnitDuration>>?
    
    /// Preconditioning scheduled departure time..
    public var preconditioningScheduledTime: AAProperty<AATime>?
    
    /// Reduction of charging times value.
    public var reductionTimes: [AAProperty<AAReductionTime>]?
    
    /// Charging limit and state.
    public var restriction: AAProperty<AAChargingRestriction>?
    
    /// Smart charging option being used to charge with..
    public var smartChargingOption: AAProperty<SmartChargingOption>?
    
    /// Status of optimized/intelligent charging.
    public var smartChargingStatus: AAProperty<SmartChargingStatus>?
    
    /// State of the starter battery.
    public var starterBatteryState: AAProperty<StarterBatteryState>?
    
    /// Status value.
    public var status: AAProperty<Status>?
    
    /// Time until charging completed.
    public var timeToCompleteCharge: AAProperty<Measurement<UnitDuration>>?
    
    /// Timers value.
    public var timers: [AAProperty<AATimer>]?
    // Deprecated/// Battery alternating current.
    ///
    /// - warning: This property is deprecated in favour of *batteryCurrent*.
    @available(*, deprecated, renamed: "batteryCurrent", message: "moved AC/DC distinction into a separate property")
    public var batteryCurrentAC: AAProperty<Measurement<UnitElectricCurrent>>? {
        batteryCurrent
    }
    
    /// Battery direct current.
    ///
    /// - warning: This property is deprecated in favour of *batteryCurrent*.
    @available(*, deprecated, renamed: "batteryCurrent", message: "moved AC/DC distinction into a separate property")
    public var batteryCurrentDC: AAProperty<Measurement<UnitElectricCurrent>>? {
        batteryCurrent
    }
    
    /// Current highest-lowest temperature inside the battery..
    ///
    /// - warning: This property is deprecated in favour of *batteryTemperatureExtremes*.
    @available(*, deprecated, renamed: "batteryTemperatureExtremes", message: "fixed the name typo")
    public var batteryTempretatureExtremes: AAProperty<AATemperatureExtreme>? {
        batteryTemperatureExtremes
    }
    
    /// Charger voltage for alternating current.
    ///
    /// - warning: This property is deprecated in favour of *chargerVoltage*.
    @available(*, deprecated, renamed: "chargerVoltage", message: "moved AC/DC distinction into a separate property")
    public var chargerVoltageAC: AAProperty<Measurement<UnitElectricPotentialDifference>>? {
        chargerVoltage
    }
    
    /// Charger voltage for direct current.
    ///
    /// - warning: This property is deprecated in favour of *chargerVoltage*.
    @available(*, deprecated, renamed: "chargerVoltage", message: "moved AC/DC distinction into a separate property")
    public var chargerVoltageDC: AAProperty<Measurement<UnitElectricPotentialDifference>>? {
        chargerVoltage
    }
    
    /// Charging rate.
    ///
    /// - warning: This property is deprecated in favour of *chargingRate*.
    @available(*, deprecated, renamed: "chargingRate", message: "removed the unit from the name")
    public var chargingRateKW: AAProperty<Measurement<UnitPower>>? {
        chargingRate
    }

    // MARK: Getters
    /// Get `AACharging` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getChargingState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AACharging` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getChargingStateProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getChargingState() + ids.map { $0.rawValue }
    }
    
    /// Get `AACharging` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getChargingStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AACharging` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getChargingStatePropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getChargingStateAvailability() + ids.map { $0.rawValue }
    }

    // MARK: Setters
    /// Start or stop charging, which can only be controlled when the vehicle is plugged in.
    /// 
    /// - parameters:
    ///     - status: Status value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func startStopCharging(status: Status) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.status, value: status))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Set the charge limit, to which point the vehicle will charge itself.
    /// 
    /// - parameters:
    ///     - chargeLimit: Charge limit percentage between 0.0-1.0.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func setChargeLimit(chargeLimit: AAPercentage) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.chargeLimit, value: chargeLimit))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Open or close the charge port of the vehicle.
    /// 
    /// - parameters:
    ///     - chargePortState: Charge port state value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func openCloseChargingPort(chargePortState: AAPosition) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.chargePortState, value: chargePortState))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Set the charge mode of the vehicle.
    /// 
    /// - parameters:
    ///     - chargeMode: Charge mode value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func setChargeMode(chargeMode: ChargeMode) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.chargeMode, value: chargeMode))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Set the charging timers of the vehicle. The command can include one of the different timer types or all.
    /// 
    /// - parameters:
    ///     - timers: Timers value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func setChargingTimers(timers: [AATimer]) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(contentsOf: timers.compactMap { AAProperty(id: PropertyIdentifier.timers, value: $0) })
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Set the reduction of charging times of the vehicle. The command can include different values for start and stop.
    /// 
    /// - parameters:
    ///     - reductionTimes: Reduction of charging times value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func setReductionOfChargingCurrentTimes(reductionTimes: [AAReductionTime]) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(contentsOf: reductionTimes.compactMap { AAProperty(id: PropertyIdentifier.reductionTimes, value: $0) })
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        acousticLimit = extract(property: .acousticLimit)
        auxiliaryPower = extract(property: .auxiliaryPower)
        batteryCapacity = extract(property: .batteryCapacity)
        batteryChargeType = extract(property: .batteryChargeType)
        batteryCoolingTemperature = extract(property: .batteryCoolingTemperature)
        batteryCurrent = extract(property: .batteryCurrent)
        batteryEnergy = extract(property: .batteryEnergy)
        batteryEnergyChargable = extract(property: .batteryEnergyChargable)
        batteryLed = extract(property: .batteryLed)
        batteryLevel = extract(property: .batteryLevel)
        batteryLevelAtDeparture = extract(property: .batteryLevelAtDeparture)
        batteryMaxAvailable = extract(property: .batteryMaxAvailable)
        batteryStatus = extract(property: .batteryStatus)
        batteryTemperature = extract(property: .batteryTemperature)
        batteryTemperatureControlDemand = extract(property: .batteryTemperatureControlDemand)
        batteryTemperatureExtremes = extract(property: .batteryTemperatureExtremes)
        batteryVoltage = extract(property: .batteryVoltage)
        chargeLimit = extract(property: .chargeLimit)
        chargeMode = extract(property: .chargeMode)
        chargePortState = extract(property: .chargePortState)
        chargerVoltage = extract(property: .chargerVoltage)
        chargingCompleteLock = extract(property: .chargingCompleteLock)
        chargingCurrent = extract(property: .chargingCurrent)
        chargingEndReason = extract(property: .chargingEndReason)
        chargingPhases = extract(property: .chargingPhases)
        chargingRate = extract(property: .chargingRate)
        chargingSingleImmediate = extract(property: .chargingSingleImmediate)
        chargingTimeDisplay = extract(property: .chargingTimeDisplay)
        chargingWindowChosen = extract(property: .chargingWindowChosen)
        currentLimit = extract(property: .currentLimit)
        currentType = extract(property: .currentType)
        departureTimeDisplay = extract(property: .departureTimeDisplay)
        departureTimes = extract(properties: .departureTimes)
        distanceToCompleteCharge = extract(property: .distanceToCompleteCharge)
        drivingModePHEV = extract(property: .drivingModePHEV)
        estimatedRange = extract(property: .estimatedRange)
        estimatedRangeTarget = extract(property: .estimatedRangeTarget)
        flapLockStatus = extract(property: .flapLockStatus)
        fullyChargedEndTimes = extract(property: .fullyChargedEndTimes)
        limitStatus = extract(property: .limitStatus)
        maxChargingCurrent = extract(property: .maxChargingCurrent)
        maxRange = extract(property: .maxRange)
        minChargingCurrent = extract(property: .minChargingCurrent)
        plugLockStatus = extract(property: .plugLockStatus)
        plugType = extract(property: .plugType)
        pluggedIn = extract(property: .pluggedIn)
        preconditioningDepartureEnabled = extract(property: .preconditioningDepartureEnabled)
        preconditioningDepartureStatus = extract(property: .preconditioningDepartureStatus)
        preconditioningError = extract(property: .preconditioningError)
        preconditioningImmediateStatus = extract(property: .preconditioningImmediateStatus)
        preconditioningRemainingTime = extract(property: .preconditioningRemainingTime)
        preconditioningScheduledTime = extract(property: .preconditioningScheduledTime)
        reductionTimes = extract(properties: .reductionTimes)
        restriction = extract(property: .restriction)
        smartChargingOption = extract(property: .smartChargingOption)
        smartChargingStatus = extract(property: .smartChargingStatus)
        starterBatteryState = extract(property: .starterBatteryState)
        status = extract(property: .status)
        timeToCompleteCharge = extract(property: .timeToCompleteCharge)
        timers = extract(properties: .timers)
    }
}
