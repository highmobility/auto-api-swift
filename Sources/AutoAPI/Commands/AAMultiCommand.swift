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
//  AAMultiCommand.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 14/11/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation
import HMUtilities


public struct AAMultiCommand: AAOutboundCommand {

}

extension AAMultiCommand: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0013
}

extension AAMultiCommand: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case send = 0x02
    }
}


// MARK: Commands

public extension AAMultiCommand {

    static func combined(_ commands: [UInt8]...) -> [UInt8] {
        let wrappedCommands = commands.map { AACommandWrapper(value: $0) }

        return commandPrefix(for: .send) + wrappedCommands.flatMap { $0.propertyBytes(0x01) }
    }
}
