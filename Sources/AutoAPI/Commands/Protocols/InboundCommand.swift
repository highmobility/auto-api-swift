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
//  InboundCommand.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 14/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


protocol InboundCommand: CommandAggregate, BinaryInitable, PropertiesCapable {

    init?(_ messageType: UInt8, properties: Properties)
}

extension InboundCommand {

    // MARK: BinaryInitable

    init?<C>(_ binary: C) where C : Collection, C.Element == UInt8 {
        guard binary.count >= 3 else {
            return nil
        }

        guard Identifier(binary) == Self.identifier else {
            return nil
        }

        let messageType = binary.bytes[2]
        let properties = Properties(binary.dropFirstBytes(3))

        self.init(messageType, properties: properties)
    }


    // MARK: PropertiesCapable

    public var carSignature: [UInt8]? {
        return properties.carSignature
    }

    public var nonce: [UInt8]? {
        return properties.nonce
    }

    public var timestamp: YearTime? {
        return properties.timestamp
    }
}
