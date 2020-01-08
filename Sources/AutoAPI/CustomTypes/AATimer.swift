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
//  AATimer.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// Timer
public struct AATimer: AABytesConvertable, Equatable {

    /// Timer type
    public enum TimerType: UInt8, AABytesConvertable {
        case preferredStartTime = 0x00
        case preferredEndTime = 0x01
        case departureDate = 0x02
    }


    /// Milliseconds since UNIX Epoch time
    public let date: Date

    /// Timer type
    public let timerType: TimerType


    /// Initialise `AATimer` with parameters.
    ///
    /// - parameters:
    ///   - timerType: Timer type as `TimerType`
    ///   - date: Milliseconds since UNIX Epoch time as `Date`
    public init(timerType: TimerType, date: Date) {
        var bytes: Array<UInt8> = []
    
        bytes += timerType.bytes
        bytes += date.bytes
    
        self.bytes = bytes
        self.timerType = timerType
        self.date = date
    }


    // MARK: AABytesConvertable
    
    /// `AATimer` bytes
    ///
    /// - returns: Bytes of `AATimer` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AATimer` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count == 9 else {
            return nil
        }
    
        guard let timerType = TimerType(bytes: bytes[0..<1]),
            let date = Date(bytes: bytes[1..<9]) else {
                return nil
        }
    
        self.bytes = bytes
        self.timerType = timerType
        self.date = date
    }
}