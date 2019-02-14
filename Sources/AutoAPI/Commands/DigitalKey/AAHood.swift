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
//  AAHood.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 31/08/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAHood: AAFullStandardCommand {

    public let position: AAProperty<AAPositionState>?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties

    init?(properties: AAProperties) {
        // Ordered by the ID
        position = properties.property(forIdentifier: 0x01)

        // Properties
        self.properties = properties
    }
}

extension AAHood: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0067
}

extension AAHood: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getHoodState   = 0x00
        case hoodState      = 0x01
    }
}

public extension AAHood {

    static var getHoodState: [UInt8] {
        return commandPrefix(for: .getHoodState)
    }
}
