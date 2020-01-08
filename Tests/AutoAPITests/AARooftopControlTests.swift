//
// AutoAPI
// Copyright (C) 2020 High-Mobility GmbH
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
//  AARooftopControlTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AARooftopControlTest: XCTestCase {

    // MARK: State Properties

    func testConvertibleRoofState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x25, 0x01, 0x03, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARooftopControl else {
            return XCTFail("Could not parse bytes as AARooftopControl")
        }
    
        XCTAssertEqual(capability.convertibleRoofState?.value, .open)
    }

    func testSunroofTiltState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x25, 0x01, 0x04, 0x00, 0x04, 0x01, 0x00, 0x01, 0x02]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARooftopControl else {
            return XCTFail("Could not parse bytes as AARooftopControl")
        }
    
        XCTAssertEqual(capability.sunroofTiltState?.value, .halfTilted)
    }

    func testSunroofState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x25, 0x01, 0x05, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARooftopControl else {
            return XCTFail("Could not parse bytes as AARooftopControl")
        }
    
        XCTAssertEqual(capability.sunroofState?.value, .open)
    }

    func testPosition() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x25, 0x01, 0x02, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x3f, 0xe0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARooftopControl else {
            return XCTFail("Could not parse bytes as AARooftopControl")
        }
    
        XCTAssertEqual(capability.position?.value, 0.5)
    }

    func testDimming() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x25, 0x01, 0x01, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x3f, 0xf0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARooftopControl else {
            return XCTFail("Could not parse bytes as AARooftopControl")
        }
    
        XCTAssertEqual(capability.dimming?.value, 1.0)
    }

    
    // MARK: Getters

    func testGetRooftopState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x25, 0x00]
    
        XCTAssertEqual(bytes, AARooftopControl.getRooftopState())
    }
    
    func testGetRooftopStateProperties() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x25, 0x00, 0x05]
        let getterBytes = AARooftopControl.getRooftopStateProperties(propertyIDs: .sunroofState)
    
        XCTAssertEqual(bytes, getterBytes)
    }

    
    // MARK: Setters

    func testControlRooftop() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x25, 0x01] + [0x01, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x3f, 0xf0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x3f, 0xe0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01, 0x04, 0x00, 0x04, 0x01, 0x00, 0x01, 0x02, 0x05, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
        let setterBytes = AARooftopControl.controlRooftop(dimming: 1.0, position: 0.5, convertibleRoofState: .open, sunroofTiltState: .halfTilted, sunroofState: .open)
    
        XCTAssertEqual(bytes, setterBytes)
    }
}