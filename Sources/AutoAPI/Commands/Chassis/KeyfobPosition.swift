//
// AutoAPI
// Copyright (C) 2017 High-Mobility GmbH
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
//  KeyfobPosition.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct KeyfobPosition: FullStandardCommand {

    public let relativePosition: KeyfobRelativePosition?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        relativePosition = KeyfobRelativePosition(rawValue: properties.first(for: 0x01)?.monoValue)

        // Properties
        self.properties = properties
    }
}

extension KeyfobPosition: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesType {

        case getKeyfobPosition  = 0x00
        case keyfobPosition     = 0x01


        public static let getState = MessageTypes.getKeyfobPosition
        public static let state = MessageTypes.keyfobPosition

        public static var all: [UInt8] {
            return [self.getKeyfobPosition.rawValue,
                    self.keyfobPosition.rawValue]
        }
    }
}

extension KeyfobPosition: Identifiable {

    public static var identifier: Identifier = Identifier(0x0048)
}

public extension KeyfobPosition {

    static var getKeyfobPosition: [UInt8] {
        return getState
    }
}
