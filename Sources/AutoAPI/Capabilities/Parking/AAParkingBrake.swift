import Foundation
import HMUtilities

public final class AAParkingBrake: AACapability, AAPropertyIdentifying {
    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAParkingBrake` was introduced to the spec.
        public static let intro: UInt8 = 5
    
        /// Level (version) of *AutoAPI* when `AAParkingBrake` was last updated.
        public static let updated: UInt8 = 11
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0058 }

    /// Property identifiers for `AAParkingBrake`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case status = 0x01
    }

    // MARK: Properties
    /// Status value.
    public var status: AAProperty<AAActiveState>?

    // MARK: Getters
    /// Get `AAParkingBrake` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getParkingBrakeState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AAParkingBrake` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getParkingBrakeStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }

    // MARK: Setters
    /// Turn on or off the parking brake.
    /// 
    /// - parameters:
    ///     - status: Status value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func setParkingBrake(status: AAActiveState) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.status, value: status))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        status = extract(property: .status)
    }
}
