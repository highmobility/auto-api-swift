import Foundation
import HMUtilities

public final class AAMessaging: AACapability, AAPropertyIdentifying {
    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAMessaging` was introduced to the spec.
        public static let intro: UInt8 = 4
    
        /// Level (version) of *AutoAPI* when `AAMessaging` was last updated.
        public static let updated: UInt8 = 11
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0037 }

    /// Property identifiers for `AAMessaging`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case text = 0x01
        case handle = 0x02
    }

    // MARK: Properties
    /// The optional handle of message.
    public var handle: AAProperty<String>?
    
    /// The text.
    public var text: AAProperty<String>?

    // MARK: Setters
    /// Notify the vehicle that a message has been received. Depending on the vehicle system, it will display or read it loud to the driver.
    /// 
    /// - parameters:
    ///     - text: The text.
    ///     - handle: The optional handle of message.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func messageReceived(text: String, handle: String? = nil) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.text, value: text))
        properties.append(AAProperty(id: PropertyIdentifier.handle, value: handle))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        handle = extract(property: .handle)
        text = extract(property: .text)
    }
}
