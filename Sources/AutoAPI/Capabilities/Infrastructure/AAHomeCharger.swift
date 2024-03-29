import Foundation
import HMUtilities

public final class AAHomeCharger: AACapability, AAPropertyIdentifying {
    public typealias ChargingStatus = AAHomeChargerChargingStatus
    public typealias AuthenticationMechanism = AAHomeChargerAuthenticationMechanism
    public typealias PlugType = AAHomeChargerPlugType
    public typealias AuthenticationState = AAHomeChargerAuthenticationState

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAHomeCharger` was introduced to the spec.
        public static let intro: UInt8 = 6
    
        /// Level (version) of *AutoAPI* when `AAHomeCharger` was last updated.
        public static let updated: UInt8 = 12
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0060 }

    /// Property identifiers for `AAHomeCharger`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case chargingStatus = 0x01
        case authenticationMechanism = 0x02
        case plugType = 0x03
        case solarCharging = 0x05
        case wifiHotspotEnabled = 0x08
        case wifiHotspotSSID = 0x09
        case wiFiHotspotSecurity = 0x0a
        case wiFiHotspotPassword = 0x0b
        case authenticationState = 0x0d
        case chargeCurrent = 0x0e
        case maximumChargeCurrent = 0x0f
        case minimumChargeCurrent = 0x10
        case coordinates = 0x11
        case priceTariffs = 0x12
        case chargingPower = 0x13
    }

    // MARK: Properties
    /// Authentication mechanism value.
    public var authenticationMechanism: AAProperty<AuthenticationMechanism>?
    
    /// Authentication state value.
    public var authenticationState: AAProperty<AuthenticationState>?
    
    /// The charge current.
    public var chargeCurrent: AAProperty<Measurement<UnitElectricCurrent>>?
    
    /// Charging power output from the charger.
    public var chargingPower: AAProperty<Measurement<UnitPower>>?
    
    /// Charging status value.
    public var chargingStatus: AAProperty<ChargingStatus>?
    
    /// Coordinates value.
    public var coordinates: AAProperty<AACoordinates>?
    
    /// The maximum possible charge current.
    public var maximumChargeCurrent: AAProperty<Measurement<UnitElectricCurrent>>?
    
    /// The minimal possible charge current.
    public var minimumChargeCurrent: AAProperty<Measurement<UnitElectricCurrent>>?
    
    /// Plug type value.
    public var plugType: AAProperty<PlugType>?
    
    /// Price tariffs value.
    public var priceTariffs: [AAProperty<AAPriceTariff>]?
    
    /// Solar charging value.
    public var solarCharging: AAProperty<AAActiveState>?
    
    /// The Wi-Fi Hotspot password.
    public var wiFiHotspotPassword: AAProperty<String>?
    
    /// Wi-Fi hotspot security value.
    public var wiFiHotspotSecurity: AAProperty<AANetworkSecurity>?
    
    /// Wi-Fi hotspot enabled value.
    public var wifiHotspotEnabled: AAProperty<AAEnabledState>?
    
    /// The Wi-Fi Hotspot SSID.
    public var wifiHotspotSSID: AAProperty<String>?
    // Deprecated/// Charging power.
    ///
    /// - warning: This property is deprecated in favour of *chargingPower*.
    @available(*, deprecated, renamed: "chargingPower", message: "removed the unit from the name")
    public var chargingPowerKW: AAProperty<Measurement<UnitPower>>? {
        chargingPower
    }

    // MARK: Getters
    /// Get `AAHomeCharger` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getHomeChargerState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AAHomeCharger` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getHomeChargerStateProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getHomeChargerState() + ids.map { $0.rawValue }
    }
    
    /// Get `AAHomeCharger` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getHomeChargerStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AAHomeCharger` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getHomeChargerStatePropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getHomeChargerStateAvailability() + ids.map { $0.rawValue }
    }

    // MARK: Setters
    /// Set the charge current of the home charger.
    /// 
    /// - parameters:
    ///     - chargeCurrent: The charge current.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func setChargeCurrent(chargeCurrent: Measurement<UnitElectricCurrent>) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.chargeCurrent, value: chargeCurrent))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Set the price tariffs of the home charger.
    /// 
    /// - parameters:
    ///     - priceTariffs: Price tariffs value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func setPriceTariffs(priceTariffs: [AAPriceTariff]) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(contentsOf: priceTariffs.compactMap { AAProperty(id: PropertyIdentifier.priceTariffs, value: $0) })
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Activate or deactivate charging from solar power.
    /// 
    /// - parameters:
    ///     - solarCharging: Solar charging value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func activateDeactivateSolarCharging(solarCharging: AAActiveState) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.solarCharging, value: solarCharging))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Enable or disable the Wi-Fi Hotspot.
    /// 
    /// - parameters:
    ///     - wifiHotspotEnabled: Wi-Fi hotspot enabled value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func enableDisableWiFiHotspot(wifiHotspotEnabled: AAEnabledState) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.wifiHotspotEnabled, value: wifiHotspotEnabled))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Authenticate or expire the charging session. Only if the session is authenticated can the charging be started by the vehicle.
    /// 
    /// - parameters:
    ///     - authenticationState: Authentication state value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func authenticateExpire(authenticationState: AuthenticationState) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.authenticationState, value: authenticationState))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        authenticationMechanism = extract(property: .authenticationMechanism)
        authenticationState = extract(property: .authenticationState)
        chargeCurrent = extract(property: .chargeCurrent)
        chargingPower = extract(property: .chargingPower)
        chargingStatus = extract(property: .chargingStatus)
        coordinates = extract(property: .coordinates)
        maximumChargeCurrent = extract(property: .maximumChargeCurrent)
        minimumChargeCurrent = extract(property: .minimumChargeCurrent)
        plugType = extract(property: .plugType)
        priceTariffs = extract(properties: .priceTariffs)
        solarCharging = extract(property: .solarCharging)
        wiFiHotspotPassword = extract(property: .wiFiHotspotPassword)
        wiFiHotspotSecurity = extract(property: .wiFiHotspotSecurity)
        wifiHotspotEnabled = extract(property: .wifiHotspotEnabled)
        wifiHotspotSSID = extract(property: .wifiHotspotSSID)
    }
}
