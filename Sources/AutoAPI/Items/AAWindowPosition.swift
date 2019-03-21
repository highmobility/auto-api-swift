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
//  AAWindowPosition.swift
//  AutoAPICLT
//
//  Created by Mikk Rätsep on 02/11/2018.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public struct AAWindowPosition {

    public let location: AALocation
    public let position: AAPositionState


    // MARK: Init

    public init(location: AALocation, position: AAPositionState) {
        self.location = location
        self.position = position
    }
}

extension AAWindowPosition: AABytesConvertable {

    public var bytes: [UInt8] {
        return location.bytes + position.bytes
    }


    public init?(bytes: [UInt8]) {
        guard bytes.count == 2 else {
            return nil
        }

        guard let location = AALocation(bytes: bytes[0..<1]),
            let position = AAPositionState(bytes: bytes[1..<2]) else {
                return nil
        }

        self.location = location
        self.position = position
    }
}