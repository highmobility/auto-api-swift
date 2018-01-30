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
//  WakeUp.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 29/11/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct WakeUp: OutboundCommand {

}

extension WakeUp: Identifiable {

    public static var identifier: Identifier = Identifier(0x0022)
}

extension WakeUp: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case wakeUp = 0x02


        public static var all: [WakeUp.MessageTypes] {
            return [self.wakeUp]
        }
    }
}

public extension WakeUp {

    static var wakeUp: [UInt8] {
        return commandPrefix(for: .wakeUp)
    }
}
