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
//  AAEngineStartStop.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAEngineStartStop: AACapability {

    /// Property Identifiers for `AAEngineStartStop` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case status = 0x01
    }


    // MARK: Properties
    
    /// Status
    ///
    /// - returns: `AAActiveState` wrapped in `AAProperty<AAActiveState>`
    public var status: AAProperty<AAActiveState>? {
        properties.property(forID: PropertyIdentifier.status)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0063
    }


    // MARK: Getters
    
    /// Bytes for getting the `AAEngineStartStop` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AAEngineStartStop`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getEngineStartStopState() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }


    // MARK: Setters
    
    /// Bytes for *activate deactivate start stop* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *activate deactivate start stop* in `AAEngineStartStop`.
    /// 
    /// - parameters:
    ///   - status: status as `AAActiveState`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func activateDeactivateStartStop(status: AAActiveState) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.status, value: status).bytes
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Status", property: status)
        ]
    }
}