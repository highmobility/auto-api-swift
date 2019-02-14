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
//  AAParkingBrake.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 07/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAParkingBrake: AAFullStandardCommand {

    public let state: AAProperty<AAActiveState>?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        state = properties.property(forIdentifier: 0x01)

        // Properties
        self.properties = properties
    }
}

extension AAParkingBrake: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0058
}

extension AAParkingBrake: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getBrakeState  = 0x00
        case brakeState     = 0x01
        case activate       = 0x12
    }
}

public extension AAParkingBrake {

    static var getBrakeState: [UInt8] {
        return commandPrefix(for: .getBrakeState)
    }


    static func activate(_ state: AAActiveState) -> [UInt8] {
        return commandPrefix(for: .activate)
            // TODO: + state.propertyBytes(0x01)
    }
}
