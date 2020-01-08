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
//  AAHistorical.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAHistorical: AACapability {

    /// Property Identifiers for `AAHistorical` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case states = 0x01
        case capabilityID = 0x02
        case startDate = 0x03
        case endDate = 0x04
    }


    // MARK: Properties
    
    /// The bytes of a Capability state
    ///
    /// - returns: Array of `AACapabilityState`-s wrapped in `[AAProperty<AACapabilityState>]`
    public var states: [AAProperty<AACapability>]? {
        let bytesProps: [AAProperty<AACapabilityState>]? = properties.properties(forID: PropertyIdentifier.states)
    
        return bytesProps?.compactMap {
            $0.transformValue {
                AAAutoAPI.parseBinary($0 ?? [])
            }
        }
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0012
    }


    // MARK: Setters
    
    /// Bytes for *request states* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request states* in `AAHistorical`.
    /// 
    /// - parameters:
    ///   - capabilityID: The identifier of the Capability as `UInt16`
    ///   - startDate: Milliseconds since UNIX Epoch time as `Date`
    ///   - endDate: Milliseconds since UNIX Epoch time as `Date`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func requestStates(capabilityID: UInt16, startDate: Date?, endDate: Date?) -> Array<UInt8> {
        let props1 = AAProperty(identifier: PropertyIdentifier.capabilityID, value: capabilityID).bytes + AAProperty(identifier: PropertyIdentifier.startDate, value: startDate).bytes + AAProperty(identifier: PropertyIdentifier.endDate, value: endDate).bytes
    
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + props1
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "States", properties: states)
        ]
    }
}