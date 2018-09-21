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
//  AAClimateProfile.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAClimateProfile: AAItem {

    public let activatedDays: AAActivatedDays
    public let weekdaysStartingTimes: AAWeekdaysStartingTimes


    // MARK: AAItem

    static var size: Int = 15


    // MARK: Init

    public init(activatedDays: AAActivatedDays, weekdaysStartingTimes: AAWeekdaysStartingTimes) {
        self.activatedDays = activatedDays
        self.weekdaysStartingTimes = weekdaysStartingTimes
    }
}

extension AAClimateProfile: BinaryInitable {

    init?(bytes: [UInt8]) {
        guard let startingTimes = AAWeekdaysStartingTimes(bytes.dropFirstBytes(1)) else {
            return nil
        }

        activatedDays = AAActivatedDays(rawValue: bytes[0])
        weekdaysStartingTimes = startingTimes
    }
}

extension AAClimateProfile: PropertyConvertable {

    var propertyValue: [UInt8] {
        return [activatedDays.rawValue] + weekdaysStartingTimes.propertyValue
    }
}

extension AAClimateProfile: AAPropertiesMultiConvertable {

    var propertiesValues: [[UInt8]?] {
        return [activatedDays.propertyBytes(0x01),
                weekdaysStartingTimes.propertyBytes(0x02)]
    }
}
