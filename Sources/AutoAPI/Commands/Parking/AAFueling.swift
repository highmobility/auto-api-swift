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
//  AAFueling.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAFueling: AAFullStandardCommand {

    public let gasFlapLockState: AALockState?
    public let gasFlapPosition: AAPositionState?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        /* Level 9 */
        gasFlapLockState = AALockState(properties: properties, keyPath: \AAFueling.gasFlapLockState)
        gasFlapPosition = properties.value(for: \AAFueling.gasFlapPosition)

        // Properties
        self.properties = properties
    }
}

extension AAFueling: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0040
}

extension AAFueling: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getGasFlapState    = 0x00
        case gasFlapState       = 0x01
        case opencloseGasFlap   = 0x12
    }
}

extension AAFueling: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AAFueling, Type>) -> AAPropertyIdentifier {
        switch keyPath {
            /* Level 9 */
        case \AAFueling.gasFlapLockState:   return 0x02
        case \AAFueling.gasFlapPosition:    return 0x03

        default:
            return 0x00
        }
    }
}

public extension AAFueling {

    static var getGasFlapState: [UInt8] {
        return commandPrefix(for: .getGasFlapState)
    }


    static func openCloseGasFlap(_ state: AAOpenClose) -> [UInt8] {
        return commandPrefix(for: .opencloseGasFlap) + state.propertyBytes(0x01)
    }
}
