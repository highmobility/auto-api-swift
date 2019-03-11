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
//  AADrivingMode.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/12/2017.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public enum AADrivingMode: UInt8 {

    /// Also know as *comfort*
    case regular    = 0x00

    case eco        = 0x01
    case sport      = 0x02
    case sportPlus  = 0x03

    case ecoPlus    = 0x04
}

extension AADrivingMode: AABytesConvertable {

}

public extension AADrivingMode {

    struct ActivationPeriod: AABytesConvertable {

        public let mode: AADrivingMode
        public let period: AAPercentage


        // MARK: AABytesConvertable

        public var bytes: [UInt8] {
            return mode.bytes + period.bytes
        }


        public init?(bytes: [UInt8]) {
            guard bytes.count == 9 else {
                return nil
            }

            guard let drivingMode = AADrivingMode(bytes: bytes[0..<1]),
                let percentage = AAPercentage(bytes: bytes[1..<9]) else {
                    return nil
            }

            mode = drivingMode
            period = percentage
        }
    }


    struct EnergyConsumption: AABytesConvertable {

        public let mode: AADrivingMode
        public let consumption: Float


        // MARK: AABytesConvertable

        public var bytes: [UInt8] {
            return mode.bytes + consumption.bytes
        }


        public init?(bytes: [UInt8]) {
            guard bytes.count == 5 else {
                return nil
            }

            guard let drivingMode = AADrivingMode(bytes: bytes[0..<1]),
                let value = Float(bytes: bytes[1...4]) else {
                    return nil
            }

            mode = drivingMode
            consumption = value
        }
    }
}
