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
//  LightConditions.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 07/12/2017.
//  Copyright © 2019 High Mobility. All rights reserved.
//

import Foundation


public struct LightConditions: FullStandardCommand {

    public let insideLight: Float?
    public let outsideLight: Float?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        outsideLight = properties.value(for: 0x01)
        insideLight = properties.value(for: 0x02)

        // Properties
        self.properties = properties
    }
}

extension LightConditions: Identifiable {

    public static var identifier: Identifier = Identifier(0x0054)
}

extension LightConditions: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getLightConditions = 0x00
        case lightConditions    = 0x01


        public static var all: [LightConditions.MessageTypes] {
            return [self.getLightConditions,
                    self.lightConditions]
        }
    }
}

public extension LightConditions {

    static var getLightConditions: [UInt8] {
        return commandPrefix(for: .getLightConditions)
    }
}
