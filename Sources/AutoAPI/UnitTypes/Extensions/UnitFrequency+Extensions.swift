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
//  UnitFrequency+Extensions.swift
//  AutoAPI
//
//  Generated by AutoAPIGenerator for Swift.
//  Copyright © 2021 High-Mobility GmbH. All rights reserved.
//

import Foundation


public extension UnitFrequency {

    public static let timesPerMinute = UnitFrequency(symbol: "hm_tpm", converter: UnitConverterLinear(coefficient: 60.0))

    public static let timesPerHour = UnitFrequency(symbol: "hm_tph", converter: UnitConverterLinear(coefficient: 3600.0))

    public static let timesPerDay = UnitFrequency(symbol: "hm_tpd", converter: UnitConverterLinear(coefficient: 86400.0))
}

extension UnitFrequency: AAUnitType {

    public static let measurementID: UInt8 = 0x0e

    public static func create(id: UInt8) -> Self? {
        switch id {
        case 0x00:  return UnitFrequency.hertz as? Self
        case 0x01:  return UnitFrequency.millihertz as? Self
        case 0x03:  return UnitFrequency.kilohertz as? Self
        case 0x04:  return UnitFrequency.megahertz as? Self
        case 0x05:  return UnitFrequency.gigahertz as? Self
        case 0x08:  return UnitFrequency.timesPerMinute as? Self
        case 0x09:  return UnitFrequency.timesPerHour as? Self
        case 0x0a:  return UnitFrequency.timesPerDay as? Self

        default:    return nil
        }
    }


    public var identifiers: [UInt8]? {
        switch self {
        case .hertz: return [Self.measurementID, 0x00]
        case .millihertz: return [Self.measurementID, 0x01]
        case .kilohertz: return [Self.measurementID, 0x03]
        case .megahertz: return [Self.measurementID, 0x04]
        case .gigahertz: return [Self.measurementID, 0x05]
        case .timesPerMinute: return [Self.measurementID, 0x08]
        case .timesPerHour: return [Self.measurementID, 0x09]
        case .timesPerDay: return [Self.measurementID, 0x0a]

        default: return nil
        }
    }
}