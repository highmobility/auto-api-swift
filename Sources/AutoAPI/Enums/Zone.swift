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
//  Zone.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 05/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public enum Zone: RawRepresentable {

    case unavailable
    case matrix(UInt8)


    // MARK: Type Vars

    public static let unknown = Zone.unavailable


    // MARK: Vars

    public var horisontal: UInt8 {
        switch self {
        case .unavailable:          return 0
        case .matrix(let value):   return (value & 0xF0) >> 4
        }
    }

    public var vertical: UInt8 {
        switch self {
        case .unavailable:          return 0
        case .matrix(let value):    return (value & 0x0F) >> 0
        }
    }


    // MARK: RawRepresentable

    public typealias RawValue = UInt8


    public var rawValue: UInt8 {
        switch self {
        case .unavailable:          return 0x00
        case .matrix(let value):    return value
        }
    }


    public init?(rawValue: UInt8) {
        if rawValue == 0x00 {
            self = .unavailable
        }
        else {
            self = .matrix(rawValue)
        }
    }


    // MARK: Init

    public init(horisontal: UInt8, vertical: UInt8) {
        let value = ((horisontal & 0x0F) << 4) + (vertical & 0x0F)

        if value == 0x00 {
            self = .unavailable
        }
        else {
            self = .matrix(value)
        }
    }
}

extension Zone: CustomStringConvertible {

    public var description: String {
        if case .matrix(let value) = self {
            return String(format: "%1X", ((value & 0xF0) >> 4)) + "x" + String(format: "%1X", (value & 0x0F))
        }
        else {
            return "unavailable"
        }
    }
}

extension Zone: AAPropertyConvertable {
    
}
