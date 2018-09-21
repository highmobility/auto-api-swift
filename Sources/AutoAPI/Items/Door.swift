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
//  Door.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 29/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct Door {

    @available(*, deprecated, message: "Use the new struct Door.Lock or Door.Position")
    public let location: Location

    @available(*, deprecated, message: "Use the new struct Door.Lock")
    public let lock: LockState

    @available(*, deprecated, message: "Use the new struct Door.Position")
    public let position: AAPositionState
}

extension Door: AAItem {

    static let size: Int = 3


    init?(bytes: [UInt8]) {
        guard let location = Location(rawValue: bytes[0]),
            let position = AAPositionState(rawValue: bytes[1]),
            let lock = LockState(rawValue: bytes[2]) else {
                return nil
        }

        self.location = location
        self.lock = lock
        self.position = position
    }
}

public extension Door {

    public struct Position: AAItem {

        public let location: Location
        public let position: AAPositionState


        // MARK: AAItem

        static let size: Int = 2


        init?(bytes: [UInt8]) {
            guard let location = Location(rawValue: bytes[0]),
                let position = AAPositionState(rawValue: bytes[1]) else {
                    return nil
            }

            self.location = location
            self.position = position
        }
    }

    public struct Lock: AAItem {

        public let location: Location
        public let lock: LockState


        // MARK: AAItem

        static var size: Int = 2


        init?(bytes: [UInt8]) {
            guard let location = Location(rawValue: bytes[0]),
                let lock = LockState(rawValue: bytes[1]) else {
                    return nil
            }

            self.location = location
            self.lock = lock
        }
    }
}
