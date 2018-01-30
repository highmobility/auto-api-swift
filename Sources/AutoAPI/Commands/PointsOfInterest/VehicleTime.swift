//
// AutoAPI
// Copyright (C) 2017 High-Mobility GmbH
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
//  VehicleTime.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct VehicleTime: FullStandardCommand {

    public let time: YearTime?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        time = properties.value(for: 0x01)

        // Properties
        self.properties = properties
    }
}

extension VehicleTime: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getVehicleTime = 0x00
        case vehicleTime    = 0x01


        public static var all: [VehicleTime.MessageTypes] {
            return [self.getVehicleTime,
                    self.vehicleTime]
        }
    }
}

extension VehicleTime: Identifiable {

    public static var identifier: Identifier = Identifier(0x0050)
}

public extension VehicleTime {

    static var getVehicleTime: [UInt8] {
        return commandPrefix(for: .getVehicleTime)
    }
}
