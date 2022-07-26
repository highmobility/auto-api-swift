import Foundation
import HMUtilities

public final class AATheftAlarm: AACapability, AAPropertyIdentifying {
    public typealias Status = AATheftAlarmStatus
    public typealias LastWarningReason = AATheftAlarmLastWarningReason
    public typealias LastEventLevel = AATheftAlarmLastEventLevel
    public typealias EventType = AATheftAlarmEventType

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AATheftAlarm` was introduced to the spec.
        public static let intro: UInt8 = 4
    
        /// Level (version) of *AutoAPI* when `AATheftAlarm` was last updated.
        public static let updated: UInt8 = 12
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0046 }

    /// Property identifiers for `AATheftAlarm`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case status = 0x01
        case interiorProtectionStatus = 0x02
        case towProtectionStatus = 0x03
        case lastWarningReason = 0x04
        case lastEvent = 0x05
        case lastEventLevel = 0x06
        case eventType = 0x07
        case interiorProtectionTriggered = 0x08
        case towProtectionTriggered = 0x09
    }

    // MARK: Properties
    /// Position of the last even relative to the vehicle.
    public var eventType: AAProperty<EventType>?
    
    /// Interior protection sensor status.
    public var interiorProtectionStatus: AAProperty<AAActiveSelectedState>?
    
    /// Indicates whether the interior protection sensors are triggered..
    public var interiorProtectionTriggered: AAProperty<AATriggered>?
    
    /// Last event happening date.
    public var lastEvent: AAProperty<Date>?
    
    /// Level of impact for the last event.
    public var lastEventLevel: AAProperty<LastEventLevel>?
    
    /// Last warning reason value.
    public var lastWarningReason: AAProperty<LastWarningReason>?
    
    /// Status value.
    public var status: AAProperty<Status>?
    
    /// Tow protection sensor status.
    public var towProtectionStatus: AAProperty<AAActiveSelectedState>?
    
    /// Indicates whether the tow protection sensors are triggered..
    public var towProtectionTriggered: AAProperty<AATriggered>?

    // MARK: Getters
    /// Get `AATheftAlarm` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getTheftAlarmState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AATheftAlarm` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getTheftAlarmStateProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getTheftAlarmState() + ids.map { $0.rawValue }
    }
    
    /// Get `AATheftAlarm` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getTheftAlarmStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AATheftAlarm` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getTheftAlarmStatePropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getTheftAlarmStateAvailability() + ids.map { $0.rawValue }
    }

    // MARK: Setters
    /// Unarm or arm the theft alarm of the vehicle.
    /// 
    /// - parameters:
    ///     - status: Status value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func setTheftAlarm(status: Status) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.status, value: status))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        eventType = extract(property: .eventType)
        interiorProtectionStatus = extract(property: .interiorProtectionStatus)
        interiorProtectionTriggered = extract(property: .interiorProtectionTriggered)
        lastEvent = extract(property: .lastEvent)
        lastEventLevel = extract(property: .lastEventLevel)
        lastWarningReason = extract(property: .lastWarningReason)
        status = extract(property: .status)
        towProtectionStatus = extract(property: .towProtectionStatus)
        towProtectionTriggered = extract(property: .towProtectionTriggered)
    }
}
