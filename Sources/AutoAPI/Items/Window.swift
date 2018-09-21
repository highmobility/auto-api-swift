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
//  Window.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 01/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct Window {

    public typealias OpenClosed = AAPositionState


    @available(*, deprecated, message: "Use the new struct Window.Position")
    public let position: Location

    @available(*, deprecated, message: "Use the new struct Window.Position")
    public let openClosed: OpenClosed


    // MARK: Init

    @available(*, deprecated, message: "Use the new struct Window.Position")
    public init(openClosed: OpenClosed, position: Location) {
        self.openClosed = openClosed
        self.position = position
    }
}

extension Window: AAItem {

    static let size: Int = 2


    init?(bytes: [UInt8]) {
        guard let location = Location(rawValue: bytes[0]),
            let openClosed = OpenClosed(rawValue: bytes[1]) else {
                return nil
        }

        self.openClosed = openClosed
        self.position = location
    }
}

public extension Window {

    public struct OpenPercentage: AAItem {

        public let location: Location
        public let percentage: AAPercentageInt


        // MARK: AAItem

        static var size: Int = 2


        init?(bytes: [UInt8]) {
            guard let location = Location(rawValue: bytes[0]) else {
                return nil
            }

            self.location = location
            self.percentage = bytes[1]
        }
    }

    public struct Position: AAItem {

        public let location: Location
        public let position: AAPositionState


        // MARK: AAItem

        static var size: Int = 2


        init?(bytes: [UInt8]) {
            guard let location = Location(rawValue: bytes[0]),
                let position = AAPositionState(rawValue: bytes[1]) else {
                    return nil
            }

            self.location = location
            self.position = position
        }
    }
}
