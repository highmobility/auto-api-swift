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
//  Date+Extensions.swift
//  AutoAPICLT
//
//  Created by Mikk Rätsep on 07/09/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


extension Date: AAItem {

    static var size: Int = 8


    init?(bytes: [UInt8]) {
        guard let date = AADate(bytes) else {
            return nil
        }

        guard let convertedDate = DateComponents(timeZone: TimeZone(secondsFromGMT: Int(date.offset * 60)), year: date.yearFull, month: date.month.int, day: date.day.int, hour: date.hour.int, minute: date.minute.int, second: date.second.int).date else {
            return nil
        }

        self = convertedDate
    }
}

extension Date: AAPropertyConvertable {

    var propertyValue: [UInt8] {
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second, .timeZone], from: self)

        guard let year = components.year,
            let month = components.month,
            let day = components.day,
            let hour = components.hour,
            let minute = components.minute,
            let second = components.second,
            let timeZone = components.timeZone else {
                return []
        }

        return [(year - 2000).uint8,
                month.uint8,
                day.uint8,
                hour.uint8,
                minute.uint8,
                second.uint8] +
            Int16(timeZone.secondsFromGMT() / 60).bytes
    }
}
