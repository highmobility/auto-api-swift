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

    public let gasFlapState: AAGasFlapState?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        gasFlapState = AAGasFlapState(properties: properties, keyPath: \AAFueling.gasFlapState)

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
        case \AAFueling.gasFlapState: return 0x01

        default:
            return 0x00
        }
    }
}


// MARK: Commands

public extension AAFueling {

    static var getGasFlapState: [UInt8] {
        return commandPrefix(for: .getGasFlapState)
    }


    static func openCloseGasFlap(_ state: AAOpenClose) -> [UInt8] {
        return commandPrefix(for: .opencloseGasFlap) + state.propertyBytes(0x01)
    }
}

public extension AAFueling {

    struct Legacy: AAMessageTypesGettable {

        public enum MessageTypes: UInt8, CaseIterable {

            case getGasFlapState    = 0x00
            case gasFlapState       = 0x01
            case openGasFlap        = 0x02
        }


        static var getGasFlapState: [UInt8] {
            return commandPrefix(for: AAFueling.self, messageType: .getGasFlapState)
        }

        static var openGasFlap: [UInt8] {
            return commandPrefix(for: AAFueling.self, messageType: .openGasFlap)
        }
    }
}
