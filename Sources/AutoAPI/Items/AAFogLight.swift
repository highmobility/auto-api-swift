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
//  AAFogLight.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 14/12/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAFogLight {

    public let location: AALightLocation
    public let state: AAActiveState


    // MARK: Init

    init(location: AALightLocation, state: AAActiveState) {
        self.location = location
        self.state = state
    }
}

extension AAFogLight: AABytesConvertable {

    public var bytes: [UInt8] {
        return location.bytes + state.bytes
    }


    public init?(bytes: [UInt8]) {
        guard bytes.count == 2 else {
            return nil
        }

        guard let location = AALightLocation(bytes: bytes[0..<1]),
            let state = AAActiveState(bytes: bytes[1..<2]) else {
                return nil
        }

        self.init(location: location, state: state)
    }
}
