import Foundation
import HMUtilities

public final class AAUsage: AACapability, AAPropertyIdentifying {
    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAUsage` was introduced to the spec.
        public static let intro: UInt8 = 8
    
        /// Level (version) of *AutoAPI* when `AAUsage` was last updated.
        public static let updated: UInt8 = 13
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0068 }

    /// Property identifiers for `AAUsage`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case averageWeeklyDistance = 0x01
        case averageWeeklyDistanceLongRun = 0x02
        case accelerationEvaluation = 0x03
        case drivingStyleEvaluation = 0x04
        case drivingModesActivationPeriods = 0x05
        case drivingModesEnergyConsumptions = 0x06
        case lastTripEnergyConsumption = 0x07
        case lastTripFuelConsumption = 0x08
        case lastTripElectricPortion = 0x0a
        case lastTripAverageEnergyRecuperation = 0x0b
        case lastTripBatteryRemaining = 0x0c
        case lastTripDate = 0x0d
        case averageFuelConsumption = 0x0e
        case currentFuelConsumption = 0x0f
        case odometerAfterLastTrip = 0x10
        case safetyDrivingScore = 0x11
        case rapidAccelerationGrade = 0x12
        case rapidDecelerationGrade = 0x13
        case lateNightGrade = 0x14
        case distanceOverTime = 0x15
        case electricConsumptionRateSinceStart = 0x16
        case electricConsumptionRateSinceReset = 0x17
        case electricDistanceLastTrip = 0x18
        case electricDistanceSinceReset = 0x19
        case electricDurationLastTrip = 0x1a
        case electricDurationSinceReset = 0x1b
        case fuelConsumptionRateLastTrip = 0x1c
        case fuelConsumptionRateSinceReset = 0x1d
        case averageSpeedLastTrip = 0x1e
        case averageSpeedSinceReset = 0x1f
        case fuelDistanceLastTrip = 0x20
        case fuelDistanceSinceReset = 0x21
        case drivingDurationLastTrip = 0x22
        case drivingDurationSinceReset = 0x23
        case ecoScoreTotal = 0x24
        case ecoScoreFreeWheel = 0x25
        case ecoScoreConstant = 0x26
        case ecoScoreBonusRange = 0x27
        case tripMeters = 0x28
        case electricConsumptionAverage = 0x29
        case brakingEvaluation = 0x2a
        case averageSpeed = 0x2b
        case recuperationPower = 0x2c
        case accelerationDurations = 0x2d
    }

    // MARK: Properties
    /// Durations of normal or other accelerations..
    public var accelerationDurations: [AAProperty<AAAccelerationDuration>]?
    
    /// Acceleration evaluation percentage.
    public var accelerationEvaluation: AAProperty<AAPercentage>?
    
    /// Average fuel consumption for current trip.
    public var averageFuelConsumption: AAProperty<Measurement<UnitFuelEfficiency>>?
    
    /// Average speed at data collection..
    public var averageSpeed: AAProperty<Measurement<UnitSpeed>>?
    
    /// Average speed during last trip.
    public var averageSpeedLastTrip: AAProperty<Measurement<UnitSpeed>>?
    
    /// Average speed since reset.
    public var averageSpeedSinceReset: AAProperty<Measurement<UnitSpeed>>?
    
    /// Average weekly distance.
    public var averageWeeklyDistance: AAProperty<Measurement<UnitLength>>?
    
    /// Average weekyl distance over long term.
    public var averageWeeklyDistanceLongRun: AAProperty<Measurement<UnitLength>>?
    
    /// Braking evaluation percentage.
    public var brakingEvaluation: AAProperty<AAPercentage>?
    
    /// Current fuel consumption.
    public var currentFuelConsumption: AAProperty<Measurement<UnitFuelEfficiency>>?
    
    /// Distance driven over a given time period.
    public var distanceOverTime: AAProperty<AADistanceOverTime>?
    
    /// Duration of last trip.
    public var drivingDurationLastTrip: AAProperty<Measurement<UnitDuration>>?
    
    /// Duration of travelling since reset.
    public var drivingDurationSinceReset: AAProperty<Measurement<UnitDuration>>?
    
    /// Driving modes activation periods value.
    public var drivingModesActivationPeriods: [AAProperty<AADrivingModeActivationPeriod>]?
    
    /// Driving modes energy consumptions value.
    public var drivingModesEnergyConsumptions: [AAProperty<AADrivingModeEnergyConsumption>]?
    
    /// Driving style evaluation percentage.
    public var drivingStyleEvaluation: AAProperty<AAPercentage>?
    
    /// Eco-score bonus range.
    public var ecoScoreBonusRange: AAProperty<Measurement<UnitLength>>?
    
    /// Eco-score rating constant.
    public var ecoScoreConstant: AAProperty<AAPercentage>?
    
    /// Eco-score rating for free-wheeling.
    public var ecoScoreFreeWheel: AAProperty<AAPercentage>?
    
    /// Overall eco-score rating.
    public var ecoScoreTotal: AAProperty<AAPercentage>?
    
    /// Average electric energy consumption calculated based on the last 20km.
    public var electricConsumptionAverage: AAProperty<Measurement<UnitEnergyEfficiency>>?
    
    /// Electric energy consumption rate since a reset.
    public var electricConsumptionRateSinceReset: AAProperty<Measurement<UnitEnergyEfficiency>>?
    
    /// Electric energy consumption rate since the start of a trip.
    public var electricConsumptionRateSinceStart: AAProperty<Measurement<UnitEnergyEfficiency>>?
    
    /// Distance travelled with electricity in last trip.
    public var electricDistanceLastTrip: AAProperty<Measurement<UnitLength>>?
    
    /// Distance travelled with electricity since reset.
    public var electricDistanceSinceReset: AAProperty<Measurement<UnitLength>>?
    
    /// Duration of travelling using electricity during last trip.
    public var electricDurationLastTrip: AAProperty<Measurement<UnitDuration>>?
    
    /// Duration of travelling using electricity since reset.
    public var electricDurationSinceReset: AAProperty<Measurement<UnitDuration>>?
    
    /// Liquid fuel consumption rate during last trip.
    public var fuelConsumptionRateLastTrip: AAProperty<Measurement<UnitFuelEfficiency>>?
    
    /// Liquid fuel consumption rate since reset.
    public var fuelConsumptionRateSinceReset: AAProperty<Measurement<UnitFuelEfficiency>>?
    
    /// Distance travelled with (liquid) fuel during last trip.
    public var fuelDistanceLastTrip: AAProperty<Measurement<UnitLength>>?
    
    /// Distance travelled with (liquid) fuel since reset.
    public var fuelDistanceSinceReset: AAProperty<Measurement<UnitLength>>?
    
    /// Energy recuperation rate for last trip.
    public var lastTripAverageEnergyRecuperation: AAProperty<Measurement<UnitEnergyEfficiency>>?
    
    /// Battery % remaining after last trip.
    public var lastTripBatteryRemaining: AAProperty<AAPercentage>?
    
    /// The last trip date.
    public var lastTripDate: AAProperty<Date>?
    
    /// Portion of the last trip used in electric mode.
    public var lastTripElectricPortion: AAProperty<AAPercentage>?
    
    /// Energy consumption in the last trip.
    public var lastTripEnergyConsumption: AAProperty<Measurement<UnitEnergy>>?
    
    /// Fuel consumption in the last trip.
    public var lastTripFuelConsumption: AAProperty<Measurement<UnitVolume>>?
    
    /// Grade given for late night driving over time.
    public var lateNightGrade: AAProperty<AAGrade>?
    
    /// Odometer after the last trip.
    public var odometerAfterLastTrip: AAProperty<Measurement<UnitLength>>?
    
    /// Grade given for rapid acceleration over time.
    public var rapidAccelerationGrade: AAProperty<AAGrade>?
    
    /// Grade given for rapid deceleration over time.
    public var rapidDecelerationGrade: AAProperty<AAGrade>?
    
    /// Recuperation energy of the drivetrain..
    public var recuperationPower: AAProperty<Measurement<UnitPower>>?
    
    /// Safety driving score as percentage.
    public var safetyDrivingScore: AAProperty<AAPercentage>?
    
    /// Independent meter that can be reset at any time by the driver.
    public var tripMeters: [AAProperty<AATripMeter>]?
    // Deprecated/// Mileage after the last trip.
    ///
    /// - warning: This property is deprecated in favour of *odometerAfterLastTrip*.
    @available(*, deprecated, renamed: "odometerAfterLastTrip", message: "'mileage' is an incorrect term for this")
    public var mileageAfterLastTrip: AAProperty<Measurement<UnitLength>>? {
        odometerAfterLastTrip
    }

    // MARK: Getters
    /// Get `AAUsage` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getUsage() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AAUsage` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getUsageProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getUsage() + ids.map { $0.rawValue }
    }
    
    /// Get `AAUsage` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getUsageAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AAUsage` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getUsagePropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getUsageAvailability() + ids.map { $0.rawValue }
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        accelerationDurations = extract(properties: .accelerationDurations)
        accelerationEvaluation = extract(property: .accelerationEvaluation)
        averageFuelConsumption = extract(property: .averageFuelConsumption)
        averageSpeed = extract(property: .averageSpeed)
        averageSpeedLastTrip = extract(property: .averageSpeedLastTrip)
        averageSpeedSinceReset = extract(property: .averageSpeedSinceReset)
        averageWeeklyDistance = extract(property: .averageWeeklyDistance)
        averageWeeklyDistanceLongRun = extract(property: .averageWeeklyDistanceLongRun)
        brakingEvaluation = extract(property: .brakingEvaluation)
        currentFuelConsumption = extract(property: .currentFuelConsumption)
        distanceOverTime = extract(property: .distanceOverTime)
        drivingDurationLastTrip = extract(property: .drivingDurationLastTrip)
        drivingDurationSinceReset = extract(property: .drivingDurationSinceReset)
        drivingModesActivationPeriods = extract(properties: .drivingModesActivationPeriods)
        drivingModesEnergyConsumptions = extract(properties: .drivingModesEnergyConsumptions)
        drivingStyleEvaluation = extract(property: .drivingStyleEvaluation)
        ecoScoreBonusRange = extract(property: .ecoScoreBonusRange)
        ecoScoreConstant = extract(property: .ecoScoreConstant)
        ecoScoreFreeWheel = extract(property: .ecoScoreFreeWheel)
        ecoScoreTotal = extract(property: .ecoScoreTotal)
        electricConsumptionAverage = extract(property: .electricConsumptionAverage)
        electricConsumptionRateSinceReset = extract(property: .electricConsumptionRateSinceReset)
        electricConsumptionRateSinceStart = extract(property: .electricConsumptionRateSinceStart)
        electricDistanceLastTrip = extract(property: .electricDistanceLastTrip)
        electricDistanceSinceReset = extract(property: .electricDistanceSinceReset)
        electricDurationLastTrip = extract(property: .electricDurationLastTrip)
        electricDurationSinceReset = extract(property: .electricDurationSinceReset)
        fuelConsumptionRateLastTrip = extract(property: .fuelConsumptionRateLastTrip)
        fuelConsumptionRateSinceReset = extract(property: .fuelConsumptionRateSinceReset)
        fuelDistanceLastTrip = extract(property: .fuelDistanceLastTrip)
        fuelDistanceSinceReset = extract(property: .fuelDistanceSinceReset)
        lastTripAverageEnergyRecuperation = extract(property: .lastTripAverageEnergyRecuperation)
        lastTripBatteryRemaining = extract(property: .lastTripBatteryRemaining)
        lastTripDate = extract(property: .lastTripDate)
        lastTripElectricPortion = extract(property: .lastTripElectricPortion)
        lastTripEnergyConsumption = extract(property: .lastTripEnergyConsumption)
        lastTripFuelConsumption = extract(property: .lastTripFuelConsumption)
        lateNightGrade = extract(property: .lateNightGrade)
        odometerAfterLastTrip = extract(property: .odometerAfterLastTrip)
        rapidAccelerationGrade = extract(property: .rapidAccelerationGrade)
        rapidDecelerationGrade = extract(property: .rapidDecelerationGrade)
        recuperationPower = extract(property: .recuperationPower)
        safetyDrivingScore = extract(property: .safetyDrivingScore)
        tripMeters = extract(properties: .tripMeters)
    }
}
