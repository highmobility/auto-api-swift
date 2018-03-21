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
//  Seat.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 07/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct Seat: Item {

    public let personDetected: Bool
    public let position: SeatPosition
    public let seatbeltFastened: Bool


    // MARK: Item

    static var size: Int = 3
}

extension Seat: BinaryInitable {

    init?(bytes: [UInt8]) {
        guard let position = SeatPosition(rawValue: bytes[0]) else {
            return nil
        }

        self.personDetected = bytes[1].bool
        self.position = position
        self.seatbeltFastened = bytes[2].bool
    }
}
