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
//  AAWindow.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 01/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAWindow {

    public typealias AAOpenClosed = AAPositionState


    public let position: AALocation
    public let openClosed: AAOpenClosed


    // MARK: Init

    public init(openClosed: AAOpenClosed, position: AALocation) {
        self.openClosed = openClosed
        self.position = position
    }
}

extension AAWindow: AAItem {

    static let size: Int = 2


    init?(bytes: [UInt8]) {
        guard let location = AALocation(rawValue: bytes[0]),
            let openClosed = AAOpenClosed(rawValue: bytes[1]) else {
                return nil
        }

        self.openClosed = openClosed
        self.position = location
    }
}

extension AAWindow: AAPropertyConvertable {

    var propertyValue: [UInt8] {
        return [position.rawValue, openClosed.rawValue]
    }
}


public extension AAWindow {

    public struct OpenPercentage: AAItem, AAPropertyConvertable {

        public let location: AALocation
        public let percentage: AAPercentageInt


        // MARK: AAItem

        static var size: Int = 2


        init?(bytes: [UInt8]) {
            guard let location = AALocation(rawValue: bytes[0]) else {
                return nil
            }

            self.location = location
            self.percentage = bytes[1]
        }


        // MARK: AAPropertyConvertable

        var propertyValue: [UInt8] {
            return [location.rawValue, percentage]
        }


        // MARK: Init

        public init(location: AALocation, percentage: AAPercentageInt) {
            self.location = location
            self.percentage = percentage
        }
    }

    public struct Position: AAItem, AAPropertyConvertable {

        public let location: AALocation
        public let position: AAPositionState


        // MARK: AAItem

        static var size: Int = 2


        init?(bytes: [UInt8]) {
            guard let location = AALocation(rawValue: bytes[0]),
                let position = AAPositionState(rawValue: bytes[1]) else {
                    return nil
            }

            self.location = location
            self.position = position
        }


        // MARK: AAPropertyConvertable

        var propertyValue: [UInt8] {
            return [location.rawValue, position.rawValue]
        }


        // MARK: Init

        public init(location: AALocation, position: AAPositionState) {
            self.location = location
            self.position = position
        }
    }
}
