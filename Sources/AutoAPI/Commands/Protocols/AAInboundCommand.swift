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
//  AAInboundCommand.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 14/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


protocol AAInboundCommand: AACommand, AABinaryInitable, AAMessageTypesGettable, AAPropertiesCapable {

    init?(_ messageType: UInt8, properties: AAProperties)
}

extension AAInboundCommand {

    // MARK: AABinaryInitable

    init?<C>(_ binary: C) where C : Collection, C.Element == UInt8 {
        guard binary.count >= 3 else {
            return nil
        }

        guard AACommandIdentifier(binary) == Self.identifier else {
            return nil
        }

        let messageType = binary.bytes[2]
        let properties = AAProperties(binary.dropFirstBytes(3))

        self.init(messageType, properties: properties)
    }


    // MARK: AAPropertiesCapable

    public var carSignature: [UInt8]? {
        return properties.carSignature
    }

    public var milliseconds: TimeInterval? {
        return properties.milliseconds
    }

    public var nonce: [UInt8]? {
        return properties.nonce
    }

    public var timestamp: Date? {
        return properties.timestamp
    }

    public var propertiesTimestamps: [AAPropertyTimestamp]? {
        return properties.propertiesTimestamps
    }
}
