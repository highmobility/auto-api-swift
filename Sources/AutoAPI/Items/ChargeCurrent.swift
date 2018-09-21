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
//  ChargeCurrent.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/01/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct ChargeCurrent: AAItem {

    public let chargeCurrentDC: Float
    public let maximumValue: Float
    public let minimumValue: Float


    // MARK: AAItem

    static var size: Int = 12
}

extension ChargeCurrent: BinaryInitable {

    init?(bytes: [UInt8]) {
        chargeCurrentDC = Float(bytes.prefix(upTo: 4))
        maximumValue = Float(bytes[4..<8])
        minimumValue = Float(bytes.suffix(from: 8))
    }
}

extension ChargeCurrent: Equatable {

    public static func ==(lhs: ChargeCurrent, rhs: ChargeCurrent) -> Bool {
        return (lhs.chargeCurrentDC == rhs.chargeCurrentDC) &&
            (lhs.maximumValue == rhs.maximumValue) &&
            (lhs.minimumValue == rhs.minimumValue)
    }
}
