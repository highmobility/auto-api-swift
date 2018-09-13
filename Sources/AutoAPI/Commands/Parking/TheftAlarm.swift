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
//  TheftAlarm.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 01/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
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

    public enum MessageTypes: UInt8, CaseIterable {

        case getAlarmState  = 0x00
        case alarmState     = 0x01
        case setAlarmState  = 0x02
    }
}

public extension TheftAlarm {

    static var getAlarmState: [UInt8] {
        return commandPrefix(for: .getAlarmState)
    }

    static var setAlarmState: (TheftAlarmState) -> [UInt8] {
        return {
            return commandPrefix(for: .setAlarmState) + $0.propertyBytes(0x01)
        }
    }
}
