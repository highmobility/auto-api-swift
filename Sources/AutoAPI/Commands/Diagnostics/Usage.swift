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
//  Usage.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 31/08/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct Usage: AAFullStandardCommand {

    public let accelerationEvalution: AAPercentageInt?
    public let averageFuelConsumption: Float?
    public let averageWeeklyDistance: UInt16?
    public let averageWeeklyDistanceLongLife: UInt16?
    public let currentFuelConsumption: Float?
    public let drivingModeActivationPeriods: [AADrivingMode.ActivationPeriod]?
    public let drivingStyleEvalution: AAPercentageInt?
    public let energyConsumptions: [AADrivingMode.EnergyConsumption]?
    public let lastTripAverageEnergyRecuperation: UInt8?
    public let lastTripBatteryRemaining: AAPercentageInt?
    public let lastTripElectricPortion: AAPercentageInt?
    public let lastTripEnergyConsumption: Float?
    public let lastTripFuelConsumption: Float?
    public let lastTripDate: Date?
    public let mileageAfterLastTrip: UInt32?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        averageWeeklyDistance = properties.value(for: 0x01)
        averageWeeklyDistanceLongLife = properties.value(for: 0x02)
        accelerationEvalution = properties.value(for: 0x03)
        drivingStyleEvalution = properties.value(for: 0x04)
        drivingModeActivationPeriods = properties.flatMap(for: 0x05) { AADrivingMode.ActivationPeriod($0.value) }
        energyConsumptions = properties.flatMap(for: 0x06) { AADrivingMode.EnergyConsumption($0.value) }
        lastTripEnergyConsumption = properties.value(for: 0x07)
        lastTripFuelConsumption = properties.value(for: 0x08)
        mileageAfterLastTrip = properties.value(for: 0x09)
        lastTripElectricPortion = properties.value(for: 0x0A)
        lastTripAverageEnergyRecuperation = properties.value(for: 0x0B)
        lastTripBatteryRemaining = properties.value(for: 0x0C)
        lastTripDate = properties.value(for: 0x0D)
        averageFuelConsumption = properties.value(for: 0x0E)
        currentFuelConsumption = properties.value(for: 0x0F)

        // Properties
        self.properties = properties
    }
}

extension Usage: AAIdentifiable {

    public static var identifier: AACommandIdentifier = AACommandIdentifier(0x0068)
}

extension Usage: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getUsage   = 0x00
        case usageState = 0x01
    }
}

public extension Usage {

    static var getUsage: [UInt8] {
        return commandPrefix(for: .getUsage)
    }
}
