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
//  AATime.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// Time
public struct AATime: AABytesConvertable, Equatable {

    /// Value between 0 and 23
    public let hour: UInt8

    /// Value between 0 and 59
    public let minute: UInt8


    /// Initialise `AATime` with parameters.
    ///
    /// - parameters:
    ///   - hour: Value between 0 and 23 as `UInt8`
    ///   - minute: Value between 0 and 59 as `UInt8`
    public init(hour: UInt8, minute: UInt8) {
        var bytes: Array<UInt8> = []
    
        bytes += hour.bytes
        bytes += minute.bytes
    
        self.bytes = bytes
        self.hour = hour
        self.minute = minute
    }


    // MARK: AABytesConvertable
    
    /// `AATime` bytes
    ///
    /// - returns: Bytes of `AATime` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AATime` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let hour = UInt8(bytes: bytes[0..<1]),
            let minute = UInt8(bytes: bytes[1..<2]) else {
                return nil
        }
    
        self.bytes = bytes
        self.hour = hour
        self.minute = minute
    }
}