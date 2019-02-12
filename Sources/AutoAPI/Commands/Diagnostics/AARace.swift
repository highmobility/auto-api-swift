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

    public let accelerations: [AAProperty<AAAcceleration>]?
    public let acceleratorPedalIdleSwitchState: AAProperty<AAActiveState>?
    public let acceleratorPedalKickdownSwitchState: AAProperty<AAActiveState>?
    public let brakePedalPosition: AAProperty<AAPercentageInt>?
    public let brakePedalSwitchState: AAProperty<AAActiveState>?
    public let brakePressure: AAProperty<Float>?
    public let brakeTorqueVectorings: [AAProperty<AABrakeTorqueVectoring>]?
    public let clutchPedalSwitchState: AAProperty<AAActiveState>?
    public let espState: AAProperty<AAActiveState>?
    public let gasPedalPosition: AAProperty<AAPercentageInt>?
    public let gearMode: AAProperty<AAGearMode>?
    public let oversteering: AAProperty<AAPercentageInt>?
    public let rearSuspensionSteering: AAProperty<Int8>?
    public let selectedGear: AAProperty<Int8>?
    public let steeringAngle: AAProperty<Int8>?
    public let understeering: AAProperty<AAPercentageInt>?
    public let vehicleMoving: AAProperty<AAMovingState>?
    public let yawRate: AAProperty<Float>?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        accelerations = properties.properties(for: \AARace.accelerations)
        understeering = properties.property(for: \AARace.understeering)
        oversteering = properties.property(for: \AARace.oversteering)
        gasPedalPosition = properties.property(for: \AARace.gasPedalPosition)
        steeringAngle = properties.property(for: \AARace.steeringAngle)
        brakePressure = properties.property(for: \AARace.brakePressure)
        yawRate = properties.property(for: \AARace.yawRate)
        rearSuspensionSteering = properties.property(for: \AARace.rearSuspensionSteering)
        espState = properties.property(for: \AARace.espState)
        brakeTorqueVectorings = properties.properties(for: \AARace.brakeTorqueVectorings)
        gearMode = properties.property(for: \AARace.gearMode)
        selectedGear = properties.property(for: \AARace.selectedGear)
        brakePedalPosition = properties.property(for: \AARace.brakePedalPosition)
        brakePedalSwitchState = properties.property(for: \AARace.brakePedalSwitchState)
        clutchPedalSwitchState = properties.property(for: \AARace.clutchPedalSwitchState)
        acceleratorPedalIdleSwitchState = properties.property(for: \AARace.acceleratorPedalIdleSwitchState)
        acceleratorPedalKickdownSwitchState = properties.property(for: \AARace.acceleratorPedalKickdownSwitchState)
        /* Level 8 */
        vehicleMoving = properties.property(for: \AARace.vehicleMoving)

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

    static func propertyID<Type>(for keyPath: KeyPath<AARace, Type>) -> AAPropertyIdentifier? {
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
            return nil
        }
    }
}

public extension AARace {

    static var getRaceState: [UInt8] {
        return commandPrefix(for: .getRaceState)
    }
}
