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
//  AAOffroad.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 06/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAOffroad: AAFullStandardCommand {

    public let routeIncline: Int16?
    public let wheelSuspension: AAPercentageInt?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        routeIncline = properties.value(for: 0x01)
        wheelSuspension = properties.value(for: 0x02)

        // Properties
        self.properties = properties
    }
}

extension AAOffroad: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0052
}

extension AAOffroad: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getOffroadState    = 0x00
        case offroadState       = 0x01
    }
}


// MARK: Commands

public extension AAOffroad {

    static var getOffroadState: [UInt8] {
        return commandPrefix(for: .getOffroadState)
    }
}
