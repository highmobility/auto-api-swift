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
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct NaviDestination: FullStandardCommand {

    public let coordinate: Coordinate?
    public let name: String?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        coordinate = Coordinate(properties.first(for: 0x01)?.value ?? [])
        name = properties.value(for: 0x02)

        // Properties
        self.properties = properties
    }
}

extension NaviDestination: Identifiable {

    public static var identifier: Identifier = Identifier(0x0031)
}

extension NaviDestination: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getNaviDestination = 0x00
        case naviDestination    = 0x01
        case setNaviDestination = 0x02


        public static var all: [NaviDestination.MessageTypes] {
            return [self.getNaviDestination,
                    self.naviDestination,
                    self.setNaviDestination]
        }
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


    static var getNaviDestination: [UInt8] {
        return commandPrefix(for: .getNaviDestination)
    }

    static var setDestination: (Destination) -> [UInt8] {
        return {
            let coordinateBytes = $0.coordinate.propertyBytes(0x01)
            let nameBytes: [UInt8] = $0.name?.propertyBytes(0x02) ?? []

            return commandPrefix(for: .setNaviDestination) + coordinateBytes + nameBytes
        }
    }
}
