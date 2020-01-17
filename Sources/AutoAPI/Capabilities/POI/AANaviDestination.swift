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
//  AANaviDestination.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
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
    public static func setNaviDestination(coordinates: AACoordinates, destinationName: String? = nil) -> Array<UInt8> {
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