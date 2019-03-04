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
//  ClimateProfile.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/11/2017.
//  Copyright © 2019 High Mobility. All rights reserved.
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
