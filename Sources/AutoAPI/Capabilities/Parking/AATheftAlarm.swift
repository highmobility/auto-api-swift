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
//  AATheftAlarm.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 01/12/2017.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public class AATheftAlarm: AACapabilityClass, AACapability {

    public let state: AAProperty<AATheftAlarmState>?


    // MARK: AACapability

    public static var identifier: AACapabilityIdentifier = 0x0046


    required init(properties: AAProperties) {
        // Ordered by the ID
        state = properties.property(forIdentifier: 0x01)

        super.init(properties: properties)
    }
}

extension AATheftAlarm: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getAlarmState  = 0x00
        case alarmState     = 0x01
        case setAlarmState  = 0x12
    }
}

public extension AATheftAlarm {

    static var getAlarmState: AACommand {
        return command(forMessageType: .getAlarmState)
    }

    
    static func setAlarmState(_ state: AATheftAlarmState) -> AACommand {
        let properties = [state.property(forIdentifier: 0x01)]

        return command(forMessageType: .setAlarmState, properties: properties)
    }
}
