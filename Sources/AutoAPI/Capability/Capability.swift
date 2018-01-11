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
//  Capability.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 20/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
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

    public func supports<M: MessageTypesType>(_ messageTypes: [M]) -> Bool where M.RawValue == UInt8 {
        return supports(messageTypes.map { $0.rawValue })
    }

    public func supportsAllMessageTypes<M: MessageTypesGettable>(for command: M.Type) -> Bool where M.MessageTypes.RawValue == UInt8 {
        return supports(command.MessageTypes.all)
    }


    // MARK: Init

    init?<C: Collection>(binary: C, command: Command.Type) where C.Element == UInt8 {
        guard binary.count >= 2 else {
            return nil
        }

        self.command = command
        self.identifier = Identifier(binary.bytesArray.prefix(2))
        self.supportedMessageTypes = binary.dropFirstBytes(2)
    }
}
