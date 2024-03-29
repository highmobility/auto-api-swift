import Foundation
import HMUtilities

public final class AATrunk: AACapability, AAPropertyIdentifying {
    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AATrunk` was introduced to the spec.
        public static let intro: UInt8 = 1
    
        /// Level (version) of *AutoAPI* when `AATrunk` was last updated.
        public static let updated: UInt8 = 13
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0021 }

    /// Property identifiers for `AATrunk`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case lock = 0x01
        case position = 0x02
        case lockSafety = 0x03
    }

    // MARK: Properties
    /// Lock value.
    public var lock: AAProperty<AALockState>?
    
    /// Indicates the safe-state of the trunk..
    public var lockSafety: AAProperty<AALockSafety>?
    
    /// Position value.
    public var position: AAProperty<AAPosition>?

    // MARK: Getters
    /// Get `AATrunk` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getTrunkState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AATrunk` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getTrunkStateProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getTrunkState() + ids.map { $0.rawValue }
    }
    
    /// Get `AATrunk` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getTrunkStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AATrunk` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getTrunkStatePropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getTrunkStateAvailability() + ids.map { $0.rawValue }
    }

    // MARK: Setters
    /// Unlock/Lock and Open/Close the trunk.
    /// 
    /// - parameters:
    ///     - lock: Lock value.
    ///     - position: Position value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func controlTrunk(lock: AALockState? = nil, position: AAPosition? = nil) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.lock, value: lock))
        properties.append(AAProperty(id: PropertyIdentifier.position, value: position))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        lock = extract(property: .lock)
        lockSafety = extract(property: .lockSafety)
        position = extract(property: .position)
    }
}
