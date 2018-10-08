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
//  AAMaintenance.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 29/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAMaintenance: AAFullStandardCommand {

    public typealias Weeks = UInt8


    public let automaticTeleserviceCallDate: Date?
    public let brakeFluidChangeDate: Date?
    public let cbsReportsCount: UInt8?
    public let conditionBasedServices: [AAConditionBasedService]?
    public let daysToNextService: Int16?
    public let kmToNextService: UInt32?
    public let monthsToExhaustInspection: UInt8?
    public let nextInspectionDate: Date?
    public let serviceDistanceThreshold: UInt16?
    public let serviceTimeThreshold: Weeks?
    public let teleserviceAvailability: AAAvailability?
    public let teleserviceBatteryCallDate: Date?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        daysToNextService = properties.value(for: \AAMaintenance.daysToNextService)
        kmToNextService = properties.value(for: \AAMaintenance.kmToNextService)
        /* Level 8 */
        cbsReportsCount = properties.value(for: \AAMaintenance.cbsReportsCount)
        monthsToExhaustInspection = properties.value(for: \AAMaintenance.monthsToExhaustInspection)
        teleserviceAvailability = AAAvailability(properties: properties, keyPath: \AAMaintenance.teleserviceAvailability)
        serviceDistanceThreshold = properties.value(for: \AAMaintenance.serviceDistanceThreshold)
        serviceTimeThreshold = properties.value(for: \AAMaintenance.serviceTimeThreshold)
        automaticTeleserviceCallDate = properties.value(for: \AAMaintenance.automaticTeleserviceCallDate)
        teleserviceBatteryCallDate = properties.value(for: \AAMaintenance.teleserviceBatteryCallDate)
        nextInspectionDate = properties.value(for: \AAMaintenance.nextInspectionDate)
        conditionBasedServices = properties.flatMap(for: \AAMaintenance.conditionBasedServices) { AAConditionBasedService($0.value) }
        brakeFluidChangeDate = properties.value(for: \AAMaintenance.brakeFluidChangeDate)

        // Properties
        self.properties = properties
    }
}

extension AAMaintenance: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0034
}

extension AAMaintenance: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getMaintenanceState    = 0x00
        case maintenanceState       = 0x01
    }
}

extension AAMaintenance: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AAMaintenance, Type>) -> AAPropertyIdentifier {
        switch keyPath {
        case \AAMaintenance.daysToNextService:  return 0x01
        case \AAMaintenance.kmToNextService:    return 0x02
            /* Level 8 */
        case \AAMaintenance.cbsReportsCount:                return 0x03
        case \AAMaintenance.monthsToExhaustInspection:      return 0x04
        case \AAMaintenance.teleserviceAvailability:        return 0x05
        case \AAMaintenance.serviceDistanceThreshold:       return 0x06
        case \AAMaintenance.serviceTimeThreshold:           return 0x07
        case \AAMaintenance.automaticTeleserviceCallDate:   return 0x08
        case \AAMaintenance.teleserviceBatteryCallDate:     return 0x09
        case \AAMaintenance.nextInspectionDate:             return 0x0A
        case \AAMaintenance.conditionBasedServices:         return 0x0B
        case \AAMaintenance.brakeFluidChangeDate:           return 0x0C

        default:
            return 0x00
        }
    }
}


// MARK: Commands

public extension AAMaintenance {

    static var getMaintenanceState: [UInt8] {
        return commandPrefix(for: .getMaintenanceState)
    }
}
