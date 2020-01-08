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
//  AAFueling.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAFueling: AACapability {

    /// Property Identifiers for `AAFueling` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case gasFlapLock = 0x02
        case gasFlapPosition = 0x03
    }


    // MARK: Properties
    
    /// Gas flap lock
    ///
    /// - returns: `AALockState` wrapped in `AAProperty<AALockState>`
    public var gasFlapLock: AAProperty<AALockState>? {
        properties.property(forID: PropertyIdentifier.gasFlapLock)
    }
    
    /// Gas flap position
    ///
    /// - returns: `AAPosition` wrapped in `AAProperty<AAPosition>`
    public var gasFlapPosition: AAProperty<AAPosition>? {
        properties.property(forID: PropertyIdentifier.gasFlapPosition)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0040
    }


    // MARK: Getters
    
    /// Bytes for getting the `AAFueling` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AAFueling`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getGasFlapState() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AAFueling` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AAFueling`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getGasFlapStateProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: Setters
    
    /// Bytes for *control gas flap* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *control gas flap* in `AAFueling`.
    /// 
    /// - parameters:
    ///   - gasFlapLock: gas flap lock as `AALockState`
    ///   - gasFlapPosition: gas flap position as `AAPosition`
    /// - returns: Command's bytes as `Array<UInt8>?`
    public static func controlGasFlap(gasFlapLock: AALockState?, gasFlapPosition: AAPosition?) -> Array<UInt8>? {
        guard (gasFlapLock != nil || gasFlapPosition != nil) else {
            return nil
        }
    
        let props1 = AAProperty(identifier: PropertyIdentifier.gasFlapLock, value: gasFlapLock).bytes + AAProperty(identifier: PropertyIdentifier.gasFlapPosition, value: gasFlapPosition).bytes
    
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + props1
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Gas flap lock", property: gasFlapLock),
            .node(label: "Gas flap position", property: gasFlapPosition)
        ]
    }
}