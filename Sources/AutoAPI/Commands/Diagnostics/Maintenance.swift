//
// AutoAPI
// Copyright (C) 2017 High-Mobility GmbH
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
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct Maintenance: FullStandardCommand {

    public let daysToNextService: Int16?
    public let kmToNextService: UInt32?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        daysToNextService = properties.value(for: 0x01)
        kmToNextService = properties.value(for: 0x02)

        // Properties
        self.properties = properties
    }
}

extension Maintenance: Identifiable {

    public static var identifier: Identifier = Identifier(0x0034)
}

extension Maintenance: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesType {

        case getMaintenanceState    = 0x00
        case maintenanceState       = 0x01


        public static let getState = MessageTypes.getMaintenanceState
        public static let state = MessageTypes.maintenanceState

        public static var all: [UInt8] {
            return [self.getMaintenanceState.rawValue,
                    self.maintenanceState.rawValue]
        }
    }
}

public extension Maintenance {

    static var getMaintenanceState: [UInt8] {
        return getState
    }
}
