//
// AutoAPITests
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
//  AAPowerTakeoff.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/04/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAPowerTakeoff: AAFullStandardCommand {

    public let activeState: AAActiveState?
    public let engagedState: AAActiveState?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        activeState = properties.value(for: \AAPowerTakeoff.activeState)
        engagedState = properties.value(for: \AAPowerTakeoff.engagedState)

        // Properties
        self.properties = properties
    }
}

extension AAPowerTakeoff: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0065
}

extension AAPowerTakeoff: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getState   = 0x00
        case state      = 0x01
        case activate   = 0x02
    }
}

extension AAPowerTakeoff: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AAPowerTakeoff, Type>) -> AAPropertyIdentifier {
        switch keyPath {
        case \AAPowerTakeoff.activeState:   return 0x01
        case \AAPowerTakeoff.engagedState:  return 0x02

        default:
            return 0x00
        }
    }
}


// MARK: Commands

public extension AAPowerTakeoff {

    static var getState: [UInt8] {
        return commandPrefix(for: .getState)
    }


    static func activate(_ state: AAActiveState) -> [UInt8] {
        return commandPrefix(for: .activate) + state.propertyBytes(0x01)
    }
}
