//
// AutoAPI
// Copyright (C) 2017 High-Mobility GmbH
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
//  Engine.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 28/11/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct Engine: FullStandardCommand {

    public let ignition: IgnitionState?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        ignition = IgnitionState(rawValue: properties.first(for: 0x01)?.monoValue)

        // Properties
        self.properties = properties
    }
}

extension Engine: Identifiable {

    public static var identifier: Identifier = Identifier(0x0035)
}

extension Engine: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesType {

        case getIgnitionState   = 0x00
        case ignitionState      = 0x01
        case turnEngineOnOff    = 0x02


        public static let getState = MessageTypes.getIgnitionState
        public static let state = MessageTypes.ignitionState

        public static var all: [UInt8] {
            return [self.getIgnitionState.rawValue,
                    self.ignitionState.rawValue,
                    self.turnEngineOnOff.rawValue]
        }
    }
}

public extension Engine {

    static var getIgnitionState: [UInt8] {
        return getState
    }

    static var turnIgnition: (IgnitionState) -> [UInt8] {
        return {
            return Engine.identifier.bytes + [MessageTypes.turnEngineOnOff.rawValue, $0.rawValue]
        }
    }
}
