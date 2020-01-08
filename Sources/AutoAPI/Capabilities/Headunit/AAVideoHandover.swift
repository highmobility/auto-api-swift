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
//  AAVideoHandover.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAVideoHandover: AACapability {

    /// Screen
    public enum Screen: UInt8, AABytesConvertable {
        case front = 0x00
        case rear = 0x01
    }


    /// Property Identifiers for `AAVideoHandover` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case url = 0x01
        case startingSecond = 0x02
        case screen = 0x03
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0043
    }


    // MARK: Setters
    
    /// Bytes for *video handover* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *video handover* in `AAVideoHandover`.
    /// 
    /// - parameters:
    ///   - url: URL string as `String`
    ///   - startingSecond: starting second as `UInt16`
    ///   - screen: screen as `Screen`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func videoHandover(url: String, startingSecond: UInt16?, screen: Screen?) -> Array<UInt8> {
        let props1 = AAProperty(identifier: PropertyIdentifier.url, value: url).bytes + AAProperty(identifier: PropertyIdentifier.startingSecond, value: startingSecond).bytes + AAProperty(identifier: PropertyIdentifier.screen, value: screen).bytes
    
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + props1
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
    
        ]
    }
}