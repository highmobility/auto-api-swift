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
//  UnitVolume+Extensions.swift
//  AutoAPI
//
//  Generated by AutoAPIGenerator for Swift.
//  Copyright © 2021 High-Mobility GmbH. All rights reserved.
//

import Foundation


extension UnitVolume: AAUnitType {

    public static let measurementID: UInt8 = 0x19


    public static func create(id: UInt8) -> Self? {
        switch id {
        case 0x02:  return UnitVolume.liters as? Self
        case 0x03:  return UnitVolume.milliliters as? Self
        case 0x04:  return UnitVolume.centiliters as? Self
        case 0x05:  return UnitVolume.deciliters as? Self
        case 0x0a:  return UnitVolume.cubicMillimeters as? Self
        case 0x09:  return UnitVolume.cubicCentimeters as? Self
        case 0x08:  return UnitVolume.cubicDecimeters as? Self
        case 0x07:  return UnitVolume.cubicMeters as? Self
        case 0x0b:  return UnitVolume.cubicInches as? Self
        case 0x0c:  return UnitVolume.cubicFeet as? Self
        case 0x13:  return UnitVolume.fluidOunces as? Self
        case 0x17:  return UnitVolume.gallons as? Self
        case 0x1a:  return UnitVolume.imperialFluidOunces as? Self
        case 0x1d:  return UnitVolume.imperialGallons as? Self

        default:    return nil
        }
    }

    public static func create(name: String) -> Self? {
        switch name {
        case "liters": return Self.liters as? Self
        case "milliliters": return Self.milliliters as? Self
        case "centiliters": return Self.centiliters as? Self
        case "deciliters": return Self.deciliters as? Self
        case "cubicMillimeters": return Self.cubicMillimeters as? Self
        case "cubicCentimeters": return Self.cubicCentimeters as? Self
        case "cubicDecimeters": return Self.cubicDecimeters as? Self
        case "cubicMeters": return Self.cubicMeters as? Self
        case "cubicInches": return Self.cubicInches as? Self
        case "cubicFeet": return Self.cubicFeet as? Self
        case "fluidOunces": return Self.fluidOunces as? Self
        case "gallons": return Self.gallons as? Self
        case "imperialFluidOunces": return Self.imperialFluidOunces as? Self
        case "imperialGallons": return Self.imperialGallons as? Self

        default: return nil
        }
    }


    public var identifiers: [UInt8]? {
        switch self {
        case .liters: return [Self.measurementID, 0x02]
        case .milliliters: return [Self.measurementID, 0x03]
        case .centiliters: return [Self.measurementID, 0x04]
        case .deciliters: return [Self.measurementID, 0x05]
        case .cubicMillimeters: return [Self.measurementID, 0x0a]
        case .cubicCentimeters: return [Self.measurementID, 0x09]
        case .cubicDecimeters: return [Self.measurementID, 0x08]
        case .cubicMeters: return [Self.measurementID, 0x07]
        case .cubicInches: return [Self.measurementID, 0x0b]
        case .cubicFeet: return [Self.measurementID, 0x0c]
        case .fluidOunces: return [Self.measurementID, 0x13]
        case .gallons: return [Self.measurementID, 0x17]
        case .imperialFluidOunces: return [Self.measurementID, 0x1a]
        case .imperialGallons: return [Self.measurementID, 0x1d]

        default: return nil
        }
    }

    public var name: String? {
        switch self {
        case .liters: return "liters"
        case .milliliters: return "milliliters"
        case .centiliters: return "centiliters"
        case .deciliters: return "deciliters"
        case .cubicMillimeters: return "cubicMillimeters"
        case .cubicCentimeters: return "cubicCentimeters"
        case .cubicDecimeters: return "cubicDecimeters"
        case .cubicMeters: return "cubicMeters"
        case .cubicInches: return "cubicInches"
        case .cubicFeet: return "cubicFeet"
        case .fluidOunces: return "fluidOunces"
        case .gallons: return "gallons"
        case .imperialFluidOunces: return "imperialFluidOunces"
        case .imperialGallons: return "imperialGallons"

        default: return nil
        }
    }
}
