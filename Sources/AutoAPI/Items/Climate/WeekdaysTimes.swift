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
//  WeekdaysTimes.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/11/2017.
//

import Foundation


public struct WeekdaysTimes {

    public let monday: DayTime
    public let tuesday: DayTime
    public let wednesday: DayTime
    public let thursday: DayTime
    public let friday: DayTime
    public let saturday: DayTime
    public let sunday: DayTime

    var bytes: [UInt8] {
        return [monday.hour, monday.minute,
                tuesday.hour, tuesday.minute,
                wednesday.hour, wednesday.minute,
                thursday.hour, thursday.minute,
                friday.hour, friday.minute,
                saturday.hour, saturday.minute,
                sunday.hour, sunday.minute]
    }


    // MARK: Init

    public init(monday: DayTime, tuesday: DayTime, wednesday: DayTime, thursday: DayTime, friday: DayTime, saturday: DayTime, sunday: DayTime) {
        self.monday = monday
        self.tuesday = tuesday
        self.wednesday = wednesday
        self.thursday = thursday
        self.friday = friday
        self.saturday = saturday
        self.sunday = sunday
    }
}

extension WeekdaysTimes: BinaryInitable {

    init?<C>(_ binary: C) where C : Collection, C.Element == UInt8 {
        guard binary.count == 14 else {
            return nil
        }

        let bytes = binary.bytes

        guard let monday = DayTime(bytes),
            let tuesday = DayTime(bytes.suffix(from: 2)),
            let wednesday = DayTime(bytes.suffix(from: 4)),
            let thursday = DayTime(bytes.suffix(from: 6)),
            let friday = DayTime(bytes.suffix(from: 8)),
            let saturday = DayTime(bytes.suffix(from: 10)),
            let sunday = DayTime(bytes.suffix(from: 12)) else {
                return nil
        }

        self.monday = monday
        self.tuesday = tuesday
        self.wednesday = wednesday
        self.thursday = thursday
        self.friday = friday
        self.saturday = saturday
        self.sunday = sunday
    }
}
