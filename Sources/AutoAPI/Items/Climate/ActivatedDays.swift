//
//  The MIT License
//
//  Copyright (c) 2014- High-Mobility GmbH (https://high-mobility.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//
//  ActivatedDays.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/11/2017.
//

import Foundation


public struct ActivatedDays: OptionSet {

    public static let monday    = ActivatedDays(rawValue: 1 << 0)
    public static let tuesday   = ActivatedDays(rawValue: 1 << 1)
    public static let wednesday = ActivatedDays(rawValue: 1 << 2)
    public static let thursday  = ActivatedDays(rawValue: 1 << 3)
    public static let friday    = ActivatedDays(rawValue: 1 << 4)
    public static let saturday  = ActivatedDays(rawValue: 1 << 5)
    public static let sunday    = ActivatedDays(rawValue: 1 << 6)
    public static let automatic = ActivatedDays(rawValue: 1 << 7)


    // MARK: RawRepresentable

    public typealias RawValue = UInt8


    public var rawValue: UInt8


    // MARK: OptionSet

    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }
}

extension ActivatedDays: CustomStringConvertible {

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
