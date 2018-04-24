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
//  Offroad.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 06/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct Offroad: FullStandardCommand {

    public let routeIncline: Int16?
    public let wheelSuspension: UInt8?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        routeIncline = properties.value(for: 0x01)
        wheelSuspension = properties.value(for: 0x02)

        // Properties
        self.properties = properties
    }
}

extension Offroad: Identifiable {

    public static var identifier: Identifier = Identifier(0x0052)
}

extension Offroad: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getOffroadState    = 0x00
        case offroadState       = 0x01


        public static var all: [Offroad.MessageTypes] {
            return [self.getOffroadState,
                    self.offroadState]
        }
    }
}

public extension Offroad {

    static var getOffroadState: [UInt8] {
        return commandPrefix(for: .getOffroadState)
    }
}
