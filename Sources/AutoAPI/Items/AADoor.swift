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

extension AADoor: AABytesConvertable {

    public var bytes: [UInt8] {
        return location.bytes + position.bytes + location.bytes
    }


    public init?(bytes: [UInt8]) {
        guard bytes.count == 3 else {
            return nil
        }

        guard let location = AALocation(bytes: bytes[0..<1]),
            let position = AAPositionState(bytes: bytes[1..<2]),
            let lock = AALockState(bytes: bytes[2..<3]) else {
                return nil
        }

        self.location = location
        self.lock = lock
        self.position = position
    }
}
