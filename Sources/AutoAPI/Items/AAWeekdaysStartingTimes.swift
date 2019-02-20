//
// AutoAPI
// Copyright (C) 2019 High-Mobility GmbH
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
//  AAWeekdaysTimes.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/11/2017.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public struct AAWeekdaysStartingTimes {

    public let monday: AATime
    public let tuesday: AATime
    public let wednesday: AATime
    public let thursday: AATime
    public let friday: AATime
    public let saturday: AATime
    public let sunday: AATime


    // MARK: Init

    public init(monday: AATime, tuesday: AATime, wednesday: AATime, thursday: AATime, friday: AATime, saturday: AATime, sunday: AATime) {
        self.monday = monday
        self.tuesday = tuesday
        self.wednesday = wednesday
        self.thursday = thursday
        self.friday = friday
        self.saturday = saturday
        self.sunday = sunday
    }
}

extension AAWeekdaysStartingTimes: AABytesConvertable {

    public var bytes: [UInt8] {
        let weekdaysBytes = monday.bytes + tuesday.bytes + wednesday.bytes + thursday.bytes + friday.bytes
        let weekendBytes = saturday.bytes + sunday.bytes

        return weekdaysBytes + weekendBytes
    }


    public init?(bytes: [UInt8]) {
        guard bytes.count == 14 else {
            return nil
        }

        guard let monday = AATime(bytes: bytes[0...1]),
            let tuesday = AATime(bytes: bytes[2...3]),
            let wednesday = AATime(bytes: bytes[4...5]),
            let thursday = AATime(bytes: bytes[6...7]),
            let friday = AATime(bytes: bytes[8...9]),
            let saturday = AATime(bytes: bytes[10...11]),
            let sunday = AATime(bytes: bytes[12...13]) else {
                return nil
        }

        self.init(monday: monday,
                  tuesday: tuesday,
                  wednesday: wednesday,
                  thursday: thursday,
                  friday: friday,
                  saturday: saturday,
                  sunday: sunday)
    }
}
