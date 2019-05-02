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
//  AAEngine.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 28/11/2017.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public class AAEngine: AACapabilityClass, AACapability {

    public let accessoriesPoweredState: AAProperty<AAActiveState>?
    public let engineState: AAProperty<AAActiveState>?
    public let ignitionState: AAProperty<AAActiveState>?


    // MARK: AACapability

    public static var identifier: AACapabilityIdentifier = 0x0035


    required init(properties: AAProperties) {
        // Ordered by the ID
        ignitionState = properties.property(forIdentifier: 0x01)
        accessoriesPoweredState = properties.property(forIdentifier: 0x02)
        engineState = properties.property(forIdentifier: 0x03)

        super.init(properties: properties)
    }
}

extension AAEngine: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getEngineState = 0x00
        case engineState    = 0x01
        case turnOnOff      = 0x12
    }
}

public extension AAEngine {

    static var getEngineState: AACommand {
        return command(forMessageType: .getEngineState)
    }


    static func turnIgnitionOnOff(_ state: AAActiveState) -> AACommand {
        let properties = [state.property(forIdentifier: 0x01)]

        return command(forMessageType: .turnOnOff, properties: properties)
    }
}
