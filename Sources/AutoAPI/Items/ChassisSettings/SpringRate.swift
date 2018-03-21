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
//  SpringRate.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct SpringRate {

    public let axle: Axle
    public let maximum: Int8
    public let minimum: Int8
    public let rate: UInt8
}

extension SpringRate: Item {

    static var size: Int = 4


    init?(bytes: [UInt8]) {
        guard let axle = Axle(rawValue: bytes[0]) else {
            return nil
        }

        self.axle = axle
        self.maximum = bytes[2].int8
        self.minimum = bytes[3].int8
        self.rate = bytes[1]
    }
}
