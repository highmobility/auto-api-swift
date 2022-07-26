import Foundation
import HMUtilities

public final class AAMultiCommand: AACapability, AAPropertyIdentifying {
    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAMultiCommand` was introduced to the spec.
        public static let intro: UInt8 = 8
    
        /// Level (version) of *AutoAPI* when `AAMultiCommand` was last updated.
        public static let updated: UInt8 = 11
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0013 }

    /// Property identifiers for `AAMultiCommand`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case multiStates = 0x01
        case multiCommands = 0x02		// Non-state property (can't be retrieved)
    }

    // MARK: Properties
    /// The incoming states.
    public var multiStates: [AAProperty<AACapabilityState>]?

    // MARK: Setters
    /// Send multiple commands at once.
    /// 
    /// - parameters:
    ///     - multiCommands: The outgoing commands.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func multiCommand(multiCommands: [AACapabilityState]) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(contentsOf: multiCommands.compactMap { AAProperty(id: PropertyIdentifier.multiCommands, value: $0) })
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        multiStates = extract(properties: .multiStates)
    }
}
