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
//  Graphics.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct Graphics: OutboundCommand {

}

extension Graphics: Identifiable {

    public static var identifier: Identifier = Identifier(0x0051)
}

extension Graphics: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case displayImage   = 0x00


        public static var all: [Graphics.MessageTypes] {
            return [self.displayImage]
        }
    }
}

public extension Graphics {

    static var displayImage: (URL) -> [UInt8] {
        return {
            return commandPrefix(for: .displayImage) + $0.propertyBytes(0x01)
        }
    }
}
