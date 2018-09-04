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
//  Race.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 07/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct Race: FullStandardCommand {

    public let accelerations: [Acceleration]?
    public let brakePedalPosition: PercentageInt?
    public let brakePressure: Float?
    public let brakeTorqueVectorings: [BrakeTorqueVectoring]?
    public let gasPedalPosition: PercentageInt?
    public let gearMode: GearMode?
    public let isAcceleratorPedalIdleSwitchActive: Bool?
    public let isAcceleratorPedalKickdownSwitchActive: Bool?
    public let isBrakePedalSwitchActive: Bool?
    public let isClutchPedalSwitchActive: Bool?
    public let isESPActive: Bool?
    public let oversteering: PercentageInt?
    public let rearSuspensionSteering: Int8?
    public let selectedGear: Int8?
    public let steeringAngle: Int8?
    public let understeering: PercentageInt?
    public let yawRate: Float?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        accelerations = properties.flatMap(for: 0x01) { Acceleration($0.value) }
        understeering = properties.value(for: 0x02)
        oversteering = properties.value(for: 0x03)
        gasPedalPosition = properties.value(for: 0x04)
        steeringAngle = properties.value(for: 0x05)
        brakePressure = properties.value(for: 0x06)
        yawRate = properties.value(for: 0x07)
        rearSuspensionSteering = properties.value(for: 0x08)
        isESPActive = properties.value(for: 0x09)
        brakeTorqueVectorings = properties.flatMap(for: 0x0A) { BrakeTorqueVectoring($0.value) }
        gearMode = GearMode(rawValue: properties.first(for: 0x0B)?.monoValue)
        selectedGear = properties.value(for: 0x0C)
        brakePedalPosition = properties.value(for: 0x0D)
        isBrakePedalSwitchActive = properties.value(for: 0x0E)
        isClutchPedalSwitchActive = properties.value(for: 0x0F)
        isAcceleratorPedalIdleSwitchActive = properties.value(for: 0x10)
        isAcceleratorPedalKickdownSwitchActive = properties.value(for: 0x11)

        // Properties
        self.properties = properties
    }
}

extension Race: Identifiable {

    public static var identifier: Identifier = Identifier(0x0057)
}

extension Race: MessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getRaceState   = 0x00
        case raceState      = 0x01
    }
}

public extension Race {

    static var getRaceState: [UInt8] {
        return commandPrefix(for: .getRaceState)
    }
}
