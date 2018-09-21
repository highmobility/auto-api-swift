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
//  AAActivatedDays.swift
//  AutoAPIm
//
//  Created by Mikk Rätsep on 30/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAActivatedDays: OptionSet {

    public static let monday    = AAActivatedDays(rawValue: 1 << 0)
    public static let tuesday   = AAActivatedDays(rawValue: 1 << 1)
    public static let wednesday = AAActivatedDays(rawValue: 1 << 2)
    public static let thursday  = AAActivatedDays(rawValue: 1 << 3)
    public static let friday    = AAActivatedDays(rawValue: 1 << 4)
    public static let saturday  = AAActivatedDays(rawValue: 1 << 5)
    public static let sunday    = AAActivatedDays(rawValue: 1 << 6)
    public static let automatic = AAActivatedDays(rawValue: 1 << 7)


    // MARK: RawRepresentable

    public typealias RawValue = UInt8


    public var rawValue: UInt8


    // MARK: OptionSet

    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }
}

extension AAActivatedDays: CustomStringConvertible {

    public var description: String {
        var values: [String] = []

        if contains(.monday)    { values.append(".monday") }
        if contains(.tuesday)   { values.append(".tuesday") }
        if contains(.wednesday) { values.append(".wednesday") }
        if contains(.thursday)  { values.append(".thursday") }
        if contains(.friday)    { values.append(".friday") }
        if contains(.saturday)  { values.append(".saturday") }
        if contains(.sunday)    { values.append(".sunday") }
        if contains(.automatic) { values.append(".automatic") }

        return "[" + values.joined(separator: ", ") + "]"
    }
}

extension AAActivatedDays: PropertyConvertable {

}
