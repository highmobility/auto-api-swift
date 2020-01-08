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
//  AATachograph.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
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