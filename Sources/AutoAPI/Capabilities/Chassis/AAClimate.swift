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
//  AAClimate.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAClimate: AACapability {

    /// Property Identifiers for `AAClimate` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case insideTemperature = 0x01
        case outsideTemperature = 0x02
        case driverTemperatureSetting = 0x03
        case passengerTemperatureSetting = 0x04
        case hvacState = 0x05
        case defoggingState = 0x06
        case defrostingState = 0x07
        case ionisingState = 0x08
        case defrostingTemperatureSetting = 0x09
        case hvacWeekdayStartingTimes = 0x0b
        case rearTemperatureSetting = 0x0c
    }


    // MARK: Properties
    
    /// Defogging state
    ///
    /// - returns: `AAActiveState` wrapped in `AAProperty<AAActiveState>`
    public var defoggingState: AAProperty<AAActiveState>? {
        properties.property(forID: PropertyIdentifier.defoggingState)
    }
    
    /// Defrosting state
    ///
    /// - returns: `AAActiveState` wrapped in `AAProperty<AAActiveState>`
    public var defrostingState: AAProperty<AAActiveState>? {
        properties.property(forID: PropertyIdentifier.defrostingState)
    }
    
    /// The defrosting temperature setting in celsius
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var defrostingTemperatureSetting: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.defrostingTemperatureSetting)
    }
    
    /// The driver temperature setting in celsius
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var driverTemperatureSetting: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.driverTemperatureSetting)
    }
    
    /// Hvac state
    ///
    /// - returns: `AAActiveState` wrapped in `AAProperty<AAActiveState>`
    public var hvacState: AAProperty<AAActiveState>? {
        properties.property(forID: PropertyIdentifier.hvacState)
    }
    
    /// Hvac weekday starting times
    ///
    /// - returns: Array of `AAHVACWeekdayStartingTime`-s wrapped in `[AAProperty<AAHVACWeekdayStartingTime>]`
    public var hvacWeekdayStartingTimes: [AAProperty<AAHVACWeekdayStartingTime>]? {
        properties.properties(forID: PropertyIdentifier.hvacWeekdayStartingTimes)
    }
    
    /// The inside temperature in celsius
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var insideTemperature: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.insideTemperature)
    }
    
    /// Ionising state
    ///
    /// - returns: `AAActiveState` wrapped in `AAProperty<AAActiveState>`
    public var ionisingState: AAProperty<AAActiveState>? {
        properties.property(forID: PropertyIdentifier.ionisingState)
    }
    
    /// The outside temperature in celsius
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var outsideTemperature: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.outsideTemperature)
    }
    
    /// The passenger temperature setting in celsius
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var passengerTemperatureSetting: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.passengerTemperatureSetting)
    }
    
    /// The rear temperature in celsius
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var rearTemperatureSetting: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.rearTemperatureSetting)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0024
    }


    // MARK: Getters
    
    /// Bytes for getting the `AAClimate` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AAClimate`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getClimateState() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AAClimate` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AAClimate`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getClimateProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: Setters
    
    /// Bytes for *change starting times* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *change starting times* in `AAClimate`.
    /// 
    /// - parameters:
    ///   - hvacWeekdayStartingTimes: hvac weekday starting times as `[AAHVACWeekdayStartingTime]`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func changeStartingTimes(hvacWeekdayStartingTimes: [AAHVACWeekdayStartingTime]) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty.multiple(identifier: PropertyIdentifier.hvacWeekdayStartingTimes, values: hvacWeekdayStartingTimes).flatMap { $0.bytes }
    }
    
    /// Bytes for *start stop hvac* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *start stop hvac* in `AAClimate`.
    /// 
    /// - parameters:
    ///   - hvacState: hvac state as `AAActiveState`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func startStopHvac(hvacState: AAActiveState) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.hvacState, value: hvacState).bytes
    }
    
    /// Bytes for *start stop defogging* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *start stop defogging* in `AAClimate`.
    /// 
    /// - parameters:
    ///   - defoggingState: defogging state as `AAActiveState`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func startStopDefogging(defoggingState: AAActiveState) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.defoggingState, value: defoggingState).bytes
    }
    
    /// Bytes for *start stop defrosting* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *start stop defrosting* in `AAClimate`.
    /// 
    /// - parameters:
    ///   - defrostingState: defrosting state as `AAActiveState`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func startStopDefrosting(defrostingState: AAActiveState) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.defrostingState, value: defrostingState).bytes
    }
    
    /// Bytes for *start stop ionising* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *start stop ionising* in `AAClimate`.
    /// 
    /// - parameters:
    ///   - ionisingState: ionising state as `AAActiveState`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func startStopIonising(ionisingState: AAActiveState) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.ionisingState, value: ionisingState).bytes
    }
    
    /// Bytes for *set temperature settings* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *set temperature settings* in `AAClimate`.
    /// 
    /// - parameters:
    ///   - driverTemperatureSetting: The driver temperature setting in celsius as `Float`
    ///   - passengerTemperatureSetting: The passenger temperature setting in celsius as `Float`
    ///   - rearTemperatureSetting: The rear temperature in celsius as `Float`
    /// - returns: Command's bytes as `Array<UInt8>?`
    public static func setTemperatureSettings(driverTemperatureSetting: Float?, passengerTemperatureSetting: Float?, rearTemperatureSetting: Float?) -> Array<UInt8>? {
        guard (driverTemperatureSetting != nil || passengerTemperatureSetting != nil || rearTemperatureSetting != nil) else {
            return nil
        }
    
        let props1 = AAProperty(identifier: PropertyIdentifier.driverTemperatureSetting, value: driverTemperatureSetting).bytes + AAProperty(identifier: PropertyIdentifier.passengerTemperatureSetting, value: passengerTemperatureSetting).bytes + AAProperty(identifier: PropertyIdentifier.rearTemperatureSetting, value: rearTemperatureSetting).bytes
    
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + props1
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Defogging state", property: defoggingState),
            .node(label: "Defrosting state", property: defrostingState),
            .node(label: "Defrosting temperature setting", property: defrostingTemperatureSetting),
            .node(label: "Driver temperature setting", property: driverTemperatureSetting),
            .node(label: "HVAC state", property: hvacState),
            .node(label: "HVAC weekday starting times", properties: hvacWeekdayStartingTimes),
            .node(label: "Inside temperature", property: insideTemperature),
            .node(label: "Ionising state", property: ionisingState),
            .node(label: "Outside temperature", property: outsideTemperature),
            .node(label: "Passenger temperature setting", property: passengerTemperatureSetting),
            .node(label: "Rear temperature setting", property: rearTemperatureSetting)
        ]
    }
}