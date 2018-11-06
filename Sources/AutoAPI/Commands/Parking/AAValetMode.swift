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
//  AAValetMode.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAValetMode: AAFullStandardCommand {

    public let state: AAActiveState?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        state = properties.value(for: \AAValetMode.state)

        // Properties
        self.properties = properties
    }
}

extension AAValetMode: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0028
}

extension AAValetMode: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getState   = 0x00
        case state      = 0x01
        case activate   = 0x12
    }
}

extension AAValetMode: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AAValetMode, Type>) -> AAPropertyIdentifier {
        switch keyPath {
        case \AAValetMode.state: return 0x01

        default:
            return 0x00
        }
    }
}


// MARK: Commands

public extension AAValetMode {

    static var getState: [UInt8] {
        return commandPrefix(for: .getState)
    }


    static func activate(_ state: AAActiveState) -> [UInt8] {
        return commandPrefix(for: .activate) + state.propertyBytes(0x01)
    }
}

public extension AAValetMode {

    struct Legacy: AAMessageTypesGettable {

        public enum MessageTypes: UInt8, CaseIterable {

            case getValetMode                   = 0x00
            case valetMode                      = 0x01
            case activateDeactivateValetMode    = 0x02
        }


        /// Use `false` to *deactivate*.
        static var activateValetMode: (Bool) -> [UInt8] {
            return {
                return commandPrefix(for: AAValetMode.self, messageType: .activateDeactivateValetMode) + $0.propertyValue
            }
        }

        static var getValetMode: [UInt8] {
            return commandPrefix(for: AAValetMode.self, messageType: .getValetMode)
        }
    }
}