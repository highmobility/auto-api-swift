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
//  AASpringRate.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// Spring rate
public struct AASpringRate: AABytesConvertable, Equatable {

    /// Axle
    public let axle: AAAxle

    /// The suspension spring rate in N/mm
    public let springRate: UInt8


    /// Initialise `AASpringRate` with parameters.
    ///
    /// - parameters:
    ///   - axle: Axle as `AAAxle`
    ///   - springRate: The suspension spring rate in N/mm as `UInt8`
    public init(axle: AAAxle, springRate: UInt8) {
        var bytes: Array<UInt8> = []
    
        bytes += axle.bytes
        bytes += springRate.bytes
    
        self.bytes = bytes
        self.axle = axle
        self.springRate = springRate
    }


    // MARK: AABytesConvertable
    
    /// `AASpringRate` bytes
    ///
    /// - returns: Bytes of `AASpringRate` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AASpringRate` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let axle = AAAxle(bytes: bytes[0..<1]),
            let springRate = UInt8(bytes: bytes[1..<2]) else {
                return nil
        }
    
        self.bytes = bytes
        self.axle = axle
        self.springRate = springRate
    }
}