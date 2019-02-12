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
//  UInt8+Extensions.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 24/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation
import HMUtilities


extension UInt8 {

    var bool: Bool {
        return self != 0x00
    }

    var int: Int {
        return Int(int8)
    }

    var int8: Int8 {
        return Int8(bitPattern: self)
    }

    var int16: Int16 {
        return Int16(bitPattern: uint16)
    }

    var uint16: UInt16 {
        return UInt16(self)
    }

    var uint32: UInt32 {
        return UInt32(self)
    }
}

extension UInt8: AABinaryInitable {

}

extension UInt8: AAPropertyConvertable {

    var propertyValue: [UInt8] {
        return [self]
    }
}
