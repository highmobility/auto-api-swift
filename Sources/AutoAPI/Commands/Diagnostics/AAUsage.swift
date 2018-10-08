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


public struct AAUsage: AAFullStandardCommand {

    public let accelerationEvalution: AAPercentageInt?
    public let averageFuelConsumption: Float?
    public let averageWeeklyDistance: UInt16?
    public let averageWeeklyDistanceLongTerm: UInt16?
    public let currentFuelConsumption: Float?
    public let drivingModeActivationPeriods: [AADrivingMode.ActivationPeriod]?
    public let drivingModeEnergyConsumptions: [AADrivingMode.EnergyConsumption]?
    public let drivingStyleEvalution: AAPercentageInt?
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
        /* Level 8 */
        averageWeeklyDistance = properties.value(for: \AAUsage.averageWeeklyDistance)
        averageWeeklyDistanceLongTerm = properties.value(for: \AAUsage.averageWeeklyDistanceLongTerm)
        accelerationEvalution = properties.value(for: \AAUsage.accelerationEvalution)
        drivingStyleEvalution = properties.value(for: \AAUsage.drivingStyleEvalution)
        drivingModeActivationPeriods = properties.flatMap(for: \AAUsage.drivingModeActivationPeriods) { AADrivingMode.ActivationPeriod($0.value) }
        drivingModeEnergyConsumptions = properties.flatMap(for: \AAUsage.drivingModeEnergyConsumptions) { AADrivingMode.EnergyConsumption($0.value) }
        lastTripEnergyConsumption = properties.value(for: \AAUsage.lastTripEnergyConsumption)
        lastTripFuelConsumption = properties.value(for: \AAUsage.lastTripFuelConsumption)
        mileageAfterLastTrip = properties.value(for: \AAUsage.mileageAfterLastTrip)
        lastTripElectricPortion = properties.value(for: \AAUsage.lastTripElectricPortion)
        lastTripAverageEnergyRecuperation = properties.value(for: \AAUsage.lastTripAverageEnergyRecuperation)
        lastTripBatteryRemaining = properties.value(for: \AAUsage.lastTripBatteryRemaining)
        lastTripDate = properties.value(for: \AAUsage.lastTripDate)
        averageFuelConsumption = properties.value(for: \AAUsage.averageFuelConsumption)
        currentFuelConsumption = properties.value(for: \AAUsage.currentFuelConsumption)

        // Properties
        self.properties = properties
    }
}

extension AAUsage: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0068
}

extension AAUsage: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getUsage   = 0x00
        case usageState = 0x01
    }
}

extension AAUsage: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AAUsage, Type>) -> AAPropertyIdentifier {
        switch keyPath {
            /* Level 8 */
        case \AAUsage.averageWeeklyDistance:                return 0x01
        case \AAUsage.averageWeeklyDistanceLongTerm:        return 0x02
        case \AAUsage.accelerationEvalution:                return 0x03
        case \AAUsage.drivingStyleEvalution:                return 0x04
        case \AAUsage.drivingModeActivationPeriods:         return 0x05
        case \AAUsage.drivingModeEnergyConsumptions:        return 0x06
        case \AAUsage.lastTripEnergyConsumption:            return 0x07
        case \AAUsage.lastTripFuelConsumption:              return 0x08
        case \AAUsage.mileageAfterLastTrip:                 return 0x09
        case \AAUsage.lastTripElectricPortion:              return 0x0A
        case \AAUsage.lastTripAverageEnergyRecuperation:    return 0x0B
        case \AAUsage.lastTripBatteryRemaining:             return 0x0C
        case \AAUsage.lastTripDate:                         return 0x0D
        case \AAUsage.averageFuelConsumption:               return 0x0E
        case \AAUsage.currentFuelConsumption:               return 0x0F

        default:
            return 0x00
        }
    }
}


// MARK: Commands

public extension AAUsage {

    static var getUsage: [UInt8] {
        return commandPrefix(for: .getUsage)
    }
}
