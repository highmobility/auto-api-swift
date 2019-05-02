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
//  AANaviDestination.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public class AANaviDestination: AACapabilityClass, AACapability {

    public let coordinates: AAProperty<AACoordinates>?
    public let name: AAProperty<String>?


    // MARK: AACapability

    public static var identifier: AACapabilityIdentifier = 0x0031


    required init(properties: AAProperties) {
        // Ordered by the ID
        name = properties.property(forIdentifier: 0x02)
        /* Level 8 */
        coordinates = properties.property(forIdentifier: 0x07)

        super.init(properties: properties)
    }
}

extension AANaviDestination: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getDestination = 0x00
        case destination    = 0x01
        case setDestination = 0x12
    }
}

public extension AANaviDestination {

    static var getDestination: AACommand {
        return command(forMessageType: .getDestination)
    }


    static func setDestination(coordinates: AACoordinates, name: String?) -> AACommand {
        let properties = [coordinates.property(forIdentifier: 0x07),
                          name?.property(forIdentifier: 0x02)]

        return command(forMessageType: .setDestination, properties: properties)
    }
}
