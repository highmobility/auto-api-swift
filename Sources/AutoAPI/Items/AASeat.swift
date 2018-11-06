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
//  AASeat.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 07/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AASeat {

    public let personDetected: Bool
    public let position: AASeatLocation
    public let seatbeltFastened: Bool
}

extension AASeat: AAItem {

    static var size: Int = 3


    init?(bytes: [UInt8]) {
        guard let position = AASeatLocation(rawValue: bytes[0]) else {
            return nil
        }

        self.personDetected = bytes[1].bool
        self.position = position
        self.seatbeltFastened = bytes[2].bool
    }
}

extension AASeat: AAPropertyConvertable {

    var propertyValue: [UInt8] {
        return [position.rawValue, personDetected.byte, seatbeltFastened.byte]
    }
}
