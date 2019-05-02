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
//  AARace.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 07/12/2017.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public class AARace: AACapabilityClass, AACapability {

    public let accelerations: [AAProperty<AAAcceleration>]?
    public let acceleratorPedalIdleSwitchState: AAProperty<AAActiveState>?
    public let acceleratorPedalKickdownSwitchState: AAProperty<AAActiveState>?
    public let brakePedalPosition: AAProperty<AAPercentage>?
    public let brakePedalSwitchState: AAProperty<AAActiveState>?
    public let brakePressure: AAProperty<Float>?
    public let brakeTorqueVectorings: [AAProperty<AABrakeTorqueVectoring>]?
    public let clutchPedalSwitchState: AAProperty<AAActiveState>?
    public let espState: AAProperty<AAActiveState>?
    public let gasPedalPosition: AAProperty<AAPercentage>?
    public let gearMode: AAProperty<AAGearMode>?
    public let oversteering: AAProperty<AAPercentage>?
    public let rearSuspensionSteering: AAProperty<Int8>?
    public let selectedGear: AAProperty<Int8>?
    public let steeringAngle: AAProperty<Int8>?
    public let understeering: AAProperty<AAPercentage>?
    public let vehicleMoving: AAProperty<AAMovingState>?
    public let yawRate: AAProperty<Float>?


    // MARK: AACapability

    public static var identifier: AACapabilityIdentifier = 0x0057


    required init(properties: AAProperties) {
        // Ordered by the ID
        accelerations = properties.allOrNil(forIdentifier: 0x01)
        understeering = properties.property(forIdentifier: 0x02)
        oversteering = properties.property(forIdentifier: 0x03)
        gasPedalPosition = properties.property(forIdentifier: 0x04)
        steeringAngle = properties.property(forIdentifier: 0x05)
        brakePressure = properties.property(forIdentifier: 0x06)
        yawRate = properties.property(forIdentifier: 0x07)
        rearSuspensionSteering = properties.property(forIdentifier: 0x08)
        espState = properties.property(forIdentifier: 0x09)
        brakeTorqueVectorings = properties.allOrNil(forIdentifier: 0x0A)
        gearMode = properties.property(forIdentifier: 0x0B)
        selectedGear = properties.property(forIdentifier: 0x0C)
        brakePedalPosition = properties.property(forIdentifier: 0x0D)
        brakePedalSwitchState = properties.property(forIdentifier: 0x0E)
        clutchPedalSwitchState = properties.property(forIdentifier: 0x0F)
        acceleratorPedalIdleSwitchState = properties.property(forIdentifier: 0x10)
        acceleratorPedalKickdownSwitchState = properties.property(forIdentifier: 0x11)
        /* Level 8 */
        vehicleMoving = properties.property(forIdentifier: 0x12)

        super.init(properties: properties)
    }
}

extension AARace: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getRaceState   = 0x00
        case raceState      = 0x01
    }
}

public extension AARace {

    static var getRaceState: AACommand {
        return command(forMessageType: .getRaceState)
    }
}
