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
//  AAVehicleLocation.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 04/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAVehicleLocation: AAFullStandardCommand {

    public let altitude: AAProperty<Double>?
    public let heading: AAProperty<Double>?
    public let coordinates: AAProperty<AACoordinates>?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        /* Level 8 */
        coordinates = properties.property(for: \AAVehicleLocation.coordinates)
        heading = properties.property(for: \AAVehicleLocation.heading)
        altitude = properties.property(for: \AAVehicleLocation.altitude)

        // Properties
        self.properties = properties
    }
}

extension AAVehicleLocation: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getLocation    = 0x00
        case location       = 0x01
    }
} 

extension AAVehicleLocation: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0030
}

extension AAVehicleLocation: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AAVehicleLocation, Type>) -> AAPropertyIdentifier? {
        switch keyPath {
            /* Level 8 */
        case \AAVehicleLocation.coordinates: return 0x04
        case \AAVehicleLocation.heading:    return 0x05
        case \AAVehicleLocation.altitude:   return 0x06

        default:
            return nil
        }
    }
}

public extension AAVehicleLocation {

    static var getLocation: [UInt8] {
        return commandPrefix(for: .getLocation)
    }
}
