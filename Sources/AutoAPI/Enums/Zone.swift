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
//  Zone.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 05/12/2017.
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

extension Zone: PropertyConvertable {
    
}
