//
// AutoAPI
// Copyright (C) 2019 High-Mobility GmbH
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
//  DoorLock.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/04/2018.
//  Copyright © 2019 High Mobility. All rights reserved.
//

import Foundation


public struct DoorLock: Item {

    public typealias Location = Position


    public let location: Location
    public let lock: LockState  // TODO: I would prefer `public let isLocked: Bool`


    // MARK: Item

    static var size: Int = 2
}

extension DoorLock: BinaryInitable {

    init?(bytes: [UInt8]) {
        guard let location = Location(rawValue: bytes[0]),
            let lock = LockState(rawValue: bytes[1]) else {
                return nil
        }

        self.location = location
        self.lock = lock
    }
}
