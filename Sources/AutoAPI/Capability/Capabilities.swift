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
//  Capabilities.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 27/11/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct Capabilities: InboundCommand, Sequence  {

    public let capabilities: [Capability]


    // MARK: InboundCommand

    public let properties: Properties


    init?(_ messageType: UInt8, properties: Properties) {
        guard messageType == 0x01 else {
            return nil
        }

        let commandTypes = AutoAPI.commands.flatMap { $0 as? Command.Type }

        // Ordered by the ID
        capabilities = properties.filter(for: 0x01).flatMap { property in
            let identifier = Identifier(property.value.prefix(2))

            guard let command = commandTypes.first(where: { $0.identifier == identifier }) else {
                return nil
            }

            return Capability(binary: property.value, command: command)
        }

        // Properties
        self.properties = properties
    }


    // MARK: Sequence

    public typealias Iterator = CapabilitiesIterator


    public func makeIterator() -> CapabilitiesIterator {
        return CapabilitiesIterator(propertiesArray: properties.filter(for: 0x01))
    }
}

extension Capabilities: Identifiable {

    public static var identifier: Identifier = Identifier(0x0010)
}

extension Capabilities: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesType {

        case getCapabilities    = 0x00
        case capabilities       = 0x01
        case getCapability      = 0x02


        public static var all: [UInt8] {
            return [self.getCapabilities.rawValue,
                    self.capabilities.rawValue,
                    self.getCapability.rawValue]
        }
    }
}

public extension Capabilities {

    /// Same as `getCapabilities` type var.
    static var getAll: [UInt8] {
        return Capabilities.identifier.bytes + [0x00]
    }

    /// Same as `getAll` type var.
    static var getCapabilities: [UInt8] {
        return getAll
    }

    /// Same as `getSingle` type var.
    static var getCapability: (Identifier) -> [UInt8] {
        return getSingle
    }

    /// Same as `getCapability` type var.
    static var getSingle: (Identifier) -> [UInt8] {
        return {
            return Capabilities.identifier.bytes + [0x02] + $0.bytes
        }
    }
}
