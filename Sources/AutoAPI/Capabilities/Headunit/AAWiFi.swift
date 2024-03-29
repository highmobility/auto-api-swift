import Foundation
import HMUtilities

public final class AAWiFi: AACapability, AAPropertyIdentifying {
    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAWiFi` was introduced to the spec.
        public static let intro: UInt8 = 6
    
        /// Level (version) of *AutoAPI* when `AAWiFi` was last updated.
        public static let updated: UInt8 = 11
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0059 }

    /// Property identifiers for `AAWiFi`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case status = 0x01
        case networkConnected = 0x02
        case networkSSID = 0x03
        case networkSecurity = 0x04
        case password = 0x05		// Non-state property (can't be retrieved)
    }

    // MARK: Properties
    /// Network connected value.
    public var networkConnected: AAProperty<AAConnectionState>?
    
    /// The network SSID.
    public var networkSSID: AAProperty<String>?
    
    /// Network security value.
    public var networkSecurity: AAProperty<AANetworkSecurity>?
    
    /// Status value.
    public var status: AAProperty<AAEnabledState>?

    // MARK: Getters
    /// Get `AAWiFi` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getWiFiState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AAWiFi` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getWiFiStateProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getWiFiState() + ids.map { $0.rawValue }
    }
    
    /// Get `AAWiFi` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getWiFiStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AAWiFi` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getWiFiStatePropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getWiFiStateAvailability() + ids.map { $0.rawValue }
    }

    // MARK: Setters
    /// Connect the vehicle to a Wi-Fi network.
    /// 
    /// - parameters:
    ///     - networkSSID: The network SSID.
    ///     - networkSecurity: Network security value.
    ///     - password: The network password.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func connectToNetwork(networkSSID: String, networkSecurity: AANetworkSecurity, password: String? = nil) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.networkSSID, value: networkSSID))
        properties.append(AAProperty(id: PropertyIdentifier.networkSecurity, value: networkSecurity))
        properties.append(AAProperty(id: PropertyIdentifier.password, value: password))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Forget a network that the vehicle has previously connected to.
    /// 
    /// - parameters:
    ///     - networkSSID: The network SSID.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func forgetNetwork(networkSSID: String) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.networkSSID, value: networkSSID))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Enable or disable Wi-Fi completely.
    /// 
    /// - parameters:
    ///     - status: Status value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func enableDisableWiFi(status: AAEnabledState) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.status, value: status))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        networkConnected = extract(property: .networkConnected)
        networkSSID = extract(property: .networkSSID)
        networkSecurity = extract(property: .networkSecurity)
        status = extract(property: .status)
    }
}
