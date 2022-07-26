import Foundation
import HMUtilities

public final class AANotifications: AACapability, AAPropertyIdentifying {
    public typealias Clear = AANotificationsClear

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AANotifications` was introduced to the spec.
        public static let intro: UInt8 = 4
    
        /// Level (version) of *AutoAPI* when `AANotifications` was last updated.
        public static let updated: UInt8 = 11
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0038 }

    /// Property identifiers for `AANotifications`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case text = 0x01
        case actionItems = 0x02
        case activatedAction = 0x03
        case clear = 0x04
    }

    // MARK: Properties
    /// Action items value.
    public var actionItems: [AAProperty<AAActionItem>]?
    
    /// Identifier of the activated action.
    public var activatedAction: AAProperty<UInt8>?
    
    /// Clear value.
    public var clear: AAProperty<Clear>?
    
    /// Text for the notification.
    public var text: AAProperty<String>?

    // MARK: Setters
    /// Send a notification to the vehicle or smart device. The notification can have action items that the user can respond with.
    /// 
    /// - parameters:
    ///     - text: Text for the notification.
    ///     - actionItems: Action items value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func notification(text: String, actionItems: [AAActionItem]? = nil) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.text, value: text))
        properties.append(contentsOf: actionItems?.compactMap { AAProperty(id: PropertyIdentifier.actionItems, value: $0) } ?? [])
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Activate/choose a notification action.
    /// 
    /// - parameters:
    ///     - activatedAction: Identifier of the activated action.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func action(activatedAction: UInt8) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.activatedAction, value: activatedAction))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Clear the Notification in either the vehicle or device that has previously been sent, ignoring driver feedback.
    /// 
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func clearNotification() -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.clear.rawValue, value: Clear(bytes: [0x00])))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        actionItems = extract(properties: .actionItems)
        activatedAction = extract(property: .activatedAction)
        clear = extract(property: .clear)
        text = extract(property: .text)
    }
}
