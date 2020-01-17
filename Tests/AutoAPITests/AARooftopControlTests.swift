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
//  AARooftopControlTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AARooftopControlTest: XCTestCase {

    // MARK: State Properties

    func testPosition() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x25, 0x01, 0x02, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x3f, 0xe0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARooftopControl else {
            return XCTFail("Could not parse bytes as AARooftopControl")
        }
    
        XCTAssertEqual(capability.position?.value, 0.5)
    }

    func testSunroofState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x25, 0x01, 0x05, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARooftopControl else {
            return XCTFail("Could not parse bytes as AARooftopControl")
        }
    
        XCTAssertEqual(capability.sunroofState?.value, .open)
    }

    func testDimming() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x25, 0x01, 0x01, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x3f, 0xf0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARooftopControl else {
            return XCTFail("Could not parse bytes as AARooftopControl")
        }
    
        XCTAssertEqual(capability.dimming?.value, 1.0)
    }

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