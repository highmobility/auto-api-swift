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
//  DoorLocks.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 24/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


// TODO: Maybe this should be kept as a `Sequence` – then the Door should be combined from all properties...
public struct DoorLocks: FullStandardCommand {

    public let doors: [Door]?
    public let insideLocks: [DoorLock]?
    public let outsideLocks: [DoorLock]?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        doors = properties.flatMap(for: 0x01) { Door($0.value) }
        insideLocks = properties.flatMap(for: 0x02) { DoorLock($0.value) }
        outsideLocks = properties.flatMap(for: 0x03) { DoorLock($0.value) }

        // Properties
        self.properties = properties
    }
}

extension DoorLocks: Identifiable {

    public static var identifier: Identifier = Identifier(0x0020)
}

extension DoorLocks: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getLockState       = 0x00
        case lockState          = 0x01
        case lockUnlockDoors    = 0x02


        public static var all: [DoorLocks.MessageTypes] {
            return [self.getLockState,
                    self.lockState,
                    self.lockUnlockDoors]
        }
    }
}

public extension DoorLocks {

    static var getLockState: [UInt8] {
        return commandPrefix(for: .getLockState)
    }

    static var lockUnlock: (LockState) -> [UInt8] {
        return {
            return commandPrefix(for: .lockUnlockDoors, additionalBytes: $0.rawValue)
        }
    }
}
