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
//  AACruiseControlTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AACruiseControlTest: XCTestCase {

    // MARK: State Properties

    func testCruiseControl() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x62, 0x01, 0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACruiseControl else {
            return XCTFail("Could not parse bytes as AACruiseControl")
        }
    
        XCTAssertEqual(capability.cruiseControl?.value, .active)
    }

    func testAdaptiveCruiseControl() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x62, 0x01, 0x04, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACruiseControl else {
            return XCTFail("Could not parse bytes as AACruiseControl")
        }
    
        XCTAssertEqual(capability.adaptiveCruiseControl?.value, .inactive)
    }

    func testLimiter() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x62, 0x01, 0x02, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACruiseControl else {
            return XCTFail("Could not parse bytes as AACruiseControl")
        }
    
        XCTAssertEqual(capability.limiter?.value, .higherSpeedRequested)
    }

    func testTargetSpeed() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x62, 0x01, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x3d]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACruiseControl else {
            return XCTFail("Could not parse bytes as AACruiseControl")
        }
    
        XCTAssertEqual(capability.targetSpeed?.value, 61)
    }

    func testAccTargetSpeed() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x62, 0x01, 0x05, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x43]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACruiseControl else {
            return XCTFail("Could not parse bytes as AACruiseControl")
        }
    
        XCTAssertEqual(capability.accTargetSpeed?.value, 67)
    }

    
    // MARK: Getters

    func testGetCruiseControlState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x62, 0x00]
    
        XCTAssertEqual(bytes, AACruiseControl.getCruiseControlState())
    }
    
    func testGetCruiseControlProperties() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x62, 0x00, 0x05]
        let getterBytes = AACruiseControl.getCruiseControlProperties(propertyIDs: .accTargetSpeed)
    
        XCTAssertEqual(bytes, getterBytes)
    }

    
    // MARK: Setters

    func testActivateDeactivateCruiseControl() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x62, 0x01] + [0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x3d]
        let setterBytes = AACruiseControl.activateDeactivateCruiseControl(cruiseControl: .active, targetSpeed: 61)
    
        XCTAssertEqual(bytes, setterBytes)
    }
}