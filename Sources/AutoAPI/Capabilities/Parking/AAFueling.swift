import Foundation
import HMUtilities

public final class AAFueling: AACapability, AAPropertyIdentifying {
    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAFueling` was introduced to the spec.
        public static let intro: UInt8 = 4
    
        /// Level (version) of *AutoAPI* when `AAFueling` was last updated.
        public static let updated: UInt8 = 11
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0040 }

    /// Property identifiers for `AAFueling`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case gasFlapLock = 0x02
        case gasFlapPosition = 0x03
    }

    // MARK: Properties
    /// Gas flap lock value.
    public var gasFlapLock: AAProperty<AALockState>?
    
    /// Gas flap position value.
    public var gasFlapPosition: AAProperty<AAPosition>?

    // MARK: Getters
    /// Get `AAFueling` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getGasFlapState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AAFueling` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getGasFlapStateProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getGasFlapState() + ids.map { $0.rawValue }
    }
    
    /// Get `AAFueling` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getGasFlapStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AAFueling` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getGasFlapStatePropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getGasFlapStateAvailability() + ids.map { $0.rawValue }
    }

    // MARK: Setters
    /// Control the gas flap of the vehicle.
    /// 
    /// - parameters:
    ///     - gasFlapLock: Gas flap lock value.
    ///     - gasFlapPosition: Gas flap position value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func controlGasFlap(gasFlapLock: AALockState? = nil, gasFlapPosition: AAPosition? = nil) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.gasFlapLock, value: gasFlapLock))
        properties.append(AAProperty(id: PropertyIdentifier.gasFlapPosition, value: gasFlapPosition))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        gasFlapLock = extract(property: .gasFlapLock)
        gasFlapPosition = extract(property: .gasFlapPosition)
    }
}
