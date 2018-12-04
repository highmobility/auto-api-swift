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
//  AAReadingLamp.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 04/12/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAReadingLamp {

    public let location: AALocation
    public let state: AAActiveState


    // MARK: Init

    public init(location: AALocation, state: AAActiveState) {
        self.location = location
        self.state = state
    }
}

extension AAReadingLamp: AAItem {

    static var size: Int = 2


    init?(bytes: [UInt8]) {
        guard let location = AALocation(rawValue: bytes[0]),
            let state = AAActiveState(rawValue: bytes[1]) else {
                return nil
        }

        self.location = location
        self.state = state
    }
}

extension AAReadingLamp: AAPropertyConvertable {

    var propertyValue: [UInt8] {
        return [location.rawValue, state.rawValue]
    }
}
