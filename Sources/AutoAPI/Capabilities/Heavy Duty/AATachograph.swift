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
//  AATachograph.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AATachograph: AACapability {

    /// Vehicle direction
    public enum VehicleDirection: UInt8, AABytesConvertable {
        case forward = 0x00
        case reverse = 0x01
    }
    
    /// Vehicle overspeed
    public enum VehicleOverspeed: UInt8, AABytesConvertable {
        case noOverspeed = 0x00
        case overspeed = 0x01
    }


    /// Property Identifiers for `AATachograph` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case driversWorkingStates = 0x01
        case driversTimeStates = 0x02
        case driversCardsPresent = 0x03
        case vehicleMotion = 0x04
        case vehicleOverspeed = 0x05
        case vehicleDirection = 0x06
        case vehicleSpeed = 0x07
    }


    // MARK: Properties
    
    /// Drivers cards present
    ///
    /// - returns: Array of `AADriverCardPresent`-s wrapped in `[AAProperty<AADriverCardPresent>]`
    public var driversCardsPresent: [AAProperty<AADriverCardPresent>]? {
        properties.properties(forID: PropertyIdentifier.driversCardsPresent)
    }
    
    /// Drivers time states
    ///
    /// - returns: Array of `AADriverTimeState`-s wrapped in `[AAProperty<AADriverTimeState>]`
    public var driversTimeStates: [AAProperty<AADriverTimeState>]? {
        properties.properties(forID: PropertyIdentifier.driversTimeStates)
    }
    
    /// Drivers working states
    ///
    /// - returns: Array of `AADriverWorkingState`-s wrapped in `[AAProperty<AADriverWorkingState>]`
    public var driversWorkingStates: [AAProperty<AADriverWorkingState>]? {
        properties.properties(forID: PropertyIdentifier.driversWorkingStates)
    }
    
    /// Vehicle direction
    ///
    /// - returns: `VehicleDirection` wrapped in `AAProperty<VehicleDirection>`
    public var vehicleDirection: AAProperty<VehicleDirection>? {
        properties.property(forID: PropertyIdentifier.vehicleDirection)
    }
    
    /// Vehicle motion
    ///
    /// - returns: `AADetected` wrapped in `AAProperty<AADetected>`
    public var vehicleMotion: AAProperty<AADetected>? {
        properties.property(forID: PropertyIdentifier.vehicleMotion)
    }
    
    /// Vehicle overspeed
    ///
    /// - returns: `VehicleOverspeed` wrapped in `AAProperty<VehicleOverspeed>`
    public var vehicleOverspeed: AAProperty<VehicleOverspeed>? {
        properties.property(forID: PropertyIdentifier.vehicleOverspeed)
    }
    
    /// The tachograph vehicle speed in km/h
    ///
    /// - returns: `Int16` wrapped in `AAProperty<Int16>`
    public var vehicleSpeed: AAProperty<Int16>? {
        properties.property(forID: PropertyIdentifier.vehicleSpeed)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0064
    }


    // MARK: Getters
    
    /// Bytes for getting the `AATachograph` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AATachograph`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getTachographState() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AATachograph` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AATachograph`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getTachographProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Drivers cards present", properties: driversCardsPresent),
            .node(label: "Drivers time states", properties: driversTimeStates),
            .node(label: "Drivers working states", properties: driversWorkingStates),
            .node(label: "Vehicle direction", property: vehicleDirection),
            .node(label: "Vehicle motion", property: vehicleMotion),
            .node(label: "Vehicle overspeed", property: vehicleOverspeed),
            .node(label: "Vehicle speed", property: vehicleSpeed)
        ]
    }
}