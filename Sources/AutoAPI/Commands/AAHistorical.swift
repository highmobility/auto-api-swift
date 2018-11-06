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
//  AAHistorical.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 01/10/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAHistorical: AAInboundCommand, AAOutboundCommand {

    public let states: [AAHistoricalState]?


    // MARK: AAInboundCommand

    public let properties: AAProperties


    init?(_ messageType: UInt8, properties: AAProperties) {
        guard messageType == 0x01 else {
            return nil
        }

        let binaryTypes = AAAutoAPI.commands.compactMap { $0 as? AABinaryInitable.Type }

        /* Level 8 */
        states = properties.flatMap(for: \AAHistorical.states) { property in
            binaryTypes.flatMapFirst { $0.init(property.value) as? AAHistoricalState }
        }

        // Properties
        self.properties = properties
    }
}

extension AAHistorical: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0012
}

extension AAHistorical: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getHistoricalStates    = 0x00
        case states                 = 0x01
    }
}

extension AAHistorical: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AAHistorical, Type>) -> AAPropertyIdentifier {
        switch keyPath {
        case \AAHistorical.states: return 0x01

        default:
            return 0x00
        }
    }
}


// MARK: Commands

public extension AAHistorical {

    static func getHistoricalStates(for capability: AAHistoryCapable, startDate: Date, endDate: Date) -> [UInt8] {
        return commandPrefix(for: .getHistoricalStates) + [capability.propertyBytes(0x01),
                                                           startDate.propertyBytes(0x02),
                                                           endDate.propertyBytes(0x03)].propertiesValuesCombined
    }
}
