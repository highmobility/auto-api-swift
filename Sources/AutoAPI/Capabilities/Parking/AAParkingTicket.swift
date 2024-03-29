import Foundation
import HMUtilities

public final class AAParkingTicket: AACapability, AAPropertyIdentifying {
    public typealias Status = AAParkingTicketStatus

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAParkingTicket` was introduced to the spec.
        public static let intro: UInt8 = 4
    
        /// Level (version) of *AutoAPI* when `AAParkingTicket` was last updated.
        public static let updated: UInt8 = 11
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0047 }

    /// Property identifiers for `AAParkingTicket`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case status = 0x01
        case operatorName = 0x02
        case operatorTicketID = 0x03
        case ticketStartTime = 0x04
        case ticketEndTime = 0x05
    }

    // MARK: Properties
    /// Operator name.
    public var operatorName: AAProperty<String>?
    
    /// Operator ticket ID.
    public var operatorTicketID: AAProperty<String>?
    
    /// Status value.
    public var status: AAProperty<Status>?
    
    /// Parking ticket end time.
    public var ticketEndTime: AAProperty<Date>?
    
    /// Parking ticket start time.
    public var ticketStartTime: AAProperty<Date>?

    // MARK: Getters
    /// Get `AAParkingTicket` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getParkingTicket() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AAParkingTicket` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getParkingTicketProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getParkingTicket() + ids.map { $0.rawValue }
    }
    
    /// Get `AAParkingTicket` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getParkingTicketAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AAParkingTicket` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getParkingTicketPropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getParkingTicketAvailability() + ids.map { $0.rawValue }
    }

    // MARK: Setters
    /// Start parking. This clears the last parking ticket information and starts a new one. The end time can be left unset depending on the operator.
    /// 
    /// - parameters:
    ///     - operatorName: Operator name.
    ///     - operatorTicketID: Operator ticket ID.
    ///     - ticketStartTime: Parking ticket start time.
    ///     - ticketEndTime: Parking ticket end time.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func startParking(operatorName: String? = nil, operatorTicketID: String, ticketStartTime: Date, ticketEndTime: Date? = nil) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.operatorName, value: operatorName))
        properties.append(AAProperty(id: PropertyIdentifier.operatorTicketID, value: operatorTicketID))
        properties.append(AAProperty(id: PropertyIdentifier.ticketStartTime, value: ticketStartTime))
        properties.append(AAProperty(id: PropertyIdentifier.ticketEndTime, value: ticketEndTime))
        properties.append(AAProperty(id: PropertyIdentifier.status.rawValue, value: Status(bytes: [0x01])))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// End parking. This updates the parking ticket information. If no end date was set, the current time is set as the ending time.
    /// 
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func endParking() -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.status.rawValue, value: Status(bytes: [0x00])))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        operatorName = extract(property: .operatorName)
        operatorTicketID = extract(property: .operatorTicketID)
        status = extract(property: .status)
        ticketEndTime = extract(property: .ticketEndTime)
        ticketStartTime = extract(property: .ticketStartTime)
    }
}
