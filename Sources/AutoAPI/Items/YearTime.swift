//
// AutoAPI
// Copyright (C) 2017 High-Mobility GmbH
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
//  YearTime.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 05/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct YearTime: Item {

    public var year: UInt16
    public var month: UInt8
    public var day: UInt8
    public var hour: UInt8
    public var minute: UInt8
    public var second: UInt8

    public var offset: Int16


    // MARK: Type Vars

    public static let zero: YearTime = YearTime(year: 0, month: 0, day: 0, hour: 0, minute: 0, second: 0, offset: 0)


    // MARK: Item

    static var size: Int = 8


    // MARK: Init

    public init(year: UInt16, month: UInt8, day: UInt8, hour: UInt8, minute: UInt8, second: UInt8, offset: Int16) {
        self.year = year
        self.month = month
        self.day = day
        self.hour = hour
        self.minute = minute
        self.second = second
        self.offset = offset
    }
}

extension YearTime: BinaryInitable {

    init?(bytes: [UInt8]) {
        year = UInt16(bytes[0]) + 2000
        month = bytes[1]
        day = bytes[2]
        hour = bytes[3]
        minute = bytes[4]
        second = bytes[5]
        offset = Int16(bytes.suffix(2))
    }
}

extension YearTime: PropertyConvertable {

    var propertyValue: [UInt8] {
        let yearByte = UInt8((year - 2000) & 0x00FF)

        return [yearByte, month, day, hour, minute, second] + offset.bytes
    }
}
