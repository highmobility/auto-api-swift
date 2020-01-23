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
//  ClimateProfile.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/11/2017.
//

import Foundation


public struct ClimateProfile: Item {

    public let activatedDays: ActivatedDays
    public let weekdaysStartingTimes: WeekdaysTimes


    // MARK: Item

    static var size: Int = 15


    // MARK: Init

    public init(activatedDays: ActivatedDays, weekdaysStartingTimes: WeekdaysTimes) {
        self.activatedDays = activatedDays
        self.weekdaysStartingTimes = weekdaysStartingTimes
    }
}

extension ClimateProfile: BinaryInitable {

    init?(bytes: [UInt8]) {
        guard let startingTimes = WeekdaysTimes(bytes.dropFirstBytes(1)) else {
            return nil
        }

        activatedDays = ActivatedDays(rawValue: bytes[0])
        weekdaysStartingTimes = startingTimes
    }
}

extension ClimateProfile: PropertyConvertable {

    var propertyValue: [UInt8] {
        return [activatedDays.rawValue] + weekdaysStartingTimes.bytes
    }
}
