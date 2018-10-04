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
//  AADate.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 04/10/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AADate {

    public let year: UInt8
    public let month: UInt8
    public let day: UInt8
    public let hour: UInt8
    public let minute: UInt8
    public let second: UInt8
    public let offset: Int16

    public var yearFull: Int {
        return 2000 + Int(year)
    }
}

extension AADate: AAItem {

    static var size: Int = 8


    init?(bytes: [UInt8]) {
        year = bytes[0]
        month = bytes[1]
        day = bytes[2]
        hour = bytes[3]
        minute = bytes[4]
        second = bytes[5]
        offset = Int16(bytes[6...7])
    }
}
