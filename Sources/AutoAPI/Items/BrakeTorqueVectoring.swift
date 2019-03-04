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
//  BrakeTorqueVectoring.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 14/12/2017.
//  Copyright © 2019 High Mobility. All rights reserved.
//

import Foundation


public struct BrakeTorqueVectoring {

    public let axle: Axle
    public let isActive: Bool
}

extension BrakeTorqueVectoring: Item {

    static var size: Int = 2


    init?(bytes: [UInt8]) {
        guard let axle = Axle(rawValue: bytes[0]) else {
            return nil
        }

        self.axle = axle
        self.isActive = bytes[1] == 0x01
    }
}
