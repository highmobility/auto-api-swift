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
//  AATire.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 28/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AATire {

    public let position: AALocation
    public let pressure: Float
    public let temperature: Float
    public let wheelRPM: UInt16
}

extension AATire: AABytesConvertable {

    public var bytes: [UInt8] {
        return position.bytes + pressure.bytes + temperature.bytes + wheelRPM.bytes
    }


    public init?(bytes: [UInt8]) {
        guard bytes.count == 11 else {
            return nil
        }

        guard let position = AALocation(bytes: bytes[0..<1]),
            let pressure = Float(bytes: bytes[1...4]),
            let temperature = Float(bytes: bytes[5...8]),
            let wheelRPM = UInt16(bytes: bytes[9...10]) else {
                return nil
        }

        self.position = position
        self.pressure = pressure
        self.temperature = temperature
        self.wheelRPM = wheelRPM
    }
}
