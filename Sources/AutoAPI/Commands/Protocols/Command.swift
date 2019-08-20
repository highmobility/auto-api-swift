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
//  Command.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 14/12/2017.
//  Copyright © 2019 High Mobility. All rights reserved.
//

import Foundation
import HMUtilities


public protocol Command: Identifiable {

}

extension Command {

}


protocol CommandAggregate: Command, MessageTypesGettable {

}

extension CommandAggregate where Self.MessageTypes.RawValue == UInt8 {

    static func commandPrefix(for messageType: Self.MessageTypes) -> [UInt8] {
        return commandPrefix(for: messageType, additionalBytes: nil)
    }

    static func commandPrefix(for messageType: Self.MessageTypes, additionalBytes bytes: UInt8?...) -> [UInt8] {
        return Self.identifier.bytes + [messageType.rawValue] + bytes.compactMap { $0 }
    }
}
