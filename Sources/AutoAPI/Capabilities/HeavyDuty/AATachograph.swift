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
//  AATachograph.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/04/2018.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public class AATachograph: AACapabilityClass, AACapability {

    public let driversCards: [AAProperty<AADriverCard>]?
    public let driversTimeStates: [AAProperty<AADriverTimeState>]?
    public let driversWorkingStates: [AAProperty<AADriverWorkingState>]?
    public let vehicleDirection: AAProperty<AADirection>?
    public let vehicleMotionState: AAProperty<AAMovingState>?
    public let vehicleOverspeedActive: AAProperty<AAActiveState>?
    public let vehicleSpeed: AAProperty<Int16>?


    // MARK: AACapability

    public static var identifier: AACapabilityIdentifier = 0x0064


    required init(properties: AAProperties) {
        // Ordered by the ID
        driversWorkingStates = properties.allOrNil(forIdentifier: 0x01)
        driversTimeStates = properties.allOrNil(forIdentifier: 0x02)
        driversCards = properties.allOrNil(forIdentifier: 0x03)
        vehicleMotionState = properties.property(forIdentifier: 0x04)
        vehicleOverspeedActive = properties.property(forIdentifier: 0x05)
        vehicleDirection = properties.property(forIdentifier: 0x06)
        vehicleSpeed = properties.property(forIdentifier: 0x07)

        super.init(properties: properties)
    }
}

extension AATachograph: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getState = 0x00
        case state    = 0x01
    }
}

public extension AATachograph {

    static var getState: AACommand {
        return command(forMessageType: .getState)
    }
}
