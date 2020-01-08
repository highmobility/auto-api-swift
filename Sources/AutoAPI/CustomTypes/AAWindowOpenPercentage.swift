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
//  AAWindowOpenPercentage.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// Window open percentage
public struct AAWindowOpenPercentage: AABytesConvertable, Equatable {

    /// Location
    public let location: AAWindowLocation

    /// Open percentage
    public let openPercentage: AAPercentage


    /// Initialise `AAWindowOpenPercentage` with parameters.
    ///
    /// - parameters:
    ///   - location: Location as `AAWindowLocation`
    ///   - openPercentage: Open percentage as `AAPercentage`
    public init(location: AAWindowLocation, openPercentage: AAPercentage) {
        var bytes: Array<UInt8> = []
    
        bytes += location.bytes
        bytes += openPercentage.bytes
    
        self.bytes = bytes
        self.location = location
        self.openPercentage = openPercentage
    }


    // MARK: AABytesConvertable
    
    /// `AAWindowOpenPercentage` bytes
    ///
    /// - returns: Bytes of `AAWindowOpenPercentage` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AAWindowOpenPercentage` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count == 9 else {
            return nil
        }
    
        guard let location = AAWindowLocation(bytes: bytes[0..<1]),
            let openPercentage = AAPercentage(bytes: bytes[1..<9]) else {
                return nil
        }
    
        self.bytes = bytes
        self.location = location
        self.openPercentage = openPercentage
    }
}