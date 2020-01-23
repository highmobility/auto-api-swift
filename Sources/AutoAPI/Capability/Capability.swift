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
//  Capability.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 20/12/2017.
//

import Foundation


public struct Capability {

    public let command: Command.Type
    public let identifier: Identifier
    public let supportedMessageTypes: [UInt8]   // TODO: Would be nice if this was an ARRAY of MESSAGE-TYPEs


    // MARK: Methods

    public func supports(_ messageTypes: [UInt8]) -> Bool {
        return Set(supportedMessageTypes).isSuperset(of: messageTypes)
    }

    public func supports<M: MessageTypesKind>(_ messageTypes: M...) -> Bool where M.RawValue == UInt8 {
        return supports(messageTypes.map { $0.rawValue })
    }

    public func supportsAllMessageTypes<M: MessageTypesGettable>(for command: M.Type) -> Bool where M.MessageTypes.RawValue == UInt8 {
        return supports(command.MessageTypes.all.map { $0.rawValue })
    }


    // MARK: Init

    init?<C: Collection>(binary: C, command: Command.Type) where C.Element == UInt8 {
        guard binary.count >= 2 else {
            return nil
        }

        self.command = command
        self.identifier = Identifier(binary.bytes.prefix(2))
        self.supportedMessageTypes = binary.dropFirstBytes(2)
    }
}

extension Capability: Equatable {

    public static func ==(lhs: Capability, rhs: Capability) -> Bool {
        // If the command matches, the 'identifier' must be the same
        return (lhs.command == rhs.command) && (lhs.supportedMessageTypes == rhs.supportedMessageTypes)
    }
}
