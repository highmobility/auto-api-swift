//
// AutoAPI
// Copyright (C) 2020 High-Mobility GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//
// Please inquire about commercial licensing options at
// licensing@high-mobility.com
//
//
//  AADiagnostics.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AADiagnostics: AACapability {

    /// Property Identifiers for `AADiagnostics` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case mileage = 0x01
        case engineOilTemperature = 0x02
        case speed = 0x03
        case engineRPM = 0x04
        case fuelLevel = 0x05
        case estimatedRange = 0x06
        case washerFluidLevel = 0x09
        case batteryVoltage = 0x0b
        case adBlueLevel = 0x0c
        case distanceSinceReset = 0x0d
        case distanceSinceStart = 0x0e
        case fuelVolume = 0x0f
        case antiLockBraking = 0x10
        case engineCoolantTemperature = 0x11
        case engineTotalOperatingHours = 0x12
        case engineTotalFuelConsumption = 0x13
        case brakeFluidLevel = 0x14
        case engineTorque = 0x15
        case engineLoad = 0x16
        case wheelBasedSpeed = 0x17
        case batteryLevel = 0x18
        case checkControlMessages = 0x19
        case tirePressures = 0x1a
        case tireTemperatures = 0x1b
        case wheelRPMs = 0x1c
        case troubleCodes = 0x1d
        case mileageMeters = 0x1e
    }


    // MARK: Properties
    
    /// AdBlue level in liters
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var adBlueLevel: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.adBlueLevel)
    }
    
    /// Anti lock braking
    ///
    /// - returns: `AAActiveState` wrapped in `AAProperty<AAActiveState>`
    public var antiLockBraking: AAProperty<AAActiveState>? {
        properties.property(forID: PropertyIdentifier.antiLockBraking)
    }
    
    /// Battery level in %, value between 0.0 and 1.0
    ///
    /// - returns: `AAPercentage` wrapped in `AAProperty<AAPercentage>`
    public var batteryLevel: AAProperty<AAPercentage>? {
        properties.property(forID: PropertyIdentifier.batteryLevel)
    }
    
    /// Battery voltage
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var batteryVoltage: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.batteryVoltage)
    }
    
    /// Brake fluid level
    ///
    /// - returns: `AAFluidLevel` wrapped in `AAProperty<AAFluidLevel>`
    public var brakeFluidLevel: AAProperty<AAFluidLevel>? {
        properties.property(forID: PropertyIdentifier.brakeFluidLevel)
    }
    
    /// Check control messages
    ///
    /// - returns: Array of `AACheckControlMessage`-s wrapped in `[AAProperty<AACheckControlMessage>]`
    public var checkControlMessages: [AAProperty<AACheckControlMessage>]? {
        properties.properties(forID: PropertyIdentifier.checkControlMessages)
    }
    
    /// The distance driven in km since reset
    ///
    /// - returns: `UInt16` wrapped in `AAProperty<UInt16>`
    public var distanceSinceReset: AAProperty<UInt16>? {
        properties.property(forID: PropertyIdentifier.distanceSinceReset)
    }
    
    /// The distance driven in km since trip start
    ///
    /// - returns: `UInt16` wrapped in `AAProperty<UInt16>`
    public var distanceSinceStart: AAProperty<UInt16>? {
        properties.property(forID: PropertyIdentifier.distanceSinceStart)
    }
    
    /// Engine coolant temperature in Celsius, whereas can be negative
    ///
    /// - returns: `Int16` wrapped in `AAProperty<Int16>`
    public var engineCoolantTemperature: AAProperty<Int16>? {
        properties.property(forID: PropertyIdentifier.engineCoolantTemperature)
    }
    
    /// Current engine load percentage between 0.0-1.0
    ///
    /// - returns: `AAPercentage` wrapped in `AAProperty<AAPercentage>`
    public var engineLoad: AAProperty<AAPercentage>? {
        properties.property(forID: PropertyIdentifier.engineLoad)
    }
    
    /// Engine oil temperature in Celsius, whereas can be negative
    ///
    /// - returns: `Int16` wrapped in `AAProperty<Int16>`
    public var engineOilTemperature: AAProperty<Int16>? {
        properties.property(forID: PropertyIdentifier.engineOilTemperature)
    }
    
    /// Engine RPM (revolutions per minute)
    ///
    /// - returns: `UInt16` wrapped in `AAProperty<UInt16>`
    public var engineRPM: AAProperty<UInt16>? {
        properties.property(forID: PropertyIdentifier.engineRPM)
    }
    
    /// Current engine torque percentage between 0.0-1.0
    ///
    /// - returns: `AAPercentage` wrapped in `AAProperty<AAPercentage>`
    public var engineTorque: AAProperty<AAPercentage>? {
        properties.property(forID: PropertyIdentifier.engineTorque)
    }
    
    /// The accumulated lifespan fuel consumption in liters
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var engineTotalFuelConsumption: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.engineTotalFuelConsumption)
    }
    
    /// The accumulated time of engine operation
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var engineTotalOperatingHours: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.engineTotalOperatingHours)
    }
    
    /// Estimated range (with combustion engine)
    ///
    /// - returns: `Int16` wrapped in `AAProperty<Int16>`
    public var estimatedRange: AAProperty<Int16>? {
        properties.property(forID: PropertyIdentifier.estimatedRange)
    }
    
    /// Fuel level percentage between 0.0-1.0
    ///
    /// - returns: `AAPercentage` wrapped in `AAProperty<AAPercentage>`
    public var fuelLevel: AAProperty<AAPercentage>? {
        properties.property(forID: PropertyIdentifier.fuelLevel)
    }
    
    /// The fuel volume measured in liters
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var fuelVolume: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.fuelVolume)
    }
    
    /// The car mileage (odometer) in km
    ///
    /// - returns: `UInt32` wrapped in `AAProperty<UInt32>`
    public var mileage: AAProperty<UInt32>? {
        properties.property(forID: PropertyIdentifier.mileage)
    }
    
    /// The car mileage (odometer) in meters
    ///
    /// - returns: `UInt32` wrapped in `AAProperty<UInt32>`
    public var mileageMeters: AAProperty<UInt32>? {
        properties.property(forID: PropertyIdentifier.mileageMeters)
    }
    
    /// The vehicle speed in km/h, whereas can be negative
    ///
    /// - returns: `Int16` wrapped in `AAProperty<Int16>`
    public var speed: AAProperty<Int16>? {
        properties.property(forID: PropertyIdentifier.speed)
    }
    
    /// Tire pressures
    ///
    /// - returns: Array of `AATirePressure`-s wrapped in `[AAProperty<AATirePressure>]`
    public var tirePressures: [AAProperty<AATirePressure>]? {
        properties.properties(forID: PropertyIdentifier.tirePressures)
    }
    
    /// Tire temperatures
    ///
    /// - returns: Array of `AATireTemperature`-s wrapped in `[AAProperty<AATireTemperature>]`
    public var tireTemperatures: [AAProperty<AATireTemperature>]? {
        properties.properties(forID: PropertyIdentifier.tireTemperatures)
    }
    
    /// Trouble codes
    ///
    /// - returns: Array of `AATroubleCode`-s wrapped in `[AAProperty<AATroubleCode>]`
    public var troubleCodes: [AAProperty<AATroubleCode>]? {
        properties.properties(forID: PropertyIdentifier.troubleCodes)
    }
    
    /// Washer fluid level
    ///
    /// - returns: `AAFluidLevel` wrapped in `AAProperty<AAFluidLevel>`
    public var washerFluidLevel: AAProperty<AAFluidLevel>? {
        properties.property(forID: PropertyIdentifier.washerFluidLevel)
    }
    
    /// The vehicle speed in km/h measured at the wheel base, whereas can be negative
    ///
    /// - returns: `Int16` wrapped in `AAProperty<Int16>`
    public var wheelBasedSpeed: AAProperty<Int16>? {
        properties.property(forID: PropertyIdentifier.wheelBasedSpeed)
    }
    
    /// Wheel rpms
    ///
    /// - returns: Array of `AAWheelRPM`-s wrapped in `[AAProperty<AAWheelRPM>]`
    public var wheelRPMs: [AAProperty<AAWheelRPM>]? {
        properties.properties(forID: PropertyIdentifier.wheelRPMs)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0033
    }


    // MARK: Getters
    
    /// Bytes for getting the `AADiagnostics` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AADiagnostics`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getDiagnosticsState() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AADiagnostics` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AADiagnostics`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getDiagnosticsProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "AdBlue level", property: adBlueLevel),
            .node(label: "Anti-lock braking system (ABS)", property: antiLockBraking),
            .node(label: "Battery level", property: batteryLevel),
            .node(label: "Battery voltage", property: batteryVoltage),
            .node(label: "Brake fluid level", property: brakeFluidLevel),
            .node(label: "Check control messages", properties: checkControlMessages),
            .node(label: "Distance since reset", property: distanceSinceReset),
            .node(label: "Distance since start", property: distanceSinceStart),
            .node(label: "Engine coolant temperature", property: engineCoolantTemperature),
            .node(label: "Engine load", property: engineLoad),
            .node(label: "Engine oil temperature", property: engineOilTemperature),
            .node(label: "Engine RPM", property: engineRPM),
            .node(label: "Engine torque", property: engineTorque),
            .node(label: "Engine total fuel consumption", property: engineTotalFuelConsumption),
            .node(label: "Engine total operation hours", property: engineTotalOperatingHours),
            .node(label: "Estimate range", property: estimatedRange),
            .node(label: "Fuel level", property: fuelLevel),
            .node(label: "Fuel volume", property: fuelVolume),
            .node(label: "Mileage", property: mileage),
            .node(label: "Mileage meters", property: mileageMeters),
            .node(label: "Speed", property: speed),
            .node(label: "Tire pressures", properties: tirePressures),
            .node(label: "Tire temperatures", properties: tireTemperatures),
            .node(label: "Trouble codes", properties: troubleCodes),
            .node(label: "Washer fluid level", property: washerFluidLevel),
            .node(label: "Wheel based speed", property: wheelBasedSpeed),
            .node(label: "Wheel RPMs", properties: wheelRPMs)
        ]
    }
}