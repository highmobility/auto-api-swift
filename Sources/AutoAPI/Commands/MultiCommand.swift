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
//  MultiCommand.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 14/11/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation
import HMUtilities


public struct MultiCommand: OutboundCommand {

}

extension MultiCommand: Identifiable {

    public static var identifier: Identifier = 0x0013
}

extension MultiCommand: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case send = 0x02


        public static var all: [MultiCommand.MessageTypes] {
            return [self.send]
        }
    }
}

public extension MultiCommand {

    static func combined(_ commands: [UInt8]...) -> [UInt8] {
        return commandPrefix(for: .send) + commands.flatMap {
            /*
             Property:
                 ID
                 Size MSB
                 Size LSB
                 Value...
             */
            [0x01] + UInt16($0.count).bytes + $0
        }
    }
}
