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
//  AALightConditions.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AALightConditions: AACapability {

    /// Property Identifiers for `AALightConditions` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case outsideLight = 0x01
        case insideLight = 0x02
    }


    // MARK: Properties
    
    /// Measured inside illuminance in lux
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var insideLight: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.insideLight)
    }
    
    /// Measured outside illuminance in lux
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var outsideLight: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.outsideLight)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0054
    }


    // MARK: Getters
    
    /// Bytes for getting the `AALightConditions` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AALightConditions`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getLightConditions() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AALightConditions` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AALightConditions`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getLightConditionsProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Inside light", property: insideLight),
            .node(label: "Outside light", property: outsideLight)
        ]
    }
}