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
//  AATrunk.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AATrunk: AACapability {

    /// Property Identifiers for `AATrunk` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case lock = 0x01
        case position = 0x02
    }


    // MARK: Properties
    
    /// Lock
    ///
    /// - returns: `AALockState` wrapped in `AAProperty<AALockState>`
    public var lock: AAProperty<AALockState>? {
        properties.property(forID: PropertyIdentifier.lock)
    }
    
    /// Position
    ///
    /// - returns: `AAPosition` wrapped in `AAProperty<AAPosition>`
    public var position: AAProperty<AAPosition>? {
        properties.property(forID: PropertyIdentifier.position)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0021
    }


    // MARK: Getters
    
    /// Bytes for getting the `AATrunk` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AATrunk`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getTrunkState() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AATrunk` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AATrunk`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getTrunkProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: Setters
    
    /// Bytes for *control trunk* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *control trunk* in `AATrunk`.
    /// 
    /// - parameters:
    ///   - lock: lock as `AALockState`
    ///   - position: position as `AAPosition`
    /// - returns: Command's bytes as `Array<UInt8>?`
    public static func controlTrunk(lock: AALockState?, position: AAPosition?) -> Array<UInt8>? {
        guard (lock != nil || position != nil) else {
            return nil
        }
    
        let props1 = AAProperty(identifier: PropertyIdentifier.lock, value: lock).bytes + AAProperty(identifier: PropertyIdentifier.position, value: position).bytes
    
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + props1
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Lock", property: lock),
            .node(label: "Position", property: position)
        ]
    }
}