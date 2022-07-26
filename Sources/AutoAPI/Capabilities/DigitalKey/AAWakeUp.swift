import Foundation
import HMUtilities

public final class AAWakeUp: AACapability, AAPropertyIdentifying {
    public typealias Status = AAWakeUpStatus

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAWakeUp` was introduced to the spec.
        public static let intro: UInt8 = 2
    
        /// Level (version) of *AutoAPI* when `AAWakeUp` was last updated.
        public static let updated: UInt8 = 11
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0022 }

    /// Property identifiers for `AAWakeUp`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case status = 0x01		// Non-state property (can't be retrieved)
    }

    // MARK: Setters
    /// Wake up the vehicle. This is necessary when the vehicle has fallen asleep, in which case the vehicle responds with the Failure Message to all incoming messages. The vehicle is also waken up by the Lock/Unlock Doors message.
    /// 
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func wakeUp() -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.status.rawValue, value: Status(bytes: [0x00])))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
}
