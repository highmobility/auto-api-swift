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
//  DashboardLights.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 24/04/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct DashboardLights: AAFullStandardCommand {

    public let lights: [DashboardLight]?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        lights = properties.flatMap(for: 0x01) { DashboardLight($0.value) }

        // Properties
        self.properties = properties
    }
}

extension DashboardLights: AAIdentifiable {

    public static var identifier: AACommandIdentifier = AACommandIdentifier(0x0061)
}

extension DashboardLights: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getDashboardLights = 0x00
        case dashboardLights    = 0x01
    }
}

public extension DashboardLights {

    static var getDashboardLights: [UInt8] {
        return commandPrefix(for: .getDashboardLights)
    }
}
