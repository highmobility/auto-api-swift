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
//  AADoorLocks.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 24/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AADoorLocks: AAFullStandardCommand {

    public let insideLocks: [AADoor.Lock]?
    public let locks: [AADoor.Lock]?
    public let positions: [AADoor.Position]?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        /* Level 8 */
        insideLocks = properties.flatMap(for: 0x02) { AADoor.Lock($0.value) }
        locks = properties.flatMap(for: 0x03) { AADoor.Lock($0.value) }
        positions = properties.flatMap(for: 0x04) { AADoor.Position($0.value) }

        // Properties
        self.properties = properties
    }
}

extension AADoorLocks: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0020
}

extension AADoorLocks: AALegacyGettable {

    public struct Legacy: AALegacyType {

        public let doors: [AADoor]?


        // MARK: AALegacyType

        public enum MessageTypes: UInt8, CaseIterable {

            case getLockState       = 0x00
            case lockState          = 0x01
            case lockUnlockDoors    = 0x02
        }


        public init(properties: AAProperties) {
            doors = properties.flatMap(for: 0x01) { AADoor($0.value) }
        }
    }
}

extension AADoorLocks: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getLocksState  = 0x00
        case locksState     = 0x01
        case lockUnlock     = 0x12
    }
}


// MARK: Commands

public extension AADoorLocks {

    static var getLocksState: [UInt8] {
        return commandPrefix(for: .getLocksState)
    }


    static func lockUnlock(_ state: AALockState) -> [UInt8] {
        return commandPrefix(for: .lockUnlock) + state.propertyBytes(0x01)
    }
}

public extension AADoorLocks.Legacy {

    static var getLockState: [UInt8] {
        return commandPrefix(for: AADoorLocks.self, messageType: .getLockState)
    }

    static var lockUnlock: (AALockState) -> [UInt8] {
        return {
            return commandPrefix(for: AADoorLocks.self, messageType: .lockUnlockDoors, additionalBytes: $0.rawValue)
        }
    }
}
