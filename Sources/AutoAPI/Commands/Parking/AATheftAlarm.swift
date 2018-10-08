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
//  AATheftAlarm.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 01/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AATheftAlarm: AAFullStandardCommand {

    public let state: AATheftAlarmState?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        state = AATheftAlarmState(properties: properties, keyPath: \AATheftAlarm.state)

        // Properties
        self.properties = properties
    }
}

extension AATheftAlarm: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0046
}

extension AATheftAlarm: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getAlarmState  = 0x00
        case alarmState     = 0x01
        case setAlarmState  = 0x02
    }
}

extension AATheftAlarm: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AATheftAlarm, Type>) -> AAPropertyIdentifier {
        switch keyPath {
        case \AATheftAlarm.state: return 0x01

        default:
            return 0x00
        }
    }
}


// MARK: Commands

public extension AATheftAlarm {

    static var getAlarmState: [UInt8] {
        return commandPrefix(for: .getAlarmState)
    }

    
    static func setAlarmState(_ state: AATheftAlarmState) -> [UInt8] {
        return commandPrefix(for: .setAlarmState) + state.propertyBytes(0x01)
    }
}
