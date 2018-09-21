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
//  Engine.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 28/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct Engine: AAFullStandardCommand {

    public let accessoriesPoweredState: AAActiveState?
    public let engineState: AAActiveState?
    public let ignitionState: AAActiveState?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        ignitionState = AAActiveState(rawValue: properties.first(for: 0x01)?.monoValue)
        accessoriesPoweredState = AAActiveState(rawValue: properties.first(for: 0x02)?.monoValue)
        engineState = AAActiveState(rawValue: properties.first(for: 0x03)?.monoValue)

        // Properties
        self.properties = properties
    }
}

extension Engine: AAIdentifiable {

    public static var identifier: AACommandIdentifier = AACommandIdentifier(0x0035)
}

extension Engine: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getIgnitionState   = 0x00
        case ignitionState      = 0x01
        case turnEngineOnOff    = 0x02
    }
}

public extension Engine {

    static var getIgnitionState: [UInt8] {
        return commandPrefix(for: .getIgnitionState)
    }

    static var setIgnitionState: (AAActiveState) -> [UInt8] {
        return {
            return commandPrefix(for: .turnEngineOnOff) + $0.propertyBytes(0x01)
        }
    }
}
