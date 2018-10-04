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
//  AANaviDestination.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AANaviDestination: AAFullStandardCommand {

    public let arrivalTime: AATime?
    public let coordinate: AACoordinate?
    public let distanceTo: UInt16?
    public let name: String?
    public let poiSlotsFree: UInt8?
    public let poiSlotsMax: UInt8?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        coordinate = AACoordinate(properties.first(for: 0x01)?.value ?? [])
        name = properties.value(for: 0x02)
        poiSlotsFree = properties.value(for: 0x03)
        poiSlotsMax = properties.value(for: 0x04)
        arrivalTime = AATime(properties.first(for: 0x05)?.value ?? [])
        distanceTo = properties.value(for: 0x06)

        // Properties
        self.properties = properties
    }
}

extension AANaviDestination: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0031
}

extension AANaviDestination: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getDestination = 0x00
        case destination    = 0x01
        case setDestination = 0x02
    }
}


// MARK: Commands

public extension AANaviDestination {

    static var getDestination: [UInt8] {
        return commandPrefix(for: .getDestination)
    }


    static func setDestination(coordinate: AACoordinate, name: String?) -> [UInt8] {
        return commandPrefix(for: .setDestination) + [coordinate.propertyBytes(0x01),
                                                      name?.propertyBytes(0x02)].propertiesValuesCombined
    }
}

public extension AANaviDestination {

    struct Legacy {

        typealias MessageTypes = AANaviDestination.MessageTypes

        struct Destination {
            public let coordinate: AACoordinate
            public let name: String?

            public init(coordinate: AACoordinate, name: String?) {
                self.coordinate = coordinate
                self.name = name
            }
        }


        static var getDestination: [UInt8] {
            return commandPrefix(for: AANaviDestination.self, messageType: .getDestination)
        }

        static var setDestination: (Destination) -> [UInt8] {
            return {
                let coordinateBytes = $0.coordinate.propertyBytes(0x01)
                let nameBytes: [UInt8] = $0.name?.propertyBytes(0x02) ?? []

                return commandPrefix(for: AANaviDestination.self, messageType: .setDestination) + coordinateBytes + nameBytes
            }
        }
    }
}
