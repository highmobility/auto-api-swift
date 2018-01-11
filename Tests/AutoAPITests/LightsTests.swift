//
// AutoAPITests
// Copyright (C) 2017 High-Mobility GmbH
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
//  LightsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 06/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
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

        let control = Lights.Control(frontExterior: .fullBeam, rearExterior: .deactivate, interior: .deactivate, ambientColour: Colour(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0))

        XCTAssertEqual(Lights.controlLights(control), bytes)
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x36, // MSB, LSB Message Identifier for Lights
            0x00        // Message Type for Get Lights State
        ]

        XCTAssertEqual(Lights.getState, bytes)
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
            0x00        // No blue ambient light
        ]

        guard let lights = AutoAPI.parseBinary(bytes) as? Lights else {
            return XCTFail("Parsed value is not Lights")
        }

        XCTAssertEqual(lights.frontExterior, .fullBeam)
        XCTAssertEqual(lights.rearExterior, .active)
        XCTAssertEqual(lights.interior, .inactive)
        XCTAssertEqual(lights.ambientColour, Colour(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0))
    }
}
