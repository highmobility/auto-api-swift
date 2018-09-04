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

    public let isActive: Bool?
    public let isEngaged: Bool?


    // MARK: FullStandardCommand

    public var properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        isActive = properties.value(for: 0x01)
        isEngaged = properties.value(for: 0x02)

        // Properties
        self.properties = properties
    }
}

extension PowerTakeOff: Identifiable {

    public static var identifier: Identifier = Identifier(0x0065)
}

extension PowerTakeOff: MessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getPowerTakeOffState           = 0x00
        case powerTakeOffState              = 0x01
        case activateDeactivatePowerTakeOff = 0x02
    }
}

public extension PowerTakeOff {

    /// Use `false` to *inactivate* the power take-off.
    static var activatePowerTakeOff: (Bool) -> [UInt8] {
        return {
            return commandPrefix(for: .activateDeactivatePowerTakeOff) + $0.propertyBytes(0x01)
        }
    }

    static var getPowerTakeOffState: [UInt8] {
        return commandPrefix(for: .getPowerTakeOffState)
    }
}
