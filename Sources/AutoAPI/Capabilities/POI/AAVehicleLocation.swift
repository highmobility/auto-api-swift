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
//  AAVehicleLocation.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
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