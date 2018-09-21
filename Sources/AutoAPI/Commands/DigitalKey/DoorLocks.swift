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


public struct DoorLocks: AAFullStandardCommand {

    public let insideLocks: [Door.Lock]?
    public let locks: [Door.Lock]?
    public let positions: [Door.Position]?


    @available(*, deprecated, message: "Use the new .locks or .positions iVars")
    public let doors: [Door]?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        doors = properties.flatMap(for: 0x01) { Door($0.value) }    // Deprecated
        
        insideLocks = properties.flatMap(for: 0x02) { Door.Lock($0.value) }
        locks = properties.flatMap(for: 0x03) { Door.Lock($0.value) }
        positions = properties.flatMap(for: 0x04) { Door.Position($0.value) }

        // Properties
        self.properties = properties
    }
}

extension DoorLocks: AAIdentifiable {

    public static var identifier: AACommandIdentifier = AACommandIdentifier(0x0020)
}

extension DoorLocks: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getLockState       = 0x00
        case lockState          = 0x01
        case lockUnlockDoors    = 0x02
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
