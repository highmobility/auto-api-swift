//
//  The MIT License
//
//  Copyright (c) 2014- High-Mobility GmbH (https://high-mobility.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//
//  AARace.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AARace: AACapability {

    /// Gear mode
    public enum GearMode: UInt8, AABytesConvertable {
        case manual = 0x00
        case park = 0x01
        case reverse = 0x02
        case neutral = 0x03
        case drive = 0x04
        case lowGear = 0x05
        case sport = 0x06
    }
    
    /// Vehicle moving
    public enum VehicleMoving: UInt8, AABytesConvertable {
        case notMoving = 0x00
        case moving = 0x01
    }


    /// Property Identifiers for `AARace` capability.
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
    }


    // MARK: Properties
    
    /// Accelerations
    ///
    /// - returns: Array of `AAAcceleration`-s wrapped in `[AAProperty<AAAcceleration>]`
    public var accelerations: [AAProperty<AAAcceleration>]? {
        properties.properties(forID: PropertyIdentifier.accelerations)
    }
    
    /// Accelerator pedal idle switch
    ///
    /// - returns: `AAActiveState` wrapped in `AAProperty<AAActiveState>`
    public var acceleratorPedalIdleSwitch: AAProperty<AAActiveState>? {
        properties.property(forID: PropertyIdentifier.acceleratorPedalIdleSwitch)
    }
    
    /// Accelerator pedal kickdown switch
    ///
    /// - returns: `AAActiveState` wrapped in `AAProperty<AAActiveState>`
    public var acceleratorPedalKickdownSwitch: AAProperty<AAActiveState>? {
        properties.property(forID: PropertyIdentifier.acceleratorPedalKickdownSwitch)
    }
    
    /// The brake pedal position between 0.0-1.0, wheras 1.0 (100%) is full brakes
    ///
    /// - returns: `AAPercentage` wrapped in `AAProperty<AAPercentage>`
    public var brakePedalPosition: AAProperty<AAPercentage>? {
        properties.property(forID: PropertyIdentifier.brakePedalPosition)
    }
    
    /// Brake pedal switch
    ///
    /// - returns: `AAActiveState` wrapped in `AAProperty<AAActiveState>`
    public var brakePedalSwitch: AAProperty<AAActiveState>? {
        properties.property(forID: PropertyIdentifier.brakePedalSwitch)
    }
    
    /// Brake pressure in bar, whereas 100 bar is max value, full brake
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var brakePressure: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.brakePressure)
    }
    
    /// Brake torque vectorings
    ///
    /// - returns: Array of `AABrakeTorqueVectoring`-s wrapped in `[AAProperty<AABrakeTorqueVectoring>]`
    public var brakeTorqueVectorings: [AAProperty<AABrakeTorqueVectoring>]? {
        properties.properties(forID: PropertyIdentifier.brakeTorqueVectorings)
    }
    
    /// Clutch pedal switch
    ///
    /// - returns: `AAActiveState` wrapped in `AAProperty<AAActiveState>`
    public var clutchPedalSwitch: AAProperty<AAActiveState>? {
        properties.property(forID: PropertyIdentifier.clutchPedalSwitch)
    }
    
    /// Electronic stability program
    ///
    /// - returns: `AAActiveState` wrapped in `AAProperty<AAActiveState>`
    public var electronicStabilityProgram: AAProperty<AAActiveState>? {
        properties.property(forID: PropertyIdentifier.electronicStabilityProgram)
    }
    
    /// The gas pedal position between 0.0-1.0, whereas 1.0 (100%) is full throttle
    ///
    /// - returns: `AAPercentage` wrapped in `AAProperty<AAPercentage>`
    public var gasPedalPosition: AAProperty<AAPercentage>? {
        properties.property(forID: PropertyIdentifier.gasPedalPosition)
    }
    
    /// Gear mode
    ///
    /// - returns: `GearMode` wrapped in `AAProperty<GearMode>`
    public var gearMode: AAProperty<GearMode>? {
        properties.property(forID: PropertyIdentifier.gearMode)
    }
    
    /// The oversteering percentage between 0.0-1.0 whereas up to 0.2 (20%) is considered OK, up to 30% marginal, over 30% critical
    ///
    /// - returns: `AAPercentage` wrapped in `AAProperty<AAPercentage>`
    public var oversteering: AAProperty<AAPercentage>? {
        properties.property(forID: PropertyIdentifier.oversteering)
    }
    
    /// Rear suspension steering in degrees
    ///
    /// - returns: `Int8` wrapped in `AAProperty<Int8>`
    public var rearSuspensionSteering: AAProperty<Int8>? {
        properties.property(forID: PropertyIdentifier.rearSuspensionSteering)
    }
    
    /// The selected gear value, if any
    ///
    /// - returns: `Int8` wrapped in `AAProperty<Int8>`
    public var selectedGear: AAProperty<Int8>? {
        properties.property(forID: PropertyIdentifier.selectedGear)
    }
    
    /// The steering angle in degrees, whereas 0° is straight ahead, positive number to the right and negative number to the left
    ///
    /// - returns: `Int8` wrapped in `AAProperty<Int8>`
    public var steeringAngle: AAProperty<Int8>? {
        properties.property(forID: PropertyIdentifier.steeringAngle)
    }
    
    /// The understeering percentage between 0.0-1.0 whereas up to 0.2 (20%) is considered OK, up to 0.3 (30%) marginal, over 30% critical
    ///
    /// - returns: `AAPercentage` wrapped in `AAProperty<AAPercentage>`
    public var understeering: AAProperty<AAPercentage>? {
        properties.property(forID: PropertyIdentifier.understeering)
    }
    
    /// Vehicle moving
    ///
    /// - returns: `VehicleMoving` wrapped in `AAProperty<VehicleMoving>`
    public var vehicleMoving: AAProperty<VehicleMoving>? {
        properties.property(forID: PropertyIdentifier.vehicleMoving)
    }
    
    /// Yaw rate in degrees per second [°/s]
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var yawRate: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.yawRate)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0057
    }


    // MARK: Getters
    
    /// Bytes for getting the `AARace` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AARace`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getRaceState() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AARace` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AARace`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getRaceProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Accelerations", properties: accelerations),
            .node(label: "Accelerator pedal idle switch", property: acceleratorPedalIdleSwitch),
            .node(label: "Accelerator pedal kickdown switch", property: acceleratorPedalKickdownSwitch),
            .node(label: "Brake pedal position", property: brakePedalPosition),
            .node(label: "Brake pedal switch", property: brakePedalSwitch),
            .node(label: "Brake pressure", property: brakePressure),
            .node(label: "Brake torque vectorings", properties: brakeTorqueVectorings),
            .node(label: "Clutch pedal switch", property: clutchPedalSwitch),
            .node(label: "Electronic stability program", property: electronicStabilityProgram),
            .node(label: "Gas pedal position", property: gasPedalPosition),
            .node(label: "Gear mode", property: gearMode),
            .node(label: "Oversteering", property: oversteering),
            .node(label: "Rear suspension steering", property: rearSuspensionSteering),
            .node(label: "Selected gear", property: selectedGear),
            .node(label: "Steering angle", property: steeringAngle),
            .node(label: "Understeering", property: understeering),
            .node(label: "Vehicle moving", property: vehicleMoving),
            .node(label: "Yaw rate", property: yawRate)
        ]
    }
}