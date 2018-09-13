//
// AutoAPITests
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
//  PowerTakeOff.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/04/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct PowerTakeOff: FullStandardCommand {

    public let activeState: ActiveState?
    public let engagedState: ActiveState?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        activeState = ActiveState(rawValue: properties.first(for: 0x01)?.monoValue)
        engagedState = ActiveState(rawValue: properties.first(for: 0x02)?.monoValue)

        // Properties
        self.properties = properties
    }
}

extension PowerTakeOff: Identifiable {

    public static var identifier: Identifier = Identifier(0x0065)
}

extension PowerTakeOff: MessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getState   = 0x00
        case state      = 0x01
        case setState   = 0x02
    }
}

public extension PowerTakeOff {

    static var getState: [UInt8] {
        return commandPrefix(for: .getState)
    }

    static var setState: (ActiveState) -> [UInt8] {
        return {
            return commandPrefix(for: .setState) + $0.propertyBytes(0x01)
        }
    }
}
