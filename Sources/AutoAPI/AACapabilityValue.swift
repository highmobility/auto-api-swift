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
//  AACapabilityValue.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 17/02/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public struct AACapabilityValue {

    public let command: AACapability.Type
    public let supportedMessageTypes: [UInt8]   // TODO: This will become obsolete in L11

    public var identifier: AACommandIdentifier {
        return command.identifier
    }


    // MARK: Methods

    public func supports(_ messageTypes: [UInt8]) -> Bool {
        return Set(supportedMessageTypes).isSuperset(of: messageTypes)
    }

    public func supports<C>(_ messageTypes: C...) -> Bool where C: RawRepresentable & CaseIterable, C.RawValue == UInt8 {
        return supports(messageTypes.map { $0.rawValue })
    }

    public func supportsAllMessageTypes<M>(for command: M.Type) -> Bool where M: AAMessageTypesGettable {
        return supports(command.MessageTypes.allCases.map { $0.rawValue })
    }
}

extension AACapabilityValue: AABytesConvertable {

    public var bytes: [UInt8] {
        return identifier.bytes + supportedMessageTypes
    }


    public init?(bytes: [UInt8]) {
        guard bytes.count >= 2 else {
            return nil
        }

        guard let identifier = AACommandIdentifier(bytes: bytes.prefix(2)) else {
            return nil
        }

        guard let command = AAAutoAPI.capabilities.first(where: { $0.identifier == identifier }) else {
            return nil
        }

        self.command = command
        self.supportedMessageTypes = bytes[2...].bytes
    }
}

extension AACapabilityValue: Equatable {

    public static func ==(lhs: AACapabilityValue, rhs: AACapabilityValue) -> Bool {
        // If the command matches, the 'identifier' must be the same
        return (lhs.command == rhs.command) && (lhs.supportedMessageTypes == rhs.supportedMessageTypes)
    }
}
