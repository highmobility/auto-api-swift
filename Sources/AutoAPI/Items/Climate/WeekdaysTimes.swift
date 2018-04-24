//
// AutoAPI
// Copyright (C) 2018 High-Mobility GmbH
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
//  WeekdaysTimes.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
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
