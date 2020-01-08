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
//  AALock.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// Lock
public struct AALock: AABytesConvertable, Equatable {

    /// Door location
    public let location: AALocation

    /// Lock state for the door
    public let lockState: AALockState


    /// Initialise `AALock` with parameters.
    ///
    /// - parameters:
    ///   - location: Door location as `AALocation`
    ///   - lockState: Lock state for the door as `AALockState`
    public init(location: AALocation, lockState: AALockState) {
        var bytes: Array<UInt8> = []
    
        bytes += location.bytes
        bytes += lockState.bytes
    
        self.bytes = bytes
        self.location = location
        self.lockState = lockState
    }


    // MARK: AABytesConvertable
    
    /// `AALock` bytes
    ///
    /// - returns: Bytes of `AALock` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AALock` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let location = AALocation(bytes: bytes[0..<1]),
            let lockState = AALockState(bytes: bytes[1..<2]) else {
                return nil
        }
    
        self.bytes = bytes
        self.location = location
        self.lockState = lockState
    }
}