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
//  CruiseControlTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 24/04/2018.
//

import AutoAPI
import XCTest


class CruiseControlTests: XCTestCase {
    
    static var allTests = [("testControl", testControl),
                           ("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testControl() {
        let bytes: [UInt8] = [
            0x00, 0x62, // MSB, LSB Message Identifier for Cruise Control
            0x02,       // Message Type for Control Cruise Control

            0x01,       // Property Identifier for Cruise control
            0x00, 0x01, // Property size 1 byte
            0x01,       // Activate cruise control

            0x02,       // Property Identifier for Target speed
            0x00, 0x02, // Property size 2 byte
            0x00, 0x3C  // Set target speed to 60 km/h
        ]

        let control = CruiseControl.Control(isActive: true, targetSpeed: 60)

        XCTAssertEqual(CruiseControl.activateCruiseControl(control), bytes)
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x62, // MSB, LSB Message Identifier for Cruise Control
            0x00        // Message Type for Get Cruise Control State
        ]

        XCTAssertEqual(CruiseControl.getCruiseControlState, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x62, // MSB, LSB Message Identifier for Cruise Control
            0x01,       // Message Type for Cruise Control State

            0x01,       // Property identifier for Cruise control
            0x00, 0x01, // Property size is 1 bytes
            0x01,       // Cruise control is active

            0x02,       // Property identifier for Limiter
            0x00, 0x01, // Property size is 1 bytes
            0x01,       // Higher speed requested by the limiter

            0x03,       // Property identifier for Target speed
            0x00, 0x02, // Property size is 2 bytes
            0x00, 0x3C, // The target speed is set to 60km/h

            0x04,       // Property identifier for Acc
            0x00, 0x01, // Property size is 1 bytes
            0x00,       // Adaptive Cruise Control is inactive

            0x05,       // Property identifier for Acc target speed
            0x00, 0x02, // Property size is 2 bytes
            0x00, 0x3C  // The Adaptive Cruise Control target speed is set to 60km/h
        ]

        guard let cruiseControl = AAAutoAPI.parseBinary(bytes) as? CruiseControl else {
            return XCTFail("Parsed value is not CruiseControl")
        }

        XCTAssertEqual(cruiseControl.isActive, true)
        XCTAssertEqual(cruiseControl.limiter, .higherSpeedRequested)
        XCTAssertEqual(cruiseControl.targetSpeed, 60)
        XCTAssertEqual(cruiseControl.isAdaptiveActive, false)
        XCTAssertEqual(cruiseControl.adaptiveTargetSpeed, 60)
    }
}
