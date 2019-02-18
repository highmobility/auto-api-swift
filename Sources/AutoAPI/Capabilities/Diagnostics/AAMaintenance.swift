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


public class AAMaintenance: AACapabilityClass, AACapability {

    public typealias Weeks = UInt8


    public let automaticTeleserviceCallDate: AAProperty<Date>?
    public let brakeFluidChangeDate: AAProperty<Date>?
    public let cbsReportsCount: AAProperty<UInt8>?
    public let conditionBasedServices: [AAProperty<AAConditionBasedService>]?
    public let daysToNextService: AAProperty<Int16>?
    public let kmToNextService: AAProperty<UInt32>?
    public let monthsToExhaustInspection: AAProperty<UInt8>?
    public let nextInspectionDate: AAProperty<Date>?
    public let serviceDistanceThreshold: AAProperty<UInt16>?
    public let serviceTimeThreshold: AAProperty<Weeks>?
    public let teleserviceAvailability: AAProperty<AAAvailability>?
    public let teleserviceBatteryCallDate: AAProperty<Date>?


    // MARK: AACapability

    public static var identifier: AACommandIdentifier = 0x0034


    required init(properties: AAProperties) {
        // Ordered by the ID
        daysToNextService = properties.property(forIdentifier: 0x01)
        kmToNextService = properties.property(forIdentifier: 0x02)
        /* Level 8 */
        cbsReportsCount = properties.property(forIdentifier: 0x03)
        monthsToExhaustInspection = properties.property(forIdentifier: 0x04)
        teleserviceAvailability = properties.property(forIdentifier: 0x05)
        serviceDistanceThreshold = properties.property(forIdentifier: 0x06)
        serviceTimeThreshold = properties.property(forIdentifier: 0x07)
        automaticTeleserviceCallDate = properties.property(forIdentifier: 0x08)
        teleserviceBatteryCallDate = properties.property(forIdentifier: 0x09)
        nextInspectionDate = properties.property(forIdentifier: 0x0A)
        conditionBasedServices = properties.allOrNil(forIdentifier: 0x0B)
        brakeFluidChangeDate = properties.property(forIdentifier: 0x0C)

        super.init(properties: properties)
    }
}

extension AAMaintenance: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getMaintenanceState    = 0x00
        case maintenanceState       = 0x01
    }
}

public extension AAMaintenance {

    static var getMaintenanceState: AACommand {
        return command(forMessageType: .getMaintenanceState)
    }
}
