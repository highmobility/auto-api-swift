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
//  LightsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 06/12/2017.
//

import AutoAPI
import XCTest


class LightsTests: XCTestCase {

    static var allTests = [("testControlLights", testControlLights),
                           ("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testControlLights() {
        let bytes: [UInt8] = [
            0x00, 0x36, // MSB, LSB Message Identifier for Lights
            0x02,       // Message Type for Control Lights

            0x01,       // Property Identifier for Front exterior light
            0x00, 0x01, // Property size 1 byte
            0x02,       // Set exterior front lights to full beam

            0x02,       // Property Identifier for Rear exterior light
            0x00, 0x01, // Property size 1 byte
            0x00,       // Deactivate rear lights

            0x03,       // Property Identifier for Interior light
            0x00, 0x01, // Property size 1 byte
            0x00,       // Deacticate interior lights

            0x04,       // Property Identifier for Ambient light
            0x00, 0x03, // Property size 3 byte
            0xff,       // Full red ambient light
            0x00,       // No green ambient light
            0x00        // No blue ambient light
        ]

        let control = Lights.Control(frontExterior: .activeFullBeam, isRearExteriorActive: false, isInteriorActive: false, ambientColour: Colour(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0))

        XCTAssertEqual(Lights.controlLights(control), bytes)
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x36, // MSB, LSB Message Identifier for Lights
            0x00        // Message Type for Get Lights State
        ]

        XCTAssertEqual(Lights.getLightsState, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x36, // MSB, LSB Message Identifier for Lights
            0x01,       // Message Type for Lights State

            0x01,       // Property Identifier for Front exterior light
            0x00, 0x01, // Property size 1 byte
            0x02,       // Exterior front lights are on full beam

            0x02,       // Property Identifier for Rear exterior light
            0x00, 0x01, // Property size 1 byte
            0x01,       // Exterior rear lights are active

            0x03,       // Property Identifier for Interior light
            0x00, 0x01, // Property size 1 byte
            0x00,       // Interior lights are inactive

            0x04,       // Property Identifier for Ambient light
            0x00, 0x03, // Property size 1 byte
            0xff,       // Full red ambient light
            0x00,       // No green ambient light
            0x00,       // No blue ambient light

            0x05,       // Property identifier for Reverse light
            0x00, 0x01, // Property size is 1 bytes
            0x00,       // Reverse lights are inactive

            0x06,       // Property identifier for Emergency brake light
            0x00, 0x01, // Property size is 1 bytes
            0x00        // Emergency brake lights are inactive
        ]

        guard let lights = AAAutoAPI.parseBinary(bytes) as? Lights else {
            return XCTFail("Parsed value is not Lights")
        }

        XCTAssertEqual(lights.frontExterior, .activeFullBeam)
        XCTAssertEqual(lights.isRearExteriorActive, true)
        XCTAssertEqual(lights.isInteriorActive, false)
        XCTAssertEqual(lights.ambientColour, Colour(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0))
        XCTAssertEqual(lights.isReverseActive, false)
        XCTAssertEqual(lights.isEmergencyBrakeActive, false)
    }
}
