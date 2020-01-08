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
//  AAZone.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// Zone
public struct AAZone: AABytesConvertable, Equatable {

    /// Horizontal component of the matrix
    public let horizontal: UInt8

    /// Vertical component of the matrix
    public let vertical: UInt8


    /// Initialise `AAZone` with parameters.
    ///
    /// - parameters:
    ///   - horizontal: Horizontal component of the matrix as `UInt8`
    ///   - vertical: Vertical component of the matrix as `UInt8`
    public init(horizontal: UInt8, vertical: UInt8) {
        var bytes: Array<UInt8> = []
    
        bytes += horizontal.bytes
        bytes += vertical.bytes
    
        self.bytes = bytes
        self.horizontal = horizontal
        self.vertical = vertical
    }


    // MARK: AABytesConvertable
    
    /// `AAZone` bytes
    ///
    /// - returns: Bytes of `AAZone` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AAZone` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let horizontal = UInt8(bytes: bytes[0..<1]),
            let vertical = UInt8(bytes: bytes[1..<2]) else {
                return nil
        }
    
        self.bytes = bytes
        self.horizontal = horizontal
        self.vertical = vertical
    }
}