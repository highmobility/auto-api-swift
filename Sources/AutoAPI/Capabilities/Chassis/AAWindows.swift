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
//  AAWindows.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 01/12/2017.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public class AAWindows: AACapabilityClass, AACapability {

    public let openPercentages: [AAProperty<AAWindowOpenPercentage>]?
    public let positions: [AAProperty<AAWindowPosition>]?


    // MARK: AACapability

    public static var identifier: AACapabilityIdentifier = 0x0045


    required init(properties: AAProperties) {
        // Ordered by the ID
        /* Level 8 */
        openPercentages = properties.allOrNil(forIdentifier: 0x02)
        positions = properties.allOrNil(forIdentifier: 0x03)

        super.init(properties: properties)
    }
}

extension AAWindows: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getWindowsState    = 0x00
        case windowsState       = 0x01
        case control            = 0x12
    }
}

public extension AAWindows {

    static var getWindowsState: AACommand {
        return command(forMessageType: .getWindowsState)
    }


    static func controlWindows(openPercentages: [AAWindowOpenPercentage]?, positions: [AAWindowPosition]?) -> AACommand {
        var properties: [AABasicProperty?] = []

        properties += openPercentages?.map { $0.property(forIdentifier: 0x01 )} ?? []
        properties += positions?.map { $0.property(forIdentifier: 0x02) } ?? []

        return command(forMessageType: .control, properties: properties)
    }
}
