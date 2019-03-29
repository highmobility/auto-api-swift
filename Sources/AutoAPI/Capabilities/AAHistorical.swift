//
// AutoAPI
// Copyright (C) 2019 High-Mobility GmbH
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
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public class AAHistorical: AACapabilityClass, AACapability {

    public let states: [AACapability]?


    // MARK: AACapability

    public static var identifier: AACommandIdentifier = 0x0012


    required init(properties: AAProperties) {
        /* Level 8 */
        states = properties.filter {
            $0.identifier == 0x01
        }.compactMap {
            $0.valueBytes
        }.compactMap {
            AAAutoAPI.parseBinary($0)
        }

        super.init(properties: properties)
    }
}

extension AAHistorical: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getHistoricalStates    = 0x00
        case states                 = 0x01
    }
}

public extension AAHistorical {

    static func getHistoricalStates(for capability: AACapability.Type, startDate: Date, endDate: Date) -> AACommand {
        let properties = [capability.identifier.property(forIdentifier: 0x01),
                          startDate.property(forIdentifier: 0x02),
                          endDate.property(forIdentifier: 0x03)]

        return command(forMessageType: .getHistoricalStates, properties: properties)
    }
}
