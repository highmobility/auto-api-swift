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
//  UnitAcceleration+Extensions.swift
//  AutoAPI
//
//  Generated by AutoAPIGenerator for Swift.
//  Copyright © 2021 High-Mobility GmbH. All rights reserved.
//

import Foundation


extension UnitAcceleration: AAUnitType {

    public static let measurementID: UInt8 = 0x01

    public static func create(id: UInt8) -> Self? {
        switch id {
        case 0x00:  return UnitAcceleration.metersPerSecondSquared as? Self
        case 0x01:  return UnitAcceleration.gravity as? Self

        default:    return nil
        }
    }

    public static func create(name: String) -> Self? {
        switch name {
        case "metersPerSecondSquared": return Self.metersPerSecondSquared as? Self
        case "gravity": return Self.gravity as? Self

        default: return nil
        }
    }


    public var identifiers: [UInt8]? {
        switch self {
        case .metersPerSecondSquared: return [Self.measurementID, 0x00]
        case .gravity: return [Self.measurementID, 0x01]

        default: return nil
        }
    }

    public var name: String? {
        switch self {
        case .metersPerSecondSquared: return "metersPerSecondSquared"
        case .gravity: return "gravity"

        default: return nil
        }
    }
}
