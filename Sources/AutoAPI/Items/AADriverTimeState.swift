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
//  AADriverTimeState.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/04/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AADriverTimeState: Equatable {

    public let driverNumber: UInt8
    public let state: AATimeState
}

extension AADriverTimeState: AABytesConvertable {

    public var bytes: [UInt8] {
        return driverNumber.bytes + state.bytes
    }


    public init?(bytes: [UInt8]) {
        guard bytes.count == 2 else {
            return nil
        }

        guard let state = AATimeState(bytes: bytes[1..<2]) else {
            return nil
        }

        self.driverNumber = bytes[0]
        self.state = state
    }
}
