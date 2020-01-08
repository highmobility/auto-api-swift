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
//  AACoordinates.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// Coordinates
public struct AACoordinates: AABytesConvertable, Equatable {

    /// Latitude
    public let latitude: Double

    /// Longitude
    public let longitude: Double


    /// Initialise `AACoordinates` with parameters.
    ///
    /// - parameters:
    ///   - latitude: Latitude as `Double`
    ///   - longitude: Longitude as `Double`
    public init(latitude: Double, longitude: Double) {
        var bytes: Array<UInt8> = []
    
        bytes += latitude.bytes
        bytes += longitude.bytes
    
        self.bytes = bytes
        self.latitude = latitude
        self.longitude = longitude
    }


    // MARK: AABytesConvertable
    
    /// `AACoordinates` bytes
    ///
    /// - returns: Bytes of `AACoordinates` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AACoordinates` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count == 16 else {
            return nil
        }
    
        guard let latitude = Double(bytes: bytes[0..<8]),
            let longitude = Double(bytes: bytes[8..<16]) else {
                return nil
        }
    
        self.bytes = bytes
        self.latitude = latitude
        self.longitude = longitude
    }
}