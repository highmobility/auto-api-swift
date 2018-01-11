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
//  TheftAlarm.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 01/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct TheftAlarm: FullStandardCommand {

    public let state: TheftAlarmState?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        state = TheftAlarmState(rawValue: properties.first(for: 0x01)?.monoValue)

        // Properties
        self.properties = properties
    }
}

extension TheftAlarm: Identifiable {

    public static var identifier: Identifier = Identifier(0x0046)
}

extension TheftAlarm: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesType {

        case getTheftAlarmState = 0x00
        case theftAlarmState    = 0x01
        case setTheftAlarm      = 0x02


        public static let getState = MessageTypes.getTheftAlarmState
        public static let state = MessageTypes.theftAlarmState

        public static var all: [UInt8] {
            return [self.getTheftAlarmState.rawValue,
                    self.theftAlarmState.rawValue,
                    self.setTheftAlarm.rawValue]
        }
    }
}

public extension TheftAlarm {

    static var getTheftAlarmState: [UInt8] {
        return getState
    }

    static var setTheftAlarm: (TheftAlarmState) -> [UInt8] {
        return {
            return TheftAlarm.identifier.bytes + [0x02, $0.rawValue]
        }
    }
}
