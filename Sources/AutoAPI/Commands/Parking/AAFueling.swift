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

    public let gasFlapLockState: AAProperty<AALockState>?
    public let gasFlapPosition: AAProperty<AAPositionState>?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        /* Level 9 */
        gasFlapLockState = properties.property(forIdentifier: 0x02)
        gasFlapPosition = properties.property(forIdentifier: 0x03)

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

public extension AAFueling {

    static var getGasFlapState: [UInt8] {
        return commandPrefix(for: .getGasFlapState)
    }


    static func controlGasFlap(lockState: AALockState? = nil, position: AAPositionState? = nil) -> [UInt8] {
        return commandPrefix(for: .opencloseGasFlap)
        // TODO: + [lockState?.propertyBytes(0x02), position?.propertyBytes(0x03)].propertiesValuesCombined
    }
}
