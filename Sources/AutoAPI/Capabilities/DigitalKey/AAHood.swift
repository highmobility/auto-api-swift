import Foundation
import HMUtilities

public final class AAHood: AACapability, AAPropertyIdentifying {
    public typealias Position = AAHoodPosition

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAHood` was introduced to the spec.
        public static let intro: UInt8 = 11
    
        /// Level (version) of *AutoAPI* when `AAHood` was last updated.
        public static let updated: UInt8 = 13
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0067 }

    /// Property identifiers for `AAHood`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case position = 0x01
        case lock = 0x02
        case lockSafety = 0x03
    }

    // MARK: Properties
    /// Includes the lock state of the hood..
    public var lock: AAProperty<AALockState>?
    
    /// Indicates the safe-state of the hood..
    public var lockSafety: AAProperty<AALockSafety>?
    
    /// Position value.
    public var position: AAProperty<Position>?

    // MARK: Getters
    /// Get `AAHood` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getHoodState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AAHood` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getHoodStateProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getHoodState() + ids.map { $0.rawValue }
    }
    
    /// Get `AAHood` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getHoodStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AAHood` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getHoodStatePropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getHoodStateAvailability() + ids.map { $0.rawValue }
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        lock = extract(property: .lock)
        lockSafety = extract(property: .lockSafety)
        position = extract(property: .position)
    }
}
