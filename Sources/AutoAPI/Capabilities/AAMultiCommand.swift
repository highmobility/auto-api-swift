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
//  AAMultiCommand.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 14/11/2018.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAMultiCommand: AACapabilityClass, AACapability {

    public let states: [AACapability]?


    // MARK: AACapability

    public static var identifier: AACommandIdentifier = 0x0013


    required init(properties: AAProperties) {
        /* Level 9 */
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

extension AAMultiCommand: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case states = 0x01
        case send   = 0x02
    }
}


public extension AAMultiCommand {

    static func combined(_ commands: AACommand...) -> AACommand {
        let properties = commands.map { $0.property(forIdentifier: 0x01) }

        return command(forMessageType: .send, properties: properties)
    }
}
