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
//  AARace.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 07/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AARace: AAFullStandardCommand {

    public let accelerations: [AAAcceleration]?
    public let acceleratorPedalIdleSwitchState: AAActiveState?
    public let acceleratorPedalKickdownSwitchState: AAActiveState?
    public let brakePedalPosition: AAPercentageInt?
    public let brakePedalSwitchState: AAActiveState?
    public let brakePressure: Float?
    public let brakeTorqueVectorings: [AABrakeTorqueVectoring]?
    public let clutchPedalSwitchState: AAActiveState?
    public let espState: AAActiveState?
    public let gasPedalPosition: AAPercentageInt?
    public let gearMode: AAGearMode?
    public let oversteering: AAPercentageInt?
    public let rearSuspensionSteering: Int8?
    public let selectedGear: Int8?
    public let steeringAngle: Int8?
    public let understeering: AAPercentageInt?
    public let vehicleMoving: AAMovingState?
    public let yawRate: Float?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        accelerations = properties.flatMap(for: 0x01) { AAAcceleration($0.value) }
        understeering = properties.value(for: 0x02)
        oversteering = properties.value(for: 0x03)
        gasPedalPosition = properties.value(for: 0x04)
        steeringAngle = properties.value(for: 0x05)
        brakePressure = properties.value(for: 0x06)
        yawRate = properties.value(for: 0x07)
        rearSuspensionSteering = properties.value(for: 0x08)
        espState = properties.value(for: 0x09)
        brakeTorqueVectorings = properties.flatMap(for: 0x0A) { AABrakeTorqueVectoring($0.value) }
        gearMode = AAGearMode(rawValue: properties.first(for: 0x0B)?.monoValue)
        selectedGear = properties.value(for: 0x0C)
        brakePedalPosition = properties.value(for: 0x0D)
        brakePedalSwitchState = properties.value(for: 0x0E)
        clutchPedalSwitchState = properties.value(for: 0x0F)
        acceleratorPedalIdleSwitchState = properties.value(for: 0x10)
        acceleratorPedalKickdownSwitchState = properties.value(for: 0x11)
        /* Level 8 */
        vehicleMoving = AAMovingState(rawValue: properties.first(for: 0x12)?.monoValue)

        // Properties
        self.properties = properties
    }
}

extension AARace: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0057
}

extension AARace: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getRaceState   = 0x00
        case raceState      = 0x01
    }
}


// MARK: Commands

public extension AARace {

    static var getRaceState: [UInt8] {
        return commandPrefix(for: .getRaceState)
    }
}
