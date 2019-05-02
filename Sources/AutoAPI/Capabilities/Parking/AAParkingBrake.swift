//
// AutoAPI
// Copyright (C) 2019 High-Mobility GmbH
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
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public class AAParkingBrake: AACapabilityClass, AACapability {

    public let state: AAProperty<AAActiveState>?


    // MARK: AACapability

    public static var identifier: AACapabilityIdentifier = 0x0058


    required init(properties: AAProperties) {
        // Ordered by the ID
        state = properties.property(forIdentifier: 0x01)

        super.init(properties: properties)
    }
}

extension AAParkingBrake: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getBrakeState  = 0x00
        case brakeState     = 0x01
        case activate       = 0x12
    }
}

public extension AAParkingBrake {

    static var getBrakeState: AACommand {
        return command(forMessageType: .getBrakeState)
    }


    static func activate(_ state: AAActiveState) -> AACommand {
        let properties = [state.property(forIdentifier: 0x01)]

        return command(forMessageType: .activate, properties: properties)
    }
}
