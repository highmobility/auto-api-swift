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
//  AAOffroad.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAOffroad: AACapability {

    /// Property Identifiers for `AAOffroad` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case routeIncline = 0x01
        case wheelSuspension = 0x02
    }


    // MARK: Properties
    
    /// The route elevation incline in degrees, which is a negative number for decline
    ///
    /// - returns: `Int16` wrapped in `AAProperty<Int16>`
    public var routeIncline: AAProperty<Int16>? {
        properties.property(forID: PropertyIdentifier.routeIncline)
    }
    
    /// The wheel suspension level percentage, whereas 0.0 is no suspension and 1.0 maximum suspension
    ///
    /// - returns: `AAPercentage` wrapped in `AAProperty<AAPercentage>`
    public var wheelSuspension: AAProperty<AAPercentage>? {
        properties.property(forID: PropertyIdentifier.wheelSuspension)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0052
    }


    // MARK: Getters
    
    /// Bytes for getting the `AAOffroad` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AAOffroad`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getOffroadState() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AAOffroad` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AAOffroad`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getOffroadProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Route incline", property: routeIncline),
            .node(label: "Wheel suspension", property: wheelSuspension)
        ]
    }
}