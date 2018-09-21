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
//  AASpringRate.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AASpringRate {

    public let axle: AAAxle
    public let maximum: UInt8
    public let minimum: UInt8
    public let rate: UInt8
}

extension AASpringRate: AAItem {

    static var size: Int = 4


    init?(bytes: [UInt8]) {
        guard let axle = AAAxle(rawValue: bytes[0]) else {
            return nil
        }

        self.axle = axle
        self.maximum = bytes[2]
        self.minimum = bytes[3]
        self.rate = bytes[1]
    }
}


public struct AASpringRateValue {

    public let axle: AAAxle
    public let value: UInt8


    init(axle: AAAxle, value: UInt8) {
        self.axle = axle
        self.value = value
    }
}

extension AASpringRateValue: AAItem {

    static var size: Int = 2


    init?(bytes: [UInt8]) {
        guard let axle = AAAxle(rawValue: bytes[0]) else {
            return nil
        }

        self.axle = axle
        self.value = bytes[1]
    }
}

extension AASpringRateValue: PropertyConvertable {

    var propertyValue: [UInt8] {
        return axle.propertyValue + value.propertyValue
    }
}
