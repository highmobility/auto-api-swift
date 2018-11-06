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
//  AAStartStop.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 24/04/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAStartStop: AAFullStandardCommand {

    public let activeState: AAActiveState?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        activeState = properties.value(for: \AAStartStop.activeState)

        // Properties
        self.properties = properties
    }
}

extension AAStartStop: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0063
}

extension AAStartStop: AALegacyGettable {

    public struct Legacy: AALegacyType {

        public enum MessageTypes: UInt8, CaseIterable {

            case getState   = 0x00
            case state      = 0x01
            case setState   = 0x02
        }


        public init(properties: AAProperties) {

        }
    }
}

extension AAStartStop: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getState   = 0x00
        case state      = 0x01
        case activate   = 0x12
    }
}

extension AAStartStop: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AAStartStop, Type>) -> AAPropertyIdentifier {
        switch keyPath {
        case \AAStartStop.activeState: return 0x01

        default:
            return 0x00
        }
    }
}


// MARK: Commands

public extension AAStartStop {

    static var getState: [UInt8] {
        return commandPrefix(for: .getState)
    }


    static func activate(_ state: AAActiveState) -> [UInt8] {
        return commandPrefix(for: .activate) + state.propertyBytes(0x01)
    }
}

public extension AAStartStop.Legacy {

    static var getState: [UInt8] {
        return commandPrefix(for: AAStartStop.self, messageType: .getState)
    }

    static var setState: (AAActiveState) -> [UInt8] {
        return {
            return commandPrefix(for: AAStartStop.self, messageType: .setState) + $0.propertyBytes(0x01)
        }
    }
}
