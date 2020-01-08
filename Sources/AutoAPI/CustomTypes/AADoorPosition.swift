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
//  AADoorPosition.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// Door position
public struct AADoorPosition: AABytesConvertable, Equatable {

    /// Location
    public enum Location: UInt8, AABytesConvertable {
        case frontLeft = 0x00
        case frontRight = 0x01
        case rearRight = 0x02
        case rearLeft = 0x03
        case all = 0x05
    }


    /// Location
    public let location: Location

    /// Position
    public let position: AAPosition


    /// Initialise `AADoorPosition` with parameters.
    ///
    /// - parameters:
    ///   - location: Location as `Location`
    ///   - position: Position as `AAPosition`
    public init(location: Location, position: AAPosition) {
        var bytes: Array<UInt8> = []
    
        bytes += location.bytes
        bytes += position.bytes
    
        self.bytes = bytes
        self.location = location
        self.position = position
    }


    // MARK: AABytesConvertable
    
    /// `AADoorPosition` bytes
    ///
    /// - returns: Bytes of `AADoorPosition` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AADoorPosition` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let location = Location(bytes: bytes[0..<1]),
            let position = AAPosition(bytes: bytes[1..<2]) else {
                return nil
        }
    
        self.bytes = bytes
        self.location = location
        self.position = position
    }
}