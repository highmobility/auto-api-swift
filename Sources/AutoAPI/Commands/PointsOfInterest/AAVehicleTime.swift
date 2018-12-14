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
//  AAVehicleTime.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAVehicleTime: AAFullStandardCommand {

    public let time: AATime?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        time = AATime(bytes: properties.first(for: \AAVehicleTime.time)?.value)

        // Properties
        self.properties = properties
    }
}

extension AAVehicleTime: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getTime    = 0x00
        case time       = 0x01
    }
}

extension AAVehicleTime: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0050
}

extension AAVehicleTime: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AAVehicleTime, Type>) -> AAPropertyIdentifier {
        switch keyPath {
        case \AAVehicleTime.time: return 0x01

        default:
            return 0x00
        }
    }
}

public extension AAVehicleTime {

    static var getTime: [UInt8] {
        return commandPrefix(for: .getTime)
    }
}
