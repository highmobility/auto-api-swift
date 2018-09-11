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
//  Mobile.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 31/08/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct Mobile: FullStandardCommand {

    public let mobileConnected: ConnectionState?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        mobileConnected = ConnectionState(rawValue: properties.first(for: 0x01)?.monoValue)


        // Properties
        self.properties = properties
    }
}

extension Mobile: Identifiable {

    public static var identifier: Identifier = Identifier(0x0066)
}

extension Mobile: MessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getMobileConnectionState   = 0x00
        case mobileConnectionState      = 0x01
    }
}

public extension Mobile {

    static var getMobileConnectionState: [UInt8] {
        return commandPrefix(for: .getMobileConnectionState)
    }
}
