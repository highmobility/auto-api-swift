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
//  AAClimate.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
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
    public static func setTemperatureSettings(driverTemperatureSetting: Float? = nil, passengerTemperatureSetting: Float? = nil, rearTemperatureSetting: Float? = nil) -> Array<UInt8>? {
        guard driverTemperatureSetting != nil || passengerTemperatureSetting != nil || rearTemperatureSetting != nil else {
            return nil
        }

        var propertiesBytesArray: [[UInt8]?] = []

        propertiesBytesArray.append(driverTemperatureSetting?.property(identifier: PropertyIdentifier.driverTemperatureSetting).bytes)
        propertiesBytesArray.append(passengerTemperatureSetting?.property(identifier: PropertyIdentifier.passengerTemperatureSetting).bytes)
        propertiesBytesArray.append(rearTemperatureSetting?.property(identifier: PropertyIdentifier.rearTemperatureSetting).bytes)

        return AAAutoAPI.protocolVersion.bytes +
            Self.identifier.bytes +
            [AACommandType.set.rawValue] +
            propertiesBytesArray.compactMap { $0 }.flatMap { $0 }
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
