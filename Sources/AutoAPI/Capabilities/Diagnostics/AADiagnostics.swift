import Foundation
import HMUtilities

public final class AADiagnostics: AACapability, AAPropertyIdentifying {
    public typealias FuelLevelAccuracy = AADiagnosticsFuelLevelAccuracy
    public typealias EngineOilPressureLevel = AADiagnosticsEngineOilPressureLevel
    public typealias LowVoltageBatteryChargeLevel = AADiagnosticsLowVoltageBatteryChargeLevel

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AADiagnostics` was introduced to the spec.
        public static let intro: UInt8 = 3
    
        /// Level (version) of *AutoAPI* when `AADiagnostics` was last updated.
        public static let updated: UInt8 = 13
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0033 }

    /// Property identifiers for `AADiagnostics`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case engineOilTemperature = 0x02
        case speed = 0x03
        case engineRPM = 0x04
        case fuelLevel = 0x05
        case estimatedRange = 0x06
        case washerFluidLevel = 0x09
        case batteryVoltage = 0x0b
        case adBlueLevel = 0x0c
        case distanceSinceReset = 0x0d
        case distanceSinceStart = 0x0e
        case fuelVolume = 0x0f
        case antiLockBraking = 0x10
        case engineCoolantTemperature = 0x11
        case engineTotalFuelConsumption = 0x13
        case brakeFluidLevel = 0x14
        case engineTorque = 0x15
        case engineLoad = 0x16
        case wheelBasedSpeed = 0x17
        case batteryLevel = 0x18
        case checkControlMessages = 0x19
        case tirePressures = 0x1a
        case tireTemperatures = 0x1b
        case wheelRPMs = 0x1c
        case troubleCodes = 0x1d
        case odometer = 0x1f
        case engineTotalOperatingTime = 0x20
        case tirePressureStatuses = 0x21
        case brakeLiningWearPreWarning = 0x22
        case engineOilLifeRemaining = 0x23
        case oemTroubleCodeValues = 0x24
        case dieselExhaustFluidRange = 0x25
        case dieselParticulateFilterSootLevel = 0x26
        case confirmedTroubleCodes = 0x27
        case dieselExhaustFilterStatus = 0x28
        case engineTotalIdleOperatingTime = 0x2a
        case engineOilAmount = 0x2b
        case engineOilLevel = 0x2c
        case estimatedSecondaryPowertrainRange = 0x2d
        case fuelLevelAccuracy = 0x2e
        case tirePressuresTargets = 0x2f
        case tirePressuresDifferences = 0x30
        case backupBatteryRemainingTime = 0x31
        case engineCoolantFluidLevel = 0x32
        case engineOilFluidLevel = 0x33
        case engineOilPressureLevel = 0x34
        case engineTimeToNextService = 0x35
        case lowVoltageBatteryChargeLevel = 0x36
        case engineOilServiceStatus = 0x37
        case passengerAirbagStatus = 0x38
    }

    // MARK: Properties
    /// AdBlue level percentage between 0.0-1.0.
    public var adBlueLevel: AAProperty<AAPercentage>?
    
    /// Anti-lock braking system (ABS) value.
    public var antiLockBraking: AAProperty<AAActiveState>?
    
    /// Remaining time the backup battery can work..
    public var backupBatteryRemainingTime: AAProperty<Measurement<UnitDuration>>?
    
    /// Battery level in %, value between 0.0 and 1.0.
    public var batteryLevel: AAProperty<AAPercentage>?
    
    /// Battery voltage.
    public var batteryVoltage: AAProperty<Measurement<UnitElectricPotentialDifference>>?
    
    /// Brake fluid level value.
    public var brakeFluidLevel: AAProperty<AAFluidLevel>?
    
    /// Status of brake lining wear pre-warning.
    public var brakeLiningWearPreWarning: AAProperty<AAActiveState>?
    
    /// Check control messages value.
    public var checkControlMessages: [AAProperty<AACheckControlMessage>]?
    
    /// Confirmed trouble codes value.
    public var confirmedTroubleCodes: [AAProperty<AAConfirmedTroubleCode>]?
    
    /// Diesel exhaust filter status value.
    public var dieselExhaustFilterStatus: [AAProperty<AADieselExhaustFilterStatus>]?
    
    /// Distance remaining until diesel exhaust fluid is empty.
    public var dieselExhaustFluidRange: AAProperty<Measurement<UnitLength>>?
    
    /// Level of soot in diesel exhaust particulate filter.
    public var dieselParticulateFilterSootLevel: AAProperty<AAPercentage>?
    
    /// The distance driven since reset.
    public var distanceSinceReset: AAProperty<Measurement<UnitLength>>?
    
    /// The distance driven since trip start.
    public var distanceSinceStart: AAProperty<Measurement<UnitLength>>?
    
    /// Engine coolant fluid level.
    public var engineCoolantFluidLevel: AAProperty<AAFluidLevel>?
    
    /// Engine coolant temperature.
    public var engineCoolantTemperature: AAProperty<Measurement<UnitTemperature>>?
    
    /// Current engine load percentage between 0.0-1.0.
    public var engineLoad: AAProperty<AAPercentage>?
    
    /// The current estimated oil tank liquid fill..
    public var engineOilAmount: AAProperty<Measurement<UnitVolume>>?
    
    /// Engine oil fluid level.
    public var engineOilFluidLevel: AAProperty<AAFluidLevel>?
    
    /// The current estimated oil tank liquid fill in percentage..
    public var engineOilLevel: AAProperty<AAPercentage>?
    
    /// Remaining life of engine oil which decreases over time.
    public var engineOilLifeRemaining: AAProperty<AAPercentage>?
    
    /// Engine oil pressure level.
    public var engineOilPressureLevel: AAProperty<EngineOilPressureLevel>?
    
    /// Engine oil service status.
    public var engineOilServiceStatus: AAProperty<AAServiceStatus>?
    
    /// Engine oil temperature.
    public var engineOilTemperature: AAProperty<Measurement<UnitTemperature>>?
    
    /// Engine RPM (revolutions per minute).
    public var engineRPM: AAProperty<Measurement<UnitAngularVelocity>>?
    
    /// Engine time until next service of the vehicle.
    public var engineTimeToNextService: AAProperty<Measurement<UnitDuration>>?
    
    /// Current engine torque percentage between 0.0-1.0.
    public var engineTorque: AAProperty<AAPercentage>?
    
    /// The accumulated lifespan fuel consumption.
    public var engineTotalFuelConsumption: AAProperty<Measurement<UnitVolume>>?
    
    /// The accumulated time of engine operation.
    public var engineTotalIdleOperatingTime: AAProperty<Measurement<UnitDuration>>?
    
    /// The accumulated time of engine operation.
    public var engineTotalOperatingTime: AAProperty<Measurement<UnitDuration>>?
    
    /// Estimated range (with combustion engine).
    public var estimatedRange: AAProperty<Measurement<UnitLength>>?
    
    /// Estimated secondary powertrain range.
    public var estimatedSecondaryPowertrainRange: AAProperty<Measurement<UnitLength>>?
    
    /// Fuel level percentage between 0.0-1.0.
    public var fuelLevel: AAProperty<AAPercentage>?
    
    /// This value includes the information, if the fuel level has been calculated or measured..
    public var fuelLevelAccuracy: AAProperty<FuelLevelAccuracy>?
    
    /// The fuel volume measured in liters.
    public var fuelVolume: AAProperty<Measurement<UnitVolume>>?
    
    /// Indicates if the charge level of the low voltage battery is too low to use other systems.
    public var lowVoltageBatteryChargeLevel: AAProperty<LowVoltageBatteryChargeLevel>?
    
    /// The vehicle odometer value in a given units.
    public var odometer: AAProperty<Measurement<UnitLength>>?
    
    /// Additional OEM trouble codes.
    public var oemTroubleCodeValues: [AAProperty<AAOemTroubleCodeValue>]?
    
    /// Passenger airbag is activated or not.
    public var passengerAirbagStatus: AAProperty<AAActiveState>?
    
    /// The vehicle speed.
    public var speed: AAProperty<Measurement<UnitSpeed>>?
    
    /// Tire pressure statuses value.
    public var tirePressureStatuses: [AAProperty<AATirePressureStatus>]?
    
    /// Tire pressures value.
    public var tirePressures: [AAProperty<AATirePressure>]?
    
    /// Tire pressures difference from the target pressure..
    public var tirePressuresDifferences: [AAProperty<AATirePressure>]?
    
    /// Target tire pressures for the vehicle..
    public var tirePressuresTargets: [AAProperty<AATirePressure>]?
    
    /// Tire temperatures value.
    public var tireTemperatures: [AAProperty<AATireTemperature>]?
    
    /// Trouble codes value.
    public var troubleCodes: [AAProperty<AATroubleCode>]?
    
    /// Washer fluid level value.
    public var washerFluidLevel: AAProperty<AAFluidLevel>?
    
    /// The vehicle speed measured at the wheel base.
    public var wheelBasedSpeed: AAProperty<Measurement<UnitSpeed>>?
    
    /// Wheel RPMs value.
    public var wheelRPMs: [AAProperty<AAWheelRPM>]?
    // Deprecated/// The accumulated time of engine operation.
    ///
    /// - warning: This property is deprecated in favour of *engineTotalOperatingTime*.
    @available(*, deprecated, renamed: "engineTotalOperatingTime", message: "removed the unit from the name")
    public var engineTotalOperatingHours: AAProperty<Measurement<UnitDuration>>? {
        engineTotalOperatingTime
    }
    
    /// The vehicle mileage (odometer).
    ///
    /// - warning: This property is deprecated in favour of *odometer*.
    @available(*, deprecated, renamed: "odometer", message: "'mileage' is an incorrect term for this")
    public var mileage: AAProperty<Measurement<UnitLength>>? {
        odometer
    }
    
    /// The vehicle mileage (odometer) in meters.
    ///
    /// - warning: This property is deprecated in favour of *odometer*.
    @available(*, deprecated, renamed: "odometer", message: "'mileage' is an incorrect term for this")
    public var mileageMeters: AAProperty<Measurement<UnitLength>>? {
        odometer
    }

    // MARK: Getters
    /// Get `AADiagnostics` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getDiagnosticsState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AADiagnostics` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getDiagnosticsStateProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getDiagnosticsState() + ids.map { $0.rawValue }
    }
    
    /// Get `AADiagnostics` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getDiagnosticsStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AADiagnostics` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getDiagnosticsStatePropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getDiagnosticsStateAvailability() + ids.map { $0.rawValue }
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        adBlueLevel = extract(property: .adBlueLevel)
        antiLockBraking = extract(property: .antiLockBraking)
        backupBatteryRemainingTime = extract(property: .backupBatteryRemainingTime)
        batteryLevel = extract(property: .batteryLevel)
        batteryVoltage = extract(property: .batteryVoltage)
        brakeFluidLevel = extract(property: .brakeFluidLevel)
        brakeLiningWearPreWarning = extract(property: .brakeLiningWearPreWarning)
        checkControlMessages = extract(properties: .checkControlMessages)
        confirmedTroubleCodes = extract(properties: .confirmedTroubleCodes)
        dieselExhaustFilterStatus = extract(properties: .dieselExhaustFilterStatus)
        dieselExhaustFluidRange = extract(property: .dieselExhaustFluidRange)
        dieselParticulateFilterSootLevel = extract(property: .dieselParticulateFilterSootLevel)
        distanceSinceReset = extract(property: .distanceSinceReset)
        distanceSinceStart = extract(property: .distanceSinceStart)
        engineCoolantFluidLevel = extract(property: .engineCoolantFluidLevel)
        engineCoolantTemperature = extract(property: .engineCoolantTemperature)
        engineLoad = extract(property: .engineLoad)
        engineOilAmount = extract(property: .engineOilAmount)
        engineOilFluidLevel = extract(property: .engineOilFluidLevel)
        engineOilLevel = extract(property: .engineOilLevel)
        engineOilLifeRemaining = extract(property: .engineOilLifeRemaining)
        engineOilPressureLevel = extract(property: .engineOilPressureLevel)
        engineOilServiceStatus = extract(property: .engineOilServiceStatus)
        engineOilTemperature = extract(property: .engineOilTemperature)
        engineRPM = extract(property: .engineRPM)
        engineTimeToNextService = extract(property: .engineTimeToNextService)
        engineTorque = extract(property: .engineTorque)
        engineTotalFuelConsumption = extract(property: .engineTotalFuelConsumption)
        engineTotalIdleOperatingTime = extract(property: .engineTotalIdleOperatingTime)
        engineTotalOperatingTime = extract(property: .engineTotalOperatingTime)
        estimatedRange = extract(property: .estimatedRange)
        estimatedSecondaryPowertrainRange = extract(property: .estimatedSecondaryPowertrainRange)
        fuelLevel = extract(property: .fuelLevel)
        fuelLevelAccuracy = extract(property: .fuelLevelAccuracy)
        fuelVolume = extract(property: .fuelVolume)
        lowVoltageBatteryChargeLevel = extract(property: .lowVoltageBatteryChargeLevel)
        odometer = extract(property: .odometer)
        oemTroubleCodeValues = extract(properties: .oemTroubleCodeValues)
        passengerAirbagStatus = extract(property: .passengerAirbagStatus)
        speed = extract(property: .speed)
        tirePressureStatuses = extract(properties: .tirePressureStatuses)
        tirePressures = extract(properties: .tirePressures)
        tirePressuresDifferences = extract(properties: .tirePressuresDifferences)
        tirePressuresTargets = extract(properties: .tirePressuresTargets)
        tireTemperatures = extract(properties: .tireTemperatures)
        troubleCodes = extract(properties: .troubleCodes)
        washerFluidLevel = extract(property: .washerFluidLevel)
        wheelBasedSpeed = extract(property: .wheelBasedSpeed)
        wheelRPMs = extract(properties: .wheelRPMs)
    }
}
