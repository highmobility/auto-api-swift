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
//  AAOffroad.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 06/12/2017.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public class AAOffroad: AACapabilityClass, AACapability {

    public let routeIncline: AAProperty<Int16>?
    public let wheelSuspension: AAProperty<AAPercentage>?


    // MARK: AACapability

    public static var identifier: AACommandIdentifier = 0x0052


    required init(properties: AAProperties) {
        // Ordered by the ID
        routeIncline = properties.property(forIdentifier: 0x01)
        wheelSuspension = properties.property(forIdentifier: 0x02)

        super.init(properties: properties)
    }
}

extension AAOffroad: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getOffroadState    = 0x00
        case offroadState       = 0x01
    }
}

public extension AAOffroad {

    static var getOffroadState: AACommand {
        return command(forMessageType: .getOffroadState)
    }
}
