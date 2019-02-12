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

    public let arrivalTime: AAProperty<AATime>?
    public let coordinates: AAProperty<AACoordinates>?
    public let distanceTo: AAProperty<UInt16>?
    public let name: AAProperty<String>?
    public let poiSlotsFree: AAProperty<UInt8>?
    public let poiSlotsMax: AAProperty<UInt8>?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        name = properties.property(for: \AANaviDestination.name)
        poiSlotsFree = properties.property(for: \AANaviDestination.poiSlotsFree)
        poiSlotsMax = properties.property(for: \AANaviDestination.poiSlotsMax)
        arrivalTime = properties.property(for: \AANaviDestination.arrivalTime)
        distanceTo = properties.property(for: \AANaviDestination.distanceTo)
        /* Level 8 */
        coordinates = properties.property(for: \AANaviDestination.coordinates)

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
        case setDestination = 0x12
    }
}

extension AANaviDestination: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AANaviDestination, Type>) -> AAPropertyIdentifier? {
        switch keyPath {
        case \AANaviDestination.name:           return 0x02
        case \AANaviDestination.poiSlotsFree:   return 0x03
        case \AANaviDestination.poiSlotsMax:    return 0x04
        case \AANaviDestination.arrivalTime:    return 0x05
        case \AANaviDestination.distanceTo:     return 0x06
            /* Level 8 */
        case \AANaviDestination.coordinates: return 0x07

        default:
            return nil
        }
    }
}

public extension AANaviDestination {

    static var getDestination: [UInt8] {
        return commandPrefix(for: .getDestination)
    }


    static func setDestination(coordinate: AACoordinates, name: String?) -> [UInt8] {
        return commandPrefix(for: .setDestination) + [coordinate.propertyBytes(0x01),
                                                      name?.propertyBytes(0x02)].propertiesValuesCombined
    }
}
