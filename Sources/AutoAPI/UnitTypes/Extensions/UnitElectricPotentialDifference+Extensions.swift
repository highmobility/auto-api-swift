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
//  UnitElectricPotentialDifference+Extensions.swift
//  AutoAPI
//
//  Generated by AutoAPIGenerator for Swift.
//  Copyright © 2021 High-Mobility GmbH. All rights reserved.
//

import Foundation


extension UnitElectricPotentialDifference: AAUnitType {

    public enum ElectricPotentialDifferenceUnit: String, Codable {
        case volts
        case millivolts
        case kilovolts
    }


    public static let measurementID: UInt8 = 0x0a


    public static func create(id: UInt8) -> Self? {
        switch id {
        case 0x00:  return UnitElectricPotentialDifference.volts as? Self
        case 0x01:  return UnitElectricPotentialDifference.millivolts as? Self
        case 0x02:  return UnitElectricPotentialDifference.kilovolts as? Self

        default:    return nil
        }
    }

    public static func create(unit: ElectricPotentialDifferenceUnit) -> UnitElectricPotentialDifference {
        switch unit {
        case .volts: return Self.volts
        case .millivolts: return Self.millivolts
        case .kilovolts: return Self.kilovolts
        }
    }


    public var identifiers: [UInt8]? {
        switch self {
        case .volts: return [Self.measurementID, 0x00]
        case .millivolts: return [Self.measurementID, 0x01]
        case .kilovolts: return [Self.measurementID, 0x02]

        default: return nil
        }
    }

    public var unit: ElectricPotentialDifferenceUnit? {
        switch self {
        case .volts: return .volts
        case .millivolts: return .millivolts
        case .kilovolts: return .kilovolts

        default: return nil
        }
    }
}
