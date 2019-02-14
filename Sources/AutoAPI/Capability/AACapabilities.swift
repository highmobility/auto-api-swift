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
//  AACapabilities.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 27/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AACapabilities: AAInboundCommand  {

    public let capabilities: [AAProperty<AACapability>]?


    // MARK: AAInboundCommand

    public let properties: AAProperties


    init?(_ messageType: UInt8, properties: AAProperties) {
        guard messageType == 0x01 else {
            return nil
        }

        // Ordered by the ID
        capabilities = properties.allOrNil(forIdentifier: 0x01)

        // Properties
        self.properties = properties
    }
}

extension AACapabilities: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0010
}

extension AACapabilities: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getCapabilities    = 0x00
        case capabilities       = 0x01
        case getCapability      = 0x02
    }
}

public extension AACapabilities {

    static var getCapabilities: [UInt8] {
        return commandPrefix(for: .getCapabilities)
    }


    static func getCapability(_ commandID: AACommandIdentifier) -> [UInt8] {
        return commandPrefix(for: .getCapability) + commandID.bytes
    }
}
