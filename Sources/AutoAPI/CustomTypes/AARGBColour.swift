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
//  AARGBColour.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// RGB colour
public struct AARGBColour: AABytesConvertable, Equatable {

    /// The blue component of RGB
    public let blue: UInt8

    /// The green component of RGB
    public let green: UInt8

    /// The red component of RGB
    public let red: UInt8


    /// Initialise `AARGBColour` with parameters.
    ///
    /// - parameters:
    ///   - red: The red component of RGB as `UInt8`
    ///   - green: The green component of RGB as `UInt8`
    ///   - blue: The blue component of RGB as `UInt8`
    public init(red: UInt8, green: UInt8, blue: UInt8) {
        var bytes: Array<UInt8> = []
    
        bytes += red.bytes
        bytes += green.bytes
        bytes += blue.bytes
    
        self.bytes = bytes
        self.red = red
        self.green = green
        self.blue = blue
    }


    // MARK: AABytesConvertable
    
    /// `AARGBColour` bytes
    ///
    /// - returns: Bytes of `AARGBColour` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AARGBColour` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count == 3 else {
            return nil
        }
    
        guard let red = UInt8(bytes: bytes[0..<1]),
            let green = UInt8(bytes: bytes[1..<2]),
            let blue = UInt8(bytes: bytes[2..<3]) else {
                return nil
        }
    
        self.bytes = bytes
        self.red = red
        self.green = green
        self.blue = blue
    }
}