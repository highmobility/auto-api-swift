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
//  AAHVACWeekdayStartingTime.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// HVAC weekday starting time
public struct AAHVACWeekdayStartingTime: AABytesConvertable, Equatable {

    /// Weekday
    public enum Weekday: UInt8, AABytesConvertable {
        case monday = 0x00
        case tuesday = 0x01
        case wednesday = 0x02
        case thursday = 0x03
        case friday = 0x04
        case saturday = 0x05
        case sunday = 0x06
        case automatic = 0x07
    }


    /// Time
    public let time: AATime

    /// Weekday
    public let weekday: Weekday


    /// Initialise `AAHVACWeekdayStartingTime` with parameters.
    ///
    /// - parameters:
    ///   - weekday: Weekday as `Weekday`
    ///   - time: Time as `AATime`
    public init(weekday: Weekday, time: AATime) {
        var bytes: Array<UInt8> = []
    
        bytes += weekday.bytes
        bytes += time.bytes
    
        self.bytes = bytes
        self.weekday = weekday
        self.time = time
    }


    // MARK: AABytesConvertable
    
    /// `AAHVACWeekdayStartingTime` bytes
    ///
    /// - returns: Bytes of `AAHVACWeekdayStartingTime` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AAHVACWeekdayStartingTime` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count == 3 else {
            return nil
        }
    
        guard let weekday = Weekday(bytes: bytes[0..<1]),
            let time = AATime(bytes: bytes[1..<3]) else {
                return nil
        }
    
        self.bytes = bytes
        self.weekday = weekday
        self.time = time
    }
}