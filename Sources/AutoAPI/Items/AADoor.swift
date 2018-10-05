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
//  AADoor.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 29/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AADoor {

    public let location: AALocation
    public let lock: AALockState
    public let position: AAPositionState
}

extension AADoor: AAItem {

    static let size: Int = 3


    init?(bytes: [UInt8]) {
        guard let location = AALocation(rawValue: bytes[0]),
            let position = AAPositionState(rawValue: bytes[1]),
            let lock = AALockState(rawValue: bytes[2]) else {
                return nil
        }

        self.location = location
        self.lock = lock
        self.position = position
    }
}

extension AADoor: AAPropertyConvertable {

    var propertyValue: [UInt8] {
        return [location.rawValue, position.rawValue, location.rawValue]
    }
}

// TODO: Separate to 2 files and "full" structs
public extension AADoor {

    public struct Position: AAItem {

        public let location: AALocation
        public let position: AAPositionState


        // MARK: AAItem

        static let size: Int = 2


        init?(bytes: [UInt8]) {
            guard let location = AALocation(rawValue: bytes[0]),
                let position = AAPositionState(rawValue: bytes[1]) else {
                    return nil
            }

            self.location = location
            self.position = position
        }


        // MARK: AAPropertyConvertable

        var propertyValue: [UInt8] {
            return [location.rawValue, position.rawValue]
        }
    }

    public struct Lock: AAItem {

        public let location: AALocation
        public let lock: AALockState


        // MARK: AAItem

        static var size: Int = 2


        init?(bytes: [UInt8]) {
            guard let location = AALocation(rawValue: bytes[0]),
                let lock = AALockState(rawValue: bytes[1]) else {
                    return nil
            }

            self.location = location
            self.lock = lock
        }


        // MARK: AAPropertyConvertable

        var propertyValue: [UInt8] {
            return [location.rawValue, lock.rawValue]
        }
    }
}
