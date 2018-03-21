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
//  Time.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/11/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct DayTime {

    public let hour: UInt8
    public let minute: UInt8


    // MARK: Type Vars

    public static let zero: DayTime = DayTime(hour: 0, minute: 0)


    // MARK: Init

    public init(hour: UInt8, minute: UInt8) {
        self.hour = hour % 24
        self.minute = minute % 60
    }
}

extension DayTime: BinaryInitable {

    init?<C>(_ binary: C) where C : Collection, C.Element == UInt8 {
        guard binary.count >= 2 else {
            return nil
        }

        hour = binary.bytes[0]
        minute = binary.bytes[1]
    }
}
