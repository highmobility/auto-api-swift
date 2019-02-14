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
//  AAClimateWeekdayTime.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 21/09/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAClimateWeekdayTime {

    public var weekday: AAWeekday
    public var time: AATime


    // MARK: Init

    /// Initialise `AAWeekdayTime` value.
    ///
    /// - Parameters:
    ///   - weekday: Day of the week, or *automatic*.
    ///   - time: Time of the day.
    public init(weekday: AAWeekday, time: AATime) {
        self.weekday = weekday
        self.time = time
    }
}

extension AAClimateWeekdayTime: AABytesConvertable {

    public var bytes: [UInt8] {
        return weekday.bytes + time.bytes
    }


    public init?(bytes: [UInt8]) {
        guard bytes.count == 3 else {
            return nil
        }

        guard let weekday = AAWeekday(bytes: bytes[0..<1]),
            let time = AATime(bytes: bytes[1...2]) else {
                return nil
        }

        self.init(weekday: weekday, time: time)
    }
}
