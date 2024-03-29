import Foundation
import HMUtilities

public final class AARace: AACapability, AAPropertyIdentifying {
    public typealias GearMode = AARaceGearMode
    public typealias VehicleMoving = AARaceVehicleMoving
    public typealias DrivetrainState = AARaceDrivetrainState

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AARace` was introduced to the spec.
        public static let intro: UInt8 = 5
    
        /// Level (version) of *AutoAPI* when `AARace` was last updated.
        public static let updated: UInt8 = 12
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0057 }

    /// Property identifiers for `AARace`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case accelerations = 0x01
        case understeering = 0x02
        case oversteering = 0x03
        case gasPedalPosition = 0x04
        case steeringAngle = 0x05
        case brakePressure = 0x06
        case yawRate = 0x07
        case rearSuspensionSteering = 0x08
        case electronicStabilityProgram = 0x09
        case brakeTorqueVectorings = 0x0a
        case gearMode = 0x0b
        case selectedGear = 0x0c
        case brakePedalPosition = 0x0d
        case brakePedalSwitch = 0x0e
        case clutchPedalSwitch = 0x0f
        case acceleratorPedalIdleSwitch = 0x10
        case acceleratorPedalKickdownSwitch = 0x11
        case vehicleMoving = 0x12
        case drivetrainState = 0x13
        case acceleratorDurations = 0x14
    }

    // MARK: Properties
    /// Accelerations value.
    public var accelerations: [AAProperty<AAAcceleration>]?
    
    /// Duration during which the accelerator pedal has been pressed more than the given percentage..
    public var acceleratorDurations: [AAProperty<AAAcceleratorDuration>]?
    
    /// Accelerator pedal idle switch value.
    public var acceleratorPedalIdleSwitch: AAProperty<AAActiveState>?
    
    /// Accelerator pedal kickdown switch value.
    public var acceleratorPedalKickdownSwitch: AAProperty<AAActiveState>?
    
    /// The brake pedal position between 0.0-1.0, wheras 1.0 (100%) is full brakes.
    public var brakePedalPosition: AAProperty<AAPercentage>?
    
    /// Brake pedal switch value.
    public var brakePedalSwitch: AAProperty<AAActiveState>?
    
    /// Brake pressure.
    public var brakePressure: AAProperty<Measurement<UnitPressure>>?
    
    /// Brake torque vectorings value.
    public var brakeTorqueVectorings: [AAProperty<AABrakeTorqueVectoring>]?
    
    /// Clutch pedal switch value.
    public var clutchPedalSwitch: AAProperty<AAActiveState>?
    
    /// State of the drivetrain for starts..
    public var drivetrainState: AAProperty<DrivetrainState>?
    
    /// Electronic stability program value.
    public var electronicStabilityProgram: AAProperty<AAActiveState>?
    
    /// The gas pedal position between 0.0-1.0, whereas 1.0 (100%) is full throttle.
    public var gasPedalPosition: AAProperty<AAPercentage>?
    
    /// Gear mode value.
    public var gearMode: AAProperty<GearMode>?
    
    /// The oversteering percentage between 0.0-1.0 whereas up to 0.2 (20%) is considered OK, up to 30% marginal, over 30% critical.
    public var oversteering: AAProperty<AAPercentage>?
    
    /// Rear suspension steering.
    public var rearSuspensionSteering: AAProperty<Measurement<UnitAngle>>?
    
    /// The selected gear value, if any.
    public var selectedGear: AAProperty<Int8>?
    
    /// The steering angle, whereas 0.0 is straight ahead, positive number to the right and negative number to the left.
    public var steeringAngle: AAProperty<Measurement<UnitAngle>>?
    
    /// The understeering percentage between 0.0-1.0 whereas up to 0.2 (20%) is considered OK, up to 0.3 (30%) marginal, over 30% critical.
    public var understeering: AAProperty<AAPercentage>?
    
    /// Vehicle moving value.
    public var vehicleMoving: AAProperty<VehicleMoving>?
    
    /// Yaw turning rate.
    public var yawRate: AAProperty<Measurement<UnitAngularVelocity>>?

    // MARK: Getters
    /// Get `AARace` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getRaceState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AARace` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getRaceStateProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getRaceState() + ids.map { $0.rawValue }
    }
    
    /// Get `AARace` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getRaceStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AARace` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getRaceStatePropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getRaceStateAvailability() + ids.map { $0.rawValue }
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        accelerations = extract(properties: .accelerations)
        acceleratorDurations = extract(properties: .acceleratorDurations)
        acceleratorPedalIdleSwitch = extract(property: .acceleratorPedalIdleSwitch)
        acceleratorPedalKickdownSwitch = extract(property: .acceleratorPedalKickdownSwitch)
        brakePedalPosition = extract(property: .brakePedalPosition)
        brakePedalSwitch = extract(property: .brakePedalSwitch)
        brakePressure = extract(property: .brakePressure)
        brakeTorqueVectorings = extract(properties: .brakeTorqueVectorings)
        clutchPedalSwitch = extract(property: .clutchPedalSwitch)
        drivetrainState = extract(property: .drivetrainState)
        electronicStabilityProgram = extract(property: .electronicStabilityProgram)
        gasPedalPosition = extract(property: .gasPedalPosition)
        gearMode = extract(property: .gearMode)
        oversteering = extract(property: .oversteering)
        rearSuspensionSteering = extract(property: .rearSuspensionSteering)
        selectedGear = extract(property: .selectedGear)
        steeringAngle = extract(property: .steeringAngle)
        understeering = extract(property: .understeering)
        vehicleMoving = extract(property: .vehicleMoving)
        yawRate = extract(property: .yawRate)
    }
}
