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
//  AAChargeCurrent.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/01/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAChargeCurrent {

    public let chargeCurrentDC: Float
    public let maximumValue: Float
    public let minimumValue: Float
}

extension AAChargeCurrent: AABytesConvertable {

    public var bytes: [UInt8] {
        return chargeCurrentDC.bytes + maximumValue.bytes + minimumValue.bytes
    }


    public init?(bytes: [UInt8]) {
        guard bytes.count == 12 else {
            return nil
        }

        guard let charge = Float(bytes: bytes[0...3]),
            let max = Float(bytes: bytes[4...7]),
            let min = Float(bytes: bytes[8...11]) else {
                return nil
        }

        chargeCurrentDC = charge
        maximumValue = max
        minimumValue = min
    }
}

extension AAChargeCurrent: Equatable {

}
