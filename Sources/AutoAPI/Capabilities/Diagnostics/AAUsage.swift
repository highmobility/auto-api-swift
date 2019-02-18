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
//  AAUsage.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 31/08/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public class AAUsage: AACapabilityClass, AACapability {

    public let accelerationEvalution: AAProperty<AAPercentage>?
    public let averageFuelConsumption: AAProperty<Float>?
    public let averageWeeklyDistance: AAProperty<UInt16>?
    public let averageWeeklyDistanceLongTerm: AAProperty<UInt16>?
    public let currentFuelConsumption: AAProperty<Float>?
    public let drivingModeActivationPeriods: [AAProperty<AADrivingMode.ActivationPeriod>]?
    public let drivingModeEnergyConsumptions: [AAProperty<AADrivingMode.EnergyConsumption>]?
    public let drivingStyleEvalution: AAProperty<AAPercentage>?
    public let lastTripAverageEnergyRecuperation: AAProperty<Float>?
    public let lastTripBatteryRemaining: AAProperty<AAPercentage>?
    public let lastTripElectricPortion: AAProperty<AAPercentage>?
    public let lastTripEnergyConsumption: AAProperty<Float>?
    public let lastTripFuelConsumption: AAProperty<Float>?
    public let lastTripDate: AAProperty<Date>?
    public let mileageAfterLastTrip: AAProperty<UInt32>?


    // MARK: AACapability

    public static var identifier: AACommandIdentifier = 0x0068


    required init(properties: AAProperties) {
        // Ordered by the ID
        /* Level 8 */
        averageWeeklyDistance = properties.property(forIdentifier: 0x01)
        averageWeeklyDistanceLongTerm = properties.property(forIdentifier: 0x02)
        accelerationEvalution = properties.property(forIdentifier: 0x03)
        drivingStyleEvalution = properties.property(forIdentifier: 0x04)
        drivingModeActivationPeriods = properties.allOrNil(forIdentifier: 0x05)
        drivingModeEnergyConsumptions = properties.allOrNil(forIdentifier: 0x06)
        lastTripEnergyConsumption = properties.property(forIdentifier: 0x07)
        lastTripFuelConsumption = properties.property(forIdentifier: 0x08)
        mileageAfterLastTrip = properties.property(forIdentifier: 0x09)
        lastTripElectricPortion = properties.property(forIdentifier: 0x0A)
        lastTripAverageEnergyRecuperation = properties.property(forIdentifier: 0x0B)
        lastTripBatteryRemaining = properties.property(forIdentifier: 0x0C)
        lastTripDate = properties.property(forIdentifier: 0x0D)
        averageFuelConsumption = properties.property(forIdentifier: 0x0E)
        currentFuelConsumption = properties.property(forIdentifier: 0x0F)

        super.init(properties: properties)
    }
}

extension AAUsage: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getUsage   = 0x00
        case usageState = 0x01
    }
}

public extension AAUsage {

    static var getUsage: AACommand {
        return command(forMessageType: .getUsage)
    }
}
