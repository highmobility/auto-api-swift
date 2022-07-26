import Foundation
import HMUtilities

public final class AAMaintenance: AACapability, AAPropertyIdentifying {
    public typealias TeleserviceAvailability = AAMaintenanceTeleserviceAvailability

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAMaintenance` was introduced to the spec.
        public static let intro: UInt8 = 3
    
        /// Level (version) of *AutoAPI* when `AAMaintenance` was last updated.
        public static let updated: UInt8 = 13
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0034 }

    /// Property identifiers for `AAMaintenance`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case cbsReportsCount = 0x03
        case teleserviceAvailability = 0x05
        case serviceDistanceThreshold = 0x06
        case serviceTimeThreshold = 0x07
        case automaticTeleserviceCallDate = 0x08
        case teleserviceBatteryCallDate = 0x09
        case nextInspectionDate = 0x0a
        case conditionBasedServices = 0x0b
        case brakeFluidChangeDate = 0x0c
        case timeToNextService = 0x0d
        case distanceToNextService = 0x0e
        case timeToExhaustInspection = 0x0f
        case lastECall = 0x10
        case distanceToNextOilService = 0x11
        case timeToNextOilService = 0x12
        case brakeFluidRemainingDistance = 0x13
        case brakeFluidStatus = 0x14
        case brakesServiceDueDates = 0x16
        case brakesServiceRemainingDistances = 0x17
        case brakesServiceStatuses = 0x18
        case driveInInspectionDate = 0x19
        case driveInInspectionStatus = 0x1a
        case nextOilServiceDate = 0x1b
        case nextInspectionDistanceTo = 0x1c
        case legalInspectionDate = 0x1d
        case serviceStatus = 0x1e
        case serviceDate = 0x1f
        case inspectionStatus = 0x20
        case driveInInspectionDistanceTo = 0x21
        case vehicleCheckDate = 0x22
        case vehicleCheckStatus = 0x23
        case vehicleCheckDistanceTo = 0x24
    }

    // MARK: Properties
    /// Automatic teleservice call date.
    public var automaticTeleserviceCallDate: AAProperty<Date>?
    
    /// Brake fluid change date.
    public var brakeFluidChangeDate: AAProperty<Date>?
    
    /// Indicates the remaining distance for brake fluid..
    public var brakeFluidRemainingDistance: AAProperty<Measurement<UnitLength>>?
    
    /// Brake fluid's service status..
    public var brakeFluidStatus: AAProperty<AAServiceStatus>?
    
    /// Brakes servicing due dates..
    public var brakesServiceDueDates: [AAProperty<AABrakeServiceDueDate>]?
    
    /// Brakes servicing remaining distances..
    public var brakesServiceRemainingDistances: [AAProperty<AABrakeServiceRemainingDistance>]?
    
    /// Brakes servicing statuses..
    public var brakesServiceStatuses: [AAProperty<AABrakeServiceStatus>]?
    
    /// The number of CBS reports.
    public var cbsReportsCount: AAProperty<UInt8>?
    
    /// Condition based services value.
    public var conditionBasedServices: [AAProperty<AAConditionBasedService>]?
    
    /// Indicates the remaining distance until the next oil service; if this limit was exceeded, this value indicates the distance that has been driven since then..
    public var distanceToNextOilService: AAProperty<Measurement<UnitLength>>?
    
    /// The distance until next servicing of the vehicle.
    public var distanceToNextService: AAProperty<Measurement<UnitLength>>?
    
    /// Next drive-in inspection date..
    public var driveInInspectionDate: AAProperty<Date>?
    
    /// The distance until next drive-in inspection of the vehicle.
    public var driveInInspectionDistanceTo: AAProperty<Measurement<UnitLength>>?
    
    /// Drive-in inspection service status..
    public var driveInInspectionStatus: AAProperty<AAServiceStatus>?
    
    /// Vehicle inspection service status..
    public var inspectionStatus: AAProperty<AAServiceStatus>?
    
    /// Date-time of the last eCall.
    public var lastECall: AAProperty<Date>?
    
    /// Next legally required inspection date.
    public var legalInspectionDate: AAProperty<Date>?
    
    /// Next inspection date.
    public var nextInspectionDate: AAProperty<Date>?
    
    /// Distance until the next inspection..
    public var nextInspectionDistanceTo: AAProperty<Measurement<UnitLength>>?
    
    /// Next oil service date..
    public var nextOilServiceDate: AAProperty<Date>?
    
    /// Date of the earliest service. If this service is overdue, the date is in the past..
    public var serviceDate: AAProperty<Date>?
    
    /// Distance threshold for service.
    public var serviceDistanceThreshold: AAProperty<Measurement<UnitLength>>?
    
    /// Consolidated status regarding service requirements. OK: no current service requirement, WARNING: at least one service has reported requirement, CRITICAL: at least one service is overdue..
    public var serviceStatus: AAProperty<AAServiceStatus>?
    
    /// Time threshold for service.
    public var serviceTimeThreshold: AAProperty<Measurement<UnitDuration>>?
    
    /// Teleservice availability value.
    public var teleserviceAvailability: AAProperty<TeleserviceAvailability>?
    
    /// Teleservice batter call date.
    public var teleserviceBatteryCallDate: AAProperty<Date>?
    
    /// Time until exhaust inspection.
    public var timeToExhaustInspection: AAProperty<Measurement<UnitDuration>>?
    
    /// Indicates the time remaining until the next oil service; if this limit was exceeded, this value indicates the time that has passed since then..
    public var timeToNextOilService: AAProperty<Measurement<UnitDuration>>?
    
    /// Time until next servicing of the vehicle.
    public var timeToNextService: AAProperty<Measurement<UnitDuration>>?
    
    /// Vehicle check date (usually after a predetermined distance)..
    public var vehicleCheckDate: AAProperty<Date>?
    
    /// The distance until next vehicle check..
    public var vehicleCheckDistanceTo: AAProperty<Measurement<UnitLength>>?
    
    /// Vehicle check service status..
    public var vehicleCheckStatus: AAProperty<AAServiceStatus>?
    // Deprecated/// Time until next servicing of the car.
    ///
    /// - warning: This property is deprecated in favour of *timeToNextService*.
    @available(*, deprecated, renamed: "timeToNextService", message: "removed the unit from the name")
    public var daysToNextService: AAProperty<Measurement<UnitDuration>>? {
        timeToNextService
    }
    
    /// The distance until next servicing of the vehicle.
    ///
    /// - warning: This property is deprecated in favour of *distanceToNextService*.
    @available(*, deprecated, renamed: "distanceToNextService", message: "removed the unit from the name")
    public var kilometersToNextService: AAProperty<Measurement<UnitLength>>? {
        distanceToNextService
    }
    
    /// Time until exhaust inspection.
    ///
    /// - warning: This property is deprecated in favour of *timeToExhaustInspection*.
    @available(*, deprecated, renamed: "timeToExhaustInspection", message: "removed the unit from the name")
    public var monthsToExhaustInspection: AAProperty<Measurement<UnitDuration>>? {
        timeToExhaustInspection
    }

    // MARK: Getters
    /// Get `AAMaintenance` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getMaintenanceState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AAMaintenance` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getMaintenanceStateProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getMaintenanceState() + ids.map { $0.rawValue }
    }
    
    /// Get `AAMaintenance` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getMaintenanceStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AAMaintenance` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getMaintenanceStatePropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getMaintenanceStateAvailability() + ids.map { $0.rawValue }
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        automaticTeleserviceCallDate = extract(property: .automaticTeleserviceCallDate)
        brakeFluidChangeDate = extract(property: .brakeFluidChangeDate)
        brakeFluidRemainingDistance = extract(property: .brakeFluidRemainingDistance)
        brakeFluidStatus = extract(property: .brakeFluidStatus)
        brakesServiceDueDates = extract(properties: .brakesServiceDueDates)
        brakesServiceRemainingDistances = extract(properties: .brakesServiceRemainingDistances)
        brakesServiceStatuses = extract(properties: .brakesServiceStatuses)
        cbsReportsCount = extract(property: .cbsReportsCount)
        conditionBasedServices = extract(properties: .conditionBasedServices)
        distanceToNextOilService = extract(property: .distanceToNextOilService)
        distanceToNextService = extract(property: .distanceToNextService)
        driveInInspectionDate = extract(property: .driveInInspectionDate)
        driveInInspectionDistanceTo = extract(property: .driveInInspectionDistanceTo)
        driveInInspectionStatus = extract(property: .driveInInspectionStatus)
        inspectionStatus = extract(property: .inspectionStatus)
        lastECall = extract(property: .lastECall)
        legalInspectionDate = extract(property: .legalInspectionDate)
        nextInspectionDate = extract(property: .nextInspectionDate)
        nextInspectionDistanceTo = extract(property: .nextInspectionDistanceTo)
        nextOilServiceDate = extract(property: .nextOilServiceDate)
        serviceDate = extract(property: .serviceDate)
        serviceDistanceThreshold = extract(property: .serviceDistanceThreshold)
        serviceStatus = extract(property: .serviceStatus)
        serviceTimeThreshold = extract(property: .serviceTimeThreshold)
        teleserviceAvailability = extract(property: .teleserviceAvailability)
        teleserviceBatteryCallDate = extract(property: .teleserviceBatteryCallDate)
        timeToExhaustInspection = extract(property: .timeToExhaustInspection)
        timeToNextOilService = extract(property: .timeToNextOilService)
        timeToNextService = extract(property: .timeToNextService)
        vehicleCheckDate = extract(property: .vehicleCheckDate)
        vehicleCheckDistanceTo = extract(property: .vehicleCheckDistanceTo)
        vehicleCheckStatus = extract(property: .vehicleCheckStatus)
    }
}
