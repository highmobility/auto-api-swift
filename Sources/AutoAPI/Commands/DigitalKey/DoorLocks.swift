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
//  DoorLocks.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 24/11/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct DoorLocks: FullStandardCommand, Sequence {

    public let doors: [Door]?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        doors = properties.flatMap(for: 0x01) { Door($0.value) }

        // Properties
        self.properties = properties
    }


    // MARK: Sequence

    public typealias Iterator = DoorsIterator


    public func makeIterator() -> DoorsIterator {
        return DoorsIterator(properties.filter(for: 0x01).flatMap { $0.value })
    }
}

extension DoorLocks: Identifiable {

    public static var identifier: Identifier = Identifier(0x0020)
}

extension DoorLocks: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesType {

        case getLockState       = 0x00
        case lockState          = 0x01
        case lockUnlockDoors    = 0x02


        public static let getState = MessageTypes.getLockState
        public static let state = MessageTypes.lockState

        public static var all: [UInt8] {
            return [self.getLockState.rawValue,
                    self.lockState.rawValue,
                    self.lockUnlockDoors.rawValue]
        }
    }
}

public extension DoorLocks {

    static var getLockState: [UInt8] {
        return getState
    }

    static var lockUnlock: (LockState) -> [UInt8] {
        return {
            return DoorLocks.identifier.bytes + [MessageTypes.lockUnlockDoors.rawValue, $0.rawValue]
        }
    }
}
