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
//  AADepartureTime.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// Departure time
public struct AADepartureTime: AABytesConvertable, Equatable {

    /// State
    public let state: AAActiveState

    /// Time
    public let time: AATime


    /// Initialise `AADepartureTime` with parameters.
    ///
    /// - parameters:
    ///   - state: State as `AAActiveState`
    ///   - time: Time as `AATime`
    public init(state: AAActiveState, time: AATime) {
        var bytes: Array<UInt8> = []
    
        bytes += state.bytes
        bytes += time.bytes
    
        self.bytes = bytes
        self.state = state
        self.time = time
    }


    // MARK: AABytesConvertable
    
    /// `AADepartureTime` bytes
    ///
    /// - returns: Bytes of `AADepartureTime` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AADepartureTime` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count == 3 else {
            return nil
        }
    
        guard let state = AAActiveState(bytes: bytes[0..<1]),
            let time = AATime(bytes: bytes[1..<3]) else {
                return nil
        }
    
        self.bytes = bytes
        self.state = state
        self.time = time
    }
}