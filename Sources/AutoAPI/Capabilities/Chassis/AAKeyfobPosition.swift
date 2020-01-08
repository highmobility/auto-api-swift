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
//  AAKeyfobPosition.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAKeyfobPosition: AACapability {

    /// Location
    public enum Location: UInt8, AABytesConvertable {
        case outOfRange = 0x00
        case outsideDriverSide = 0x01
        case outsideInFrontOfCar = 0x02
        case outsidePassengerSide = 0x03
        case outsideBehindCar = 0x04
        case insideCar = 0x05
    }


    /// Property Identifiers for `AAKeyfobPosition` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case location = 0x01
    }


    // MARK: Properties
    
    /// Location
    ///
    /// - returns: `Location` wrapped in `AAProperty<Location>`
    public var location: AAProperty<Location>? {
        properties.property(forID: PropertyIdentifier.location)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0048
    }


    // MARK: Getters
    
    /// Bytes for getting the `AAKeyfobPosition` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AAKeyfobPosition`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getKeyfobPosition() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Location", property: location)
        ]
    }
}