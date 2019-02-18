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
//  AACapabilityClass.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 17/02/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public class AACapabilityClass: AABytesConvertable {

    public var carSignature: [UInt8]? {
        return properties.carSignature
    }

    public var nonce: [UInt8]? {
        return properties.nonce
    }

    public var timestamp: Date? {
        return properties.timestamp
    }

    public var properties: AAProperties


    // MARK: AABytesConvertable

    public var bytes: [UInt8] {
        /*
         Workaround for the "inheritance-disablity"... (probably not the best solution).
         */
        guard let capability = self as? AACapability else {
            fatalError("The class needs to implement AACapability protocol.")
        }

        // TODO: Uses the default incoming Message Type – will become obsolete in L11
        return type(of: capability).identifier.bytes + [0x01] + properties.bytes
    }


    required public convenience init?(bytes: [UInt8]) {
        guard bytes.count >= 3 else {
            return nil
        }

        guard let identifier = AACommandIdentifier(bytes: bytes[0...1]) else {
            return nil
        }

        // TODO: Uses the default incoming Message Type – will become obsolete in L11
        guard bytes[2] == 0x01 else {
            return nil
        }

        guard let properties = AAProperties(bytes: bytes[3...]) else {
            return nil
        }

        self.init(properties: properties)

        /*
         Workaround for the "inheritance-disablity"... (probably not the best solution).
         */
        guard let capability = self as? AACapability  else {
            fatalError("The class needs to implement AACapability protocol.")
        }

        guard identifier == type(of: capability).identifier else {
            return nil
        }
    }


    // MARK: Init

    required init(properties: AAProperties) {
        self.properties = properties
    }
}
