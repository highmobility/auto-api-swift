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
//  AAIgnition.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAIgnition: AACapability {

    /// Property Identifiers for `AAIgnition` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case status = 0x01
        case accessoriesStatus = 0x02
    }


    // MARK: Properties
    
    /// Accessories status
    ///
    /// - returns: `AAOnOffState` wrapped in `AAProperty<AAOnOffState>`
    public var accessoriesStatus: AAProperty<AAOnOffState>? {
        properties.property(forID: PropertyIdentifier.accessoriesStatus)
    }
    
    /// Status
    ///
    /// - returns: `AAOnOffState` wrapped in `AAProperty<AAOnOffState>`
    public var status: AAProperty<AAOnOffState>? {
        properties.property(forID: PropertyIdentifier.status)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0035
    }


    // MARK: Getters
    
    /// Bytes for getting the `AAIgnition` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AAIgnition`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getIgnitionState() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AAIgnition` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AAIgnition`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getIgnitionProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: Setters
    
    /// Bytes for *turn ignition on off* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *turn ignition on off* in `AAIgnition`.
    /// 
    /// - parameters:
    ///   - status: status as `AAOnOffState`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func turnIgnitionOnOff(status: AAOnOffState) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.status, value: status).bytes
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Accessories status", property: accessoriesStatus),
            .node(label: "Status", property: status)
        ]
    }
}