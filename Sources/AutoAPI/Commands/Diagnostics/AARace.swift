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
        accelerations = properties.flatMap(for: \AARace.accelerations) { AAAcceleration($0.value) }
        understeering = properties.value(for: \AARace.understeering)
        oversteering = properties.value(for: \AARace.oversteering)
        gasPedalPosition = properties.value(for: \AARace.gasPedalPosition)
        steeringAngle = properties.value(for: \AARace.steeringAngle)
        brakePressure = properties.value(for: \AARace.brakePressure)
        yawRate = properties.value(for: \AARace.yawRate)
        rearSuspensionSteering = properties.value(for: \AARace.rearSuspensionSteering)
        espState = properties.value(for: \AARace.espState)
        brakeTorqueVectorings = properties.flatMap(for: \AARace.brakeTorqueVectorings) { AABrakeTorqueVectoring($0.value) }
        gearMode = AAGearMode(properties: properties, keyPath: \AARace.gearMode)
        selectedGear = properties.value(for: \AARace.selectedGear)
        brakePedalPosition = properties.value(for: \AARace.brakePedalPosition)
        brakePedalSwitchState = properties.value(for: \AARace.brakePedalSwitchState)
        clutchPedalSwitchState = properties.value(for: \AARace.clutchPedalSwitchState)
        acceleratorPedalIdleSwitchState = properties.value(for: \AARace.acceleratorPedalIdleSwitchState)
        acceleratorPedalKickdownSwitchState = properties.value(for: \AARace.acceleratorPedalKickdownSwitchState)
        /* Level 8 */
        vehicleMoving = AAMovingState(properties: properties, keyPath: \AARace.vehicleMoving)

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

extension AARace: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AARace, Type>) -> AAPropertyIdentifier {
        switch keyPath {
        case \AARace.accelerations:                         return 0x01
        case \AARace.understeering:                         return 0x02
        case \AARace.oversteering:                          return 0x03
        case \AARace.gasPedalPosition:                      return 0x04
        case \AARace.steeringAngle:                         return 0x05
        case \AARace.brakePressure:                         return 0x06
        case \AARace.yawRate:                               return 0x07
        case \AARace.rearSuspensionSteering:                return 0x08
        case \AARace.espState:                              return 0x09
        case \AARace.brakeTorqueVectorings:                 return 0x0A
        case \AARace.gearMode:                              return 0x0B
        case \AARace.selectedGear:                          return 0x0C
        case \AARace.brakePedalPosition:                    return 0x0D
        case \AARace.brakePedalSwitchState:                 return 0x0E
        case \AARace.clutchPedalSwitchState:                return 0x0F
        case \AARace.acceleratorPedalIdleSwitchState:       return 0x10
        case \AARace.acceleratorPedalKickdownSwitchState:   return 0x11
            /* Level: 8 */
        case \AARace.vehicleMoving: return 0x12

        default:
            return 0x00
        }
    }
}

public extension AARace {

    static var getRaceState: [UInt8] {
        return commandPrefix(for: .getRaceState)
    }
}
