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
//  AAAcceleration.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// Acceleration
public struct AAAcceleration: AABytesConvertable, Equatable {

    /// Direction
    public enum Direction: UInt8, AABytesConvertable {
        case longitudinal = 0x00
        case lateral = 0x01
        case frontLateral = 0x02
        case rearLateral = 0x03
    }


    /// Direction
    public let direction: Direction

    /// The accelaration in g-force
    public let gForce: Float


    /// Initialise `AAAcceleration` with parameters.
    ///
    /// - parameters:
    ///   - direction: Direction as `Direction`
    ///   - gForce: The accelaration in g-force as `Float`
    public init(direction: Direction, gForce: Float) {
        var bytes: Array<UInt8> = []
    
        bytes += direction.bytes
        bytes += gForce.bytes
    
        self.bytes = bytes
        self.direction = direction
        self.gForce = gForce
    }


    // MARK: AABytesConvertable
    
    /// `AAAcceleration` bytes
    ///
    /// - returns: Bytes of `AAAcceleration` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AAAcceleration` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count == 5 else {
            return nil
        }
    
        guard let direction = Direction(bytes: bytes[0..<1]),
            let gForce = Float(bytes: bytes[1..<5]) else {
                return nil
        }
    
        self.bytes = bytes
        self.direction = direction
        self.gForce = gForce
    }
}