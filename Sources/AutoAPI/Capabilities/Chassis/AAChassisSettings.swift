import Foundation
import HMUtilities

public final class AAChassisSettings: AACapability, AAPropertyIdentifying {
    public typealias SportChrono = AAChassisSettingsSportChrono

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAChassisSettings` was introduced to the spec.
        public static let intro: UInt8 = 5
    
        /// Level (version) of *AutoAPI* when `AAChassisSettings` was last updated.
        public static let updated: UInt8 = 12
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0053 }

    /// Property identifiers for `AAChassisSettings`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case drivingMode = 0x01
        case sportChrono = 0x02
        case currentSpringRates = 0x05
        case maximumSpringRates = 0x06
        case minimumSpringRates = 0x07
        case currentChassisPosition = 0x08
        case maximumChassisPosition = 0x09
        case minimumChassisPosition = 0x0a
    }

    // MARK: Properties
    /// The chassis position calculated from the lowest point.
    public var currentChassisPosition: AAProperty<Measurement<UnitLength>>?
    
    /// The current values for the spring rates.
    public var currentSpringRates: [AAProperty<AASpringRate>]?
    
    /// Driving mode value.
    public var drivingMode: AAProperty<AADrivingMode>?
    
    /// The maximum possible value for the chassis position.
    public var maximumChassisPosition: AAProperty<Measurement<UnitLength>>?
    
    /// The maximum possible values for the spring rates.
    public var maximumSpringRates: [AAProperty<AASpringRate>]?
    
    /// The minimum possible value for the chassis position.
    public var minimumChassisPosition: AAProperty<Measurement<UnitLength>>?
    
    /// The minimum possible values for the spring rates.
    public var minimumSpringRates: [AAProperty<AASpringRate>]?
    
    /// Sport chrono value.
    public var sportChrono: AAProperty<SportChrono>?

    // MARK: Getters
    /// Get `AAChassisSettings` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getChassisSettings() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AAChassisSettings` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getChassisSettingsProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getChassisSettings() + ids.map { $0.rawValue }
    }
    
    /// Get `AAChassisSettings` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getChassisSettingsAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AAChassisSettings` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getChassisSettingsPropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getChassisSettingsAvailability() + ids.map { $0.rawValue }
    }

    // MARK: Setters
    /// Set the driving mode.
    /// 
    /// - parameters:
    ///     - drivingMode: Driving mode value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func setDrivingMode(drivingMode: AADrivingMode) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.drivingMode, value: drivingMode))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Start/Stop sport chrono.
    /// 
    /// - parameters:
    ///     - sportChrono: Sport chrono value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func startStopSportsChrono(sportChrono: SportChrono) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.sportChrono, value: sportChrono))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Set the spring rates.
    /// 
    /// - parameters:
    ///     - currentSpringRates: The current values for the spring rates.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func setSpringRates(currentSpringRates: [AASpringRate]) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(contentsOf: currentSpringRates.compactMap { AAProperty(id: PropertyIdentifier.currentSpringRates, value: $0) })
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Set the chassis position.
    /// 
    /// - parameters:
    ///     - currentChassisPosition: The chassis position calculated from the lowest point.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func setChassisPosition(currentChassisPosition: Measurement<UnitLength>) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.currentChassisPosition, value: currentChassisPosition))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        currentChassisPosition = extract(property: .currentChassisPosition)
        currentSpringRates = extract(properties: .currentSpringRates)
        drivingMode = extract(property: .drivingMode)
        maximumChassisPosition = extract(property: .maximumChassisPosition)
        maximumSpringRates = extract(properties: .maximumSpringRates)
        minimumChassisPosition = extract(property: .minimumChassisPosition)
        minimumSpringRates = extract(properties: .minimumSpringRates)
        sportChrono = extract(property: .sportChrono)
    }
}
