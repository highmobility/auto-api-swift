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
//  Capabilities.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 27/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct Capabilities: AAInboundCommand, Sequence  {

    public let capabilities: [Capability]


    // MARK: AAInboundCommand

    public let properties: AAProperties


    init?(_ messageType: UInt8, properties: AAProperties) {
        guard messageType == 0x01 else {
            return nil
        }

        let commandTypes = AutoAPI.commands.compactMap { $0 as? AACommand.Type }

        // Ordered by the ID
        capabilities = properties.filter(for: 0x01).compactMap { property in
            let identifier = AACommandIdentifier(property.value.prefix(2))

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

extension Capabilities: AAIdentifiable {

    public static var identifier: AACommandIdentifier = AACommandIdentifier(0x0010)
}

extension Capabilities: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getCapabilities    = 0x00
        case capabilities       = 0x01
        case getCapability      = 0x02
    }
}

public extension Capabilities {

    static var getCapabilities: [UInt8] {
        return commandPrefix(for: .getCapabilities)
    }

    static var getCapability: (AACommandIdentifier) -> [UInt8] {
        return {
            return commandPrefix(for: .getCapability) + $0.bytes
        }
    }
}
