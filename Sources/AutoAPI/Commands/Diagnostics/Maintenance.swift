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
//  Maintenance.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 29/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct Maintenance: FullStandardCommand {

    public typealias Weeks = UInt8


    public let automaticTeleserviceCallDate: Date?
    public let cbsReportsCount: UInt8?
    public let daysToNextService: Int16?
    public let kmToNextService: UInt32?
    public let monthsToExhaustInspection: UInt8?
    public let nextInspectionDate: Date?
    public let serviceDistanceThreshold: UInt16?
    public let serviceTimeThreshold: Weeks?
    public let teleserviceAvailability: Availability?
    public let teleserviceBatteryCallDate: Date?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        daysToNextService = properties.value(for: 0x01)
        kmToNextService = properties.value(for: 0x02)
        cbsReportsCount = properties.value(for: 0x03)
        monthsToExhaustInspection = properties.value(for: 0x04)
        teleserviceAvailability = Availability(rawValue: properties.first(for: 0x05)?.monoValue)
        serviceDistanceThreshold = properties.value(for: 0x06)
        serviceTimeThreshold = properties.value(for: 0x07)
        automaticTeleserviceCallDate = properties.value(for: 0x08)
        teleserviceBatteryCallDate = properties.value(for: 0x09)
        nextInspectionDate = properties.value(for: 0x0A)

        // Properties
        self.properties = properties
    }
}

extension Maintenance: Identifiable {

    public static var identifier: Identifier = Identifier(0x0034)
}

extension Maintenance: MessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getMaintenanceState    = 0x00
        case maintenanceState       = 0x01
    }
}

public extension Maintenance {

    static var getMaintenanceState: [UInt8] {
        return commandPrefix(for: .getMaintenanceState)
    }
}
