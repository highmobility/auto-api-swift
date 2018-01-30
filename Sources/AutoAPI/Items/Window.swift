//
// AutoAPI
// Copyright (C) 2017 High-Mobility GmbH
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
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct Window: Item {

    public typealias OpenClosed = PositionState


    public let openClosed: OpenClosed
    public let position: Position


    // MARK: Item

    static let size: Int = 2


    // MARK: Init

    public init(openClosed: OpenClosed, position: Position) {
        self.openClosed = openClosed
        self.position = position
    }
}

extension Window: BinaryInitable {

    init?(bytes: [UInt8]) {
        guard let position = Position(rawValue: bytes[0]),
            let openClosed = OpenClosed(rawValue: bytes[1]) else {
                return nil
        }

        self.openClosed = openClosed
        self.position = position
    }
}

extension Window: Equatable {

    public static func ==(lhs: Window, rhs: Window) -> Bool {
        return (lhs.openClosed == rhs.openClosed) && (lhs.position == rhs.position)
    }
}

extension Window: PropertyConvertable {

    var propertyValue: [UInt8] {
        return [position.rawValue, openClosed.rawValue]
    }
}
