import Foundation
import HMUtilities

public final class AARemoteControl: AACapability, AAPropertyIdentifying {
    public typealias ControlMode = AARemoteControlControlMode

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AARemoteControl` was introduced to the spec.
        public static let intro: UInt8 = 2
    
        /// Level (version) of *AutoAPI* when `AARemoteControl` was last updated.
        public static let updated: UInt8 = 12
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0027 }

    /// Property identifiers for `AARemoteControl`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case controlMode = 0x01
        case angle = 0x02
        case speed = 0x03		// Non-state property (can't be retrieved)
    }

    // MARK: Properties
    /// Wheel base angle.
    public var angle: AAProperty<Measurement<UnitAngle>>?
    
    /// Control mode value.
    public var controlMode: AAProperty<ControlMode>?

    // MARK: Getters
    /// Get `AARemoteControl` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getControlState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AARemoteControl` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getControlStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }

    // MARK: Setters
    /// To be sent every time the controls for the vehicle wants to be changed or once a second if the controls remain the same. If the vehicle does not receive the command every second it will stop the control mode.
    /// 
    /// - parameters:
    ///     - angle: Wheel base angle.
    ///     - speed: Target speed.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func controlCommand(angle: Measurement<UnitAngle>? = nil, speed: Measurement<UnitSpeed>? = nil) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.angle, value: angle))
        properties.append(AAProperty(id: PropertyIdentifier.speed, value: speed))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Attempt to start the control mode of the vehicle.
    /// 
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func startControl() -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.controlMode.rawValue, value: ControlMode(bytes: [0x02])))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
    
    /// Attempt to stop the control mode of the vehicle.
    /// 
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func stopControl() -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.controlMode.rawValue, value: ControlMode(bytes: [0x05])))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        angle = extract(property: .angle)
        controlMode = extract(property: .controlMode)
    }
}
