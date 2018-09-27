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
//  AAWheelRPM.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 27/09/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAWheelRPM {

    public let location: AALocation
    public let rpm: UInt16
}

extension AAWheelRPM: AAItem {

    static var size: Int = 3


    init?(bytes: [UInt8]) {
        guard let location = AALocation(rawValue: bytes[0]) else {
            return nil
        }

        self.location = location
        self.rpm = UInt16(bytes.dropFirst())
    }
}
