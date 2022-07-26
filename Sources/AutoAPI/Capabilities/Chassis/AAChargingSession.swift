import Foundation
import HMUtilities

public final class AAChargingSession: AACapability, AAPropertyIdentifying {
    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAChargingSession` was introduced to the spec.
        public static let intro: UInt8 = 13
    
        /// Level (version) of *AutoAPI* when `AAChargingSession` was last updated.
        public static let updated: UInt8 = 13
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x006D }

    /// Property identifiers for `AAChargingSession`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case publicChargingPoints = 0x01
        case displayedStateOfCharge = 0x02
        case displayedStartStateOfCharge = 0x03
        case businessErrors = 0x04
        case timeZone = 0x05
        case startTime = 0x06
        case endTime = 0x07
        case totalChargingDuration = 0x08
        case calculatedEnergyCharged = 0x09
        case energyCharged = 0x0a
        case preconditioningState = 0x0b
        case odometer = 0x0c
        case chargingCost = 0x0d
        case location = 0x0e
    }

    // MARK: Properties
    /// Business errors value.
    public var businessErrors: [AAProperty<String>]?
    
    /// Calculated amount of energy charged during the session.
    public var calculatedEnergyCharged: AAProperty<Measurement<UnitEnergy>>?
    
    /// Charging cost information.
    public var chargingCost: AAProperty<AAChargingCost>?
    
    /// Displayed state of charge at start to the driver.
    public var displayedStartStateOfCharge: AAProperty<AAPercentage>?
    
    /// Displayed state of charge to the driver.
    public var displayedStateOfCharge: AAProperty<AAPercentage>?
    
    /// End time of the charging session.
    public var endTime: AAProperty<Date>?
    
    /// Energy charged during the session.
    public var energyCharged: AAProperty<Measurement<UnitEnergy>>?
    
    /// Charging location address.
    public var location: AAProperty<AAChargingLocation>?
    
    /// The vehicle odometer value in a given units.
    public var odometer: AAProperty<Measurement<UnitLength>>?
    
    /// Preconditioning is active or not.
    public var preconditioningState: AAProperty<AAActiveState>?
    
    /// Matching public charging points..
    public var publicChargingPoints: [AAProperty<AAChargingPoint>]?
    
    /// Start time of the charging session.
    public var startTime: AAProperty<Date>?
    
    /// Time zone of the charging session.
    public var timeZone: AAProperty<String>?
    
    /// Total time charging was active during the session.
    public var totalChargingDuration: AAProperty<Measurement<UnitDuration>>?

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        businessErrors = extract(properties: .businessErrors)
        calculatedEnergyCharged = extract(property: .calculatedEnergyCharged)
        chargingCost = extract(property: .chargingCost)
        displayedStartStateOfCharge = extract(property: .displayedStartStateOfCharge)
        displayedStateOfCharge = extract(property: .displayedStateOfCharge)
        endTime = extract(property: .endTime)
        energyCharged = extract(property: .energyCharged)
        location = extract(property: .location)
        odometer = extract(property: .odometer)
        preconditioningState = extract(property: .preconditioningState)
        publicChargingPoints = extract(properties: .publicChargingPoints)
        startTime = extract(property: .startTime)
        timeZone = extract(property: .timeZone)
        totalChargingDuration = extract(property: .totalChargingDuration)
    }
}
