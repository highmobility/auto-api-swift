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
//  Windows.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 01/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct Windows: FullStandardCommand, Sequence {

    public let windows: [Window]?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        windows = properties.flatMap(for: 0x01) { Window($0.value) }

        // Properties
        self.properties = properties
    }


    // MARK: Sequence

    public typealias Iterator = WindowsIterator


    public func makeIterator() -> WindowsIterator {
        return WindowsIterator(properties.filter(for: 0x01).flatMap { $0.bytes })
    }
}

extension Windows: Identifiable {

    public static var identifier: Identifier = Identifier(0x0045)
}

extension Windows: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getWindowsState    = 0x00
        case windowsState       = 0x01
        case openCloseWindows   = 0x02


        public static var all: [Windows.MessageTypes] {
            return [self.getWindowsState,
                    self.windowsState,
                    self.openCloseWindows]
        }
    }
}

public extension Windows {

    static var getWindowsState: [UInt8] {
        return commandPrefix(for: .getWindowsState)
    }

    static var openClose: ([Window]) -> [UInt8] {
        return {
            return commandPrefix(for: .openCloseWindows) + $0.flatMap { $0.propertyBytes(0x01) }
        }
    }
}
