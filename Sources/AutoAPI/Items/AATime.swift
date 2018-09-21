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
//  AATime.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AATime {

    public var hour: UInt8
    public var minute: UInt8

    var isNil: Bool {
        return (hour == 0xFF) || (minute == 0xFF)
    }


    // MARK: Init

    public init(hour: UInt8, minute: UInt8) {
        self.hour = hour % 24
        self.minute = minute % 60
    }
}

extension AATime: AAItem {

    static var size: Int = 2


    init?(bytes: [UInt8]) {
        hour = bytes[0]
        minute = bytes[1]
    }
}

extension AATime: PropertyConvertable {

    var propertyValue: [UInt8] {
        return [hour, minute]
    }
}
