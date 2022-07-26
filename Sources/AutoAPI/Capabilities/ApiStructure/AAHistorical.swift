import Foundation
import HMUtilities

public final class AAHistorical: AACapability, AAPropertyIdentifying {
    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAHistorical` was introduced to the spec.
        public static let intro: UInt8 = 8
    
        /// Level (version) of *AutoAPI* when `AAHistorical` was last updated.
        public static let updated: UInt8 = 12
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0012 }

    /// Property identifiers for `AAHistorical`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case states = 0x01
        case capabilityID = 0x02		// Non-state property (can't be retrieved)
        case startDate = 0x03		// Non-state property (can't be retrieved)
        case endDate = 0x04		// Non-state property (can't be retrieved)
    }

    // MARK: Properties
    /// The bytes of a Capability state.
    public var states: [AAProperty<AACapabilityState>]?

    // MARK: Setters
    /// Request historical states.
    /// 
    /// - parameters:
    ///     - capabilityID: The identifier of the Capability.
    ///     - startDate: Start date for historical data query.
    ///     - endDate: End date for historical data query.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func requestStates(capabilityID: UInt16, startDate: Date? = nil, endDate: Date? = nil) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.capabilityID, value: capabilityID))
        properties.append(AAProperty(id: PropertyIdentifier.startDate, value: startDate))
        properties.append(AAProperty(id: PropertyIdentifier.endDate, value: endDate))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Request history of trips travelled with the vehicle.
    /// 
    /// - parameters:
    ///     - startDate: Start date for historical data query.
    ///     - endDate: End date for historical data query.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func getTrips(startDate: Date? = nil, endDate: Date? = nil) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.startDate, value: startDate))
        properties.append(AAProperty(id: PropertyIdentifier.endDate, value: endDate))
        properties.append(AAProperty(id: PropertyIdentifier.capabilityID.rawValue, value: UInt16(bytes: [0x00, 0x6a])))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Request history of charging sessions for the vehicle.
    /// 
    /// - parameters:
    ///     - startDate: Start date for historical data query.
    ///     - endDate: End date for historical data query.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func getChargingSessions(startDate: Date? = nil, endDate: Date? = nil) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.startDate, value: startDate))
        properties.append(AAProperty(id: PropertyIdentifier.endDate, value: endDate))
        properties.append(AAProperty(id: PropertyIdentifier.capabilityID.rawValue, value: UInt16(bytes: [0x00, 0x6d])))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        states = extract(properties: .states)
    }
}
