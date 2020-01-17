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
//  AAVehicleLocation.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAVehicleLocation: AACapability {

    /// Property Identifiers for `AAVehicleLocation` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case coordinates = 0x04
        case heading = 0x05
        case altitude = 0x06
    }


    // MARK: Properties
    
    /// Altitude in meters above the WGS 84 reference ellipsoid
    ///
    /// - returns: `Double` wrapped in `AAProperty<Double>`
    public var altitude: AAProperty<Double>? {
        properties.property(forID: PropertyIdentifier.altitude)
    }
    
    /// Coordinates
    ///
    /// - returns: `AACoordinates` wrapped in `AAProperty<AACoordinates>`
    public var coordinates: AAProperty<AACoordinates>? {
        properties.property(forID: PropertyIdentifier.coordinates)
    }
    
    /// Heading in degrees
    ///
    /// - returns: `Double` wrapped in `AAProperty<Double>`
    public var heading: AAProperty<Double>? {
        properties.property(forID: PropertyIdentifier.heading)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0030
    }


    // MARK: Getters
    
    /// Bytes for getting the `AAVehicleLocation` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AAVehicleLocation`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getVehicleLocation() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AAVehicleLocation` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AAVehicleLocation`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getVehicleLocationProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Altitude", property: altitude),
            .node(label: "Coordinates", property: coordinates),
            .node(label: "Heading", property: heading)
        ]
    }
}