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

    public let accelerationEvalution: AAProperty<AAPercentageInt>?
    public let averageFuelConsumption: AAProperty<Float>?
    public let averageWeeklyDistance: AAProperty<UInt16>?
    public let averageWeeklyDistanceLongTerm: AAProperty<UInt16>?
    public let currentFuelConsumption: AAProperty<Float>?
    public let drivingModeActivationPeriods: [AAProperty<AADrivingMode.ActivationPeriod>]?
    public let drivingModeEnergyConsumptions: [AAProperty<AADrivingMode.EnergyConsumption>]?
    public let drivingStyleEvalution: AAProperty<AAPercentageInt>?
    public let lastTripAverageEnergyRecuperation: AAProperty<Float>?
    public let lastTripBatteryRemaining: AAProperty<AAPercentageInt>?
    public let lastTripElectricPortion: AAProperty<AAPercentageInt>?
    public let lastTripEnergyConsumption: AAProperty<Float>?
    public let lastTripFuelConsumption: AAProperty<Float>?
    public let lastTripDate: AAProperty<Date>?
    public let mileageAfterLastTrip: AAProperty<UInt32>?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        /* Level 8 */
        averageWeeklyDistance = properties.property(for: \AAUsage.averageWeeklyDistance)
        averageWeeklyDistanceLongTerm = properties.property(for: \AAUsage.averageWeeklyDistanceLongTerm)
        accelerationEvalution = properties.property(for: \AAUsage.accelerationEvalution)
        drivingStyleEvalution = properties.property(for: \AAUsage.drivingStyleEvalution)
        drivingModeActivationPeriods = properties.properties(for: \AAUsage.drivingModeActivationPeriods)
        drivingModeEnergyConsumptions = properties.properties(for: \AAUsage.drivingModeEnergyConsumptions)
        lastTripEnergyConsumption = properties.property(for: \AAUsage.lastTripEnergyConsumption)
        lastTripFuelConsumption = properties.property(for: \AAUsage.lastTripFuelConsumption)
        mileageAfterLastTrip = properties.property(for: \AAUsage.mileageAfterLastTrip)
        lastTripElectricPortion = properties.property(for: \AAUsage.lastTripElectricPortion)
        lastTripAverageEnergyRecuperation = properties.property(for: \AAUsage.lastTripAverageEnergyRecuperation)
        lastTripBatteryRemaining = properties.property(for: \AAUsage.lastTripBatteryRemaining)
        lastTripDate = properties.property(for: \AAUsage.lastTripDate)
        averageFuelConsumption = properties.property(for: \AAUsage.averageFuelConsumption)
        currentFuelConsumption = properties.property(for: \AAUsage.currentFuelConsumption)

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

    static func propertyID<Type>(for keyPath: KeyPath<AAUsage, Type>) -> AAPropertyIdentifier? {
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
            return nil
        }
    }
}

public extension AAUsage {

    static var getUsage: [UInt8] {
        return commandPrefix(for: .getUsage)
    }
}
