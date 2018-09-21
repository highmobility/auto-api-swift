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
//  NaviDestination.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct NaviDestination: AAFullStandardCommand {

    public let arrivalTime: AADayTime?
    public let coordinate: Coordinate?
    public let distanceTo: UInt16?
    public let name: String?
    public let poiSlotsFree: UInt8?
    public let poiSlotsMax: UInt8?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        coordinate = Coordinate(properties.first(for: 0x01)?.value ?? [])
        name = properties.value(for: 0x02)
        poiSlotsFree = properties.value(for: 0x03)
        poiSlotsMax = properties.value(for: 0x04)
        arrivalTime = AADayTime(properties.first(for: 0x05)?.value ?? [])
        distanceTo = properties.value(for: 0x06)

        // Properties
        self.properties = properties
    }
}

extension NaviDestination: AAIdentifiable {

    public static var identifier: AACommandIdentifier = AACommandIdentifier(0x0031)
}

extension NaviDestination: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getDestination = 0x00
        case destination    = 0x01
        case setDestination = 0x02
    }
}

public extension NaviDestination {

    struct Destination {
        public let coordinate: Coordinate
        public let name: String?

        public init(coordinate: Coordinate, name: String?) {
            self.coordinate = coordinate
            self.name = name
        }
    }


    static var getDestination: [UInt8] {
        return commandPrefix(for: .getDestination)
    }

    static var setDestination: (Destination) -> [UInt8] {
        return {
            let coordinateBytes = $0.coordinate.propertyBytes(0x01)
            let nameBytes: [UInt8] = $0.name?.propertyBytes(0x02) ?? []

            return commandPrefix(for: .setDestination) + coordinateBytes + nameBytes
        }
    }
}
