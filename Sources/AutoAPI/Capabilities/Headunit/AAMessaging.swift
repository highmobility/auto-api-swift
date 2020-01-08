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
//  AAMessaging.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAMessaging: AACapability {

    /// Property Identifiers for `AAMessaging` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case text = 0x01
        case handle = 0x02
    }


    // MARK: Properties
    
    /// The optional handle of message
    ///
    /// - returns: `String` wrapped in `AAProperty<String>`
    public var handle: AAProperty<String>? {
        properties.property(forID: PropertyIdentifier.handle)
    }
    
    /// The text
    ///
    /// - returns: `String` wrapped in `AAProperty<String>`
    public var text: AAProperty<String>? {
        properties.property(forID: PropertyIdentifier.text)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0037
    }


    // MARK: Setters
    
    /// Bytes for *message received* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *message received* in `AAMessaging`.
    /// 
    /// - parameters:
    ///   - text: The text as `String`
    ///   - handle: The optional handle of message as `String`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func messageReceived(text: String, handle: String?) -> Array<UInt8> {
        let props1 = AAProperty(identifier: PropertyIdentifier.text, value: text).bytes + AAProperty(identifier: PropertyIdentifier.handle, value: handle).bytes
    
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + props1
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Handle", property: handle),
            .node(label: "Text", property: text)
        ]
    }
}