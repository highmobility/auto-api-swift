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
//  AACapability.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 20/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AACapability {

    public let command: AACommand.Type
    public let identifier: AACommandIdentifier
    public let supportedMessageTypes: [UInt8]   // TODO: Would be nice if this was an ARRAY of MESSAGE-TYPEs


    // MARK: Methods

    public func supports(_ messageTypes: [UInt8]) -> Bool {
        return Set(supportedMessageTypes).isSuperset(of: messageTypes)
    }

    public func supports<C: RawRepresentable & CaseIterable>(_ messageTypes: C...) -> Bool where C.RawValue == UInt8 {
        return supports(messageTypes.map { $0.rawValue })
    }

    public func supportsAllMessageTypes<M: AAMessageTypesGettable>(for command: M.Type) -> Bool where M.MessageTypes.RawValue == UInt8 {
        return supports(command.MessageTypes.allCases.map { $0.rawValue })
    }
}

extension AACapability: Equatable {

    public static func ==(lhs: AACapability, rhs: AACapability) -> Bool {
        // If the command matches, the 'identifier' must be the same
        return (lhs.command == rhs.command) && (lhs.supportedMessageTypes == rhs.supportedMessageTypes)
    }
}

extension AACapability: AABytesConvertable {

    public var bytes: [UInt8] {
        return identifier.bytes + supportedMessageTypes
    }


    public init?(bytes: [UInt8]) {
        guard bytes.count >= 2 else {
            return nil
        }

        let commandTypes = AAAutoAPI.commands.compactMap { $0 as? AACommand.Type }
        let identifier = AACommandIdentifier(bytes.prefix(2))

        guard let command = commandTypes.first(where: { $0.identifier == identifier }) else {
            return nil
        }

        self.command = command
        self.identifier = identifier
        self.supportedMessageTypes = bytes.dropFirstBytes(2)
    }
}
