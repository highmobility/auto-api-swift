//
//  The MIT License
//
//  Copyright (c) 2014- High-Mobility GmbH (https://high-mobility.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//
//  Capabilities.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 27/11/2017.
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

        let commandTypes = AAAutoAPI.commands.compactMap { $0 as? Command.Type }

        // Ordered by the ID
        capabilities = properties.filter(for: 0x01).compactMap { property in
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

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getCapabilities    = 0x00
        case capabilities       = 0x01
        case getCapability      = 0x02


        public static var all: [Capabilities.MessageTypes] {
            return [self.getCapabilities,
                    self.capabilities,
                    self.getCapability]
        }
    }
}

public extension Capabilities {

    static var getCapabilities: [UInt8] {
        return commandPrefix(for: .getCapabilities)
    }

    static var getCapability: (Identifier) -> [UInt8] {
        return {
            return commandPrefix(for: .getCapability) + $0.bytes
        }
    }
}
