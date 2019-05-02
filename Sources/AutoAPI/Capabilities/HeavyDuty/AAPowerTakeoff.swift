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
//  AAPowerTakeoff.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/04/2018.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public class AAPowerTakeoff: AACapabilityClass, AACapability {

    public let activeState: AAProperty<AAActiveState>?
    public let engagedState: AAProperty<AAActiveState>?


    // MARK: AACapability

    public static var identifier: AACapabilityIdentifier = 0x0065


    required init(properties: AAProperties) {
        // Ordered by the ID
        activeState = properties.property(forIdentifier: 0x01)
        engagedState = properties.property(forIdentifier: 0x02)

        super.init(properties: properties)
    }
}

extension AAPowerTakeoff: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getState   = 0x00
        case state      = 0x01
        case activate   = 0x02
    }
}

public extension AAPowerTakeoff {

    static var getState: AACommand {
        return command(forMessageType: .getState)
    }


    static func activate(_ state: AAActiveState) -> AACommand {
        let properties = [state.property(forIdentifier: 0x01)]

        return command(forMessageType: .activate, properties: properties)
    }
}
