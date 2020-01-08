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
//  AAWakeUp.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAWakeUp: AACapability {

    /// Status
    public enum Status: UInt8, AABytesConvertable {
        case wakeUp = 0x00
        case sleep = 0x01
    }


    /// Property Identifiers for `AAWakeUp` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case status = 0x01
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0022
    }


    // MARK: Setters
    
    /// Bytes for *wake up* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *wake up* in `AAWakeUp`.
    /// 
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func wakeUp() -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.status, value: Status(bytes: [0x00])).bytes
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
    
        ]
    }
}