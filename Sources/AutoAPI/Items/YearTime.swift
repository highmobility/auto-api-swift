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
//  YearTime.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 05/12/2017.
//

import Foundation


public struct YearTime: Item, Equatable {

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
