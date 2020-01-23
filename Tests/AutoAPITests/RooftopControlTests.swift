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
//  RooftopControlTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 01/12/2017.
//

import AutoAPI
import XCTest


class RooftopControlTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testControlRooftop", testControlRooftop),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x25, // MSB, LSB Message Identifier for Rooftop Control
            0x00        // Message Type for Get Rooftop State
        ]

        XCTAssertEqual(RooftopControl.getRooftopState, bytes)
    }

    func testControlRooftop() {
        let bytes: [UInt8] = [
            0x00, 0x25, // MSB, LSB Message Identifier for Rooftop Control
            0x02,       // Message Type for Control Rooftop

            0x01,       // Property Identifier for Dimming
            0x00, 0x01, // Property size 1 byte
            0x00,       // Make rooftop transparent

            0x02,       // Property Identifier for Position
            0x00, 0x01, // Property size 1 byte
            0x00        // Close Rooftop
        ]

        let control = RooftopControl.Control(dimming: 0, openClose: 0)

        XCTAssertEqual(RooftopControl.controlRooftop(control), bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x25, // MSB, LSB Message Identifier for Rooftop Control
            0x01,       // Message Type for Rooftop State

            0x01,       // Property Identifier for Dimming
            0x00, 0x01, // Property size 1 byte
            0x64,       // Rooftop is opaque

            0x02,       // Property Identifier for Position
            0x00, 0x01, // Property size 1 byte
            0x00        // Rooftop is fully closed
        ]

        guard let rooftopControl = AutoAPI.parseBinary(bytes) as? RooftopControl else {
            return XCTFail("Parsed value is not RooftopControl")
        }

        XCTAssertEqual(rooftopControl.dimming, 100)
        XCTAssertEqual(rooftopControl.position, 0)
    }
}
