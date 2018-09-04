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
//  ParkingBrake.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 07/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct ParkingBrake: FullStandardCommand {

    public let isActive: Bool?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        isActive = properties.value(for: 0x01)

        // Properties
        self.properties = properties
    }
}

extension ParkingBrake: Identifiable {

    public static var identifier: Identifier = Identifier(0x0058)
}

extension ParkingBrake: MessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getParkingBrakeState   = 0x00
        case parkingBrakeState      = 0x01
        case setParkingBrake        = 0x02
    }
}

public extension ParkingBrake {

    /// Use `false` to *inactivate*.
    static var activate: (Bool) -> [UInt8] {
        return {
            return commandPrefix(for: .setParkingBrake) + [$0 ? 0x01 : 0x00]
        }
    }

    static var getParkingBrakeState: [UInt8] {
        return commandPrefix(for: .getParkingBrakeState)
    }
}
