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
//  AAWheelRPM.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// Wheel RPM
public struct AAWheelRPM: AABytesConvertable, Equatable {

    /// The RPM measured at this wheel
    public let RPM: UInt16

    /// Wheel location
    public let location: AALocation


    /// Initialise `AAWheelRPM` with parameters.
    ///
    /// - parameters:
    ///   - location: Wheel location as `AALocation`
    ///   - RPM: The RPM measured at this wheel as `UInt16`
    public init(location: AALocation, RPM: UInt16) {
        var bytes: Array<UInt8> = []
    
        bytes += location.bytes
        bytes += RPM.bytes
    
        self.bytes = bytes
        self.location = location
        self.RPM = RPM
    }


    // MARK: AABytesConvertable
    
    /// `AAWheelRPM` bytes
    ///
    /// - returns: Bytes of `AAWheelRPM` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AAWheelRPM` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count == 3 else {
            return nil
        }
    
        guard let location = AALocation(bytes: bytes[0..<1]),
            let RPM = UInt16(bytes: bytes[1..<3]) else {
                return nil
        }
    
        self.bytes = bytes
        self.location = location
        self.RPM = RPM
    }
}