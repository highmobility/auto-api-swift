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
//  VehicleLocation.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 04/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct VehicleLocation: FullStandardCommand {

    public let altitude: Float?
    public let heading: Float?
    public let coordinate: Coordinate?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        coordinate = Coordinate(properties.first(for: 0x01)?.value ?? [])
        heading = properties.value(for: 0x02)
        altitude = properties.value(for: 0x03)

        // Properties
        self.properties = properties
    }
}

extension VehicleLocation: MessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getVehicleLocation = 0x00
        case vehicleLocation    = 0x01
    }
}

extension VehicleLocation: Identifiable {

    public static var identifier: Identifier = Identifier(0x0030)
}

public extension VehicleLocation {

    static var getVehicleLocation: [UInt8] {
        return commandPrefix(for: .getVehicleLocation)
    }



    // TODO: Just concepts atm
    static func getLocation(start: YearTime?, end: YearTime?) -> [UInt8] {
        let startBytes = start?.propertyBytes(0x00) ?? []
        let endBytes = end?.propertyBytes(0x00) ?? []

        return commandPrefix(for: .getVehicleLocation) + startBytes + endBytes
    }

    static func getLocation(period: (start: YearTime, end: YearTime)?) -> [UInt8] {
        let startBytes = period?.start.propertyBytes(0x00) ?? []
        let endBytes = period?.end.propertyBytes(0x00) ?? []

        return commandPrefix(for: .getVehicleLocation) + startBytes + endBytes
    }
}
