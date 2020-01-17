//
//  The MIT License
//
//  Copyright (c) 2014- High-Mobility GmbH (https://high-mobility.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//
//  AAHVACWeekdayStartingTime.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
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