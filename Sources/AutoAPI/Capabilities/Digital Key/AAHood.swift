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
//  AAHood.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAHood: AACapability {

    /// Position
    public enum Position: UInt8, AABytesConvertable {
        case closed = 0x00
        case open = 0x01
        case intermediate = 0x02
    }


    /// Property Identifiers for `AAHood` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case position = 0x01
    }


    // MARK: Properties
    
    /// Position
    ///
    /// - returns: `Position` wrapped in `AAProperty<Position>`
    public var position: AAProperty<Position>? {
        properties.property(forID: PropertyIdentifier.position)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0067
    }


    // MARK: Getters
    
    /// Bytes for getting the `AAHood` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AAHood`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getHoodState() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Position", property: position)
        ]
    }
}