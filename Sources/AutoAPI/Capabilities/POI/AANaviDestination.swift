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
//  AANaviDestination.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AANaviDestination: AACapability {

    /// Property Identifiers for `AANaviDestination` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case coordinates = 0x01
        case destinationName = 0x02
        case dataSlotsFree = 0x03
        case dataSlotsMax = 0x04
        case arrivalDuration = 0x05
        case distanceToDestination = 0x06
    }


    // MARK: Properties
    
    /// Remaining time until reaching the destination.
    ///
    /// - returns: `AATime` wrapped in `AAProperty<AATime>`
    public var arrivalDuration: AAProperty<AATime>? {
        properties.property(forID: PropertyIdentifier.arrivalDuration)
    }
    
    /// Coordinates
    ///
    /// - returns: `AACoordinates` wrapped in `AAProperty<AACoordinates>`
    public var coordinates: AAProperty<AACoordinates>? {
        properties.property(forID: PropertyIdentifier.coordinates)
    }
    
    /// Remaining number of POI data slots available.
    ///
    /// - returns: `UInt8` wrapped in `AAProperty<UInt8>`
    public var dataSlotsFree: AAProperty<UInt8>? {
        properties.property(forID: PropertyIdentifier.dataSlotsFree)
    }
    
    /// Maximum number of POI data slots.
    ///
    /// - returns: `UInt8` wrapped in `AAProperty<UInt8>`
    public var dataSlotsMax: AAProperty<UInt8>? {
        properties.property(forID: PropertyIdentifier.dataSlotsMax)
    }
    
    /// Destination name
    ///
    /// - returns: `String` wrapped in `AAProperty<String>`
    public var destinationName: AAProperty<String>? {
        properties.property(forID: PropertyIdentifier.destinationName)
    }
    
    /// Remaining distance to reach the destination.
    ///
    /// - returns: `UInt16` wrapped in `AAProperty<UInt16>`
    public var distanceToDestination: AAProperty<UInt16>? {
        properties.property(forID: PropertyIdentifier.distanceToDestination)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0031
    }


    // MARK: Getters
    
    /// Bytes for getting the `AANaviDestination` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AANaviDestination`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getNaviDestination() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AANaviDestination` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AANaviDestination`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getNaviDestinationProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: Setters
    
    /// Bytes for *set navi destination* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *set navi destination* in `AANaviDestination`.
    /// 
    /// - parameters:
    ///   - coordinates: coordinates as `AACoordinates`
    ///   - destinationName: Destination name as `String`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func setNaviDestination(coordinates: AACoordinates, destinationName: String?) -> Array<UInt8> {
        let props1 = AAProperty(identifier: PropertyIdentifier.coordinates, value: coordinates).bytes + AAProperty(identifier: PropertyIdentifier.destinationName, value: destinationName).bytes
    
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + props1
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Arrival duration", property: arrivalDuration),
            .node(label: "Coordinates", property: coordinates),
            .node(label: "Data slots free", property: dataSlotsFree),
            .node(label: "Data slots max", property: dataSlotsMax),
            .node(label: "Destination name", property: destinationName),
            .node(label: "Distance to destination", property: distanceToDestination)
        ]
    }
}