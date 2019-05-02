//
// AutoAPITests
// Copyright (C) 2019 High-Mobility GmbH
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
//  AALightsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 06/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AALightsTests: XCTestCase {

    static var allTests = [("testControlLights", testControlLights),
                           ("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testControlLights() {
        let bytes1: [UInt8] = [
            0x00, 0x36, // MSB, LSB Message Identifier for Lights
            0x12,       // Message Type for Control Lights

            0x01,       // Property Identifier for Front exterior light
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x02,       // Set exterior front lights to full beam

            0x02,       // Property Identifier for Rear exterior light
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x00,       // Deactivate rear lights

            0x04,       // Property Identifier for Ambient light
            0x00, 0x06, // Property size is 6 bytes
            0x01,       // Data component identifier
            0x00, 0x03, // Data component size is 3 bytes
            0xff,       // Full red ambient light
            0x00,       // No green ambient light
            0x00,       // No blue ambient light
        ]

        let bytes2: [UInt8] = [
            0x00, 0x36, // MSB, LSB Message Identifier for Lights
            0x12,       // Message Type for Control Lights

            0x07,       // Property Identifier for Fog lights
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x00,       // Front fog lights
            0x00,       // Deactivate

            0x07,       // Property Identifier for Fog lights
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x01,       // Rear fog lights
            0x00        // Deactivate
        ]

        let bytes3: [UInt8] = [
            0x00, 0x36, // MSB, LSB Message Identifier for Lights
            0x12,       // Message Type for Control Lights

            0x08,       // Property Identifier for Reading lamps
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x01,       // Front right reading lamp
            0x01,       // Activate

            0x08,       // Property Identifier for Reading lamps
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x00,       // Front left reading lamp
            0x01        // Activate
        ]

        let bytes4: [UInt8] = [
            0x00, 0x36, // MSB, LSB Message Identifier for Lights
            0x12,       // Message Type for Control Lights

            0x09,       // Property Identifier for Interior lights
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x00,       // Front interior light
            0x00,       // Deactivate

            0x09,       // Property Identifier for Interior lights
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x01,       // Rear interior light
            0x00        // Deactivate
        ]

        let colour = AAColour(red: 1.0, green: 0.0, blue: 0.0)
        let fogLight1 = AAFogLight(location: .front, state: .inactive)
        let fogLight2 = AAFogLight(location: .rear, state: .inactive)
        let readingLamp1 = AAReadingLamp(location: .frontRight, state: .active)
        let readingLamp2 = AAReadingLamp(location: .frontLeft, state: .active)
        let interiorLamp1 = AAInteriorLamp(location: .front, state: .inactive)
        let interiorLamp2 = AAInteriorLamp(location: .rear, state: .inactive)

        XCTAssertEqual(AALights.controlLights(frontExterior: .activeFullBeam, rearExterior: .inactive, ambientColour: colour)?.bytes, bytes1)
        XCTAssertEqual(AALights.controlLights(fogLights: [fogLight1, fogLight2])?.bytes, bytes2)
        XCTAssertEqual(AALights.controlLights(readingLamps: [readingLamp1, readingLamp2])?.bytes, bytes3)
        XCTAssertEqual(AALights.controlLights(interiorLamps: [interiorLamp1, interiorLamp2])?.bytes, bytes4)

        XCTAssertNil(AALights.controlLights(), "Control Lights needs at least 1 input")
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x36, // MSB, LSB Message Identifier for Lights
            0x00        // Message Type for Get Lights State
        ]

        XCTAssertEqual(AALights.getLightsState.bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x36, // MSB, LSB Message Identifier for Lights
            0x01,       // Message Type for Lights State

            0x01,       // Property identifier for Front exterior light
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x02,       // Exterior front lights are on full beam

            0x02,       // Property identifier for Rear exterior light
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // Exterior rear lights are active

            0x04,       // Property identifier for Ambient light
            0x00, 0x06, // Property size is 6 bytes
            0x01,       // Data component identifier
            0x00, 0x03, // Data component size is 3 bytes
            0xFF,       // Full red ambient light
            0x00,       // No green ambient light
            0x00,       // No blue ambient light

            0x05,       // Property identifier for Reverse light
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x00,       // Reverse lights are inactive

            0x06,       // Property identifier for Emergency brake light
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x00,       // Emergency brake lights are inactive

            0x07,       // Property identifier for Fog lights
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x00,       // Front fog light
            0x00,       // Light is inactive

            0x07,       // Property identifier for Fog lights
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x01,       // Rear fog light
            0x01,       // Light is active

            0x08,       // Property identifier for Reading lamps
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x00,       // Front left reading lamp
            0x00,       // Lamp is inactive

            0x08,       // Property identifier for Reading lamps
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x01,       // Front right reading lamp
            0x01,       // Lamp is active

            0x09,       // Property identifier for Interior lights
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x00,       // Front interior light
            0x00,       // Light is inactive

            0x09,       // Property identifier for Interior lights
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x01,       // Rear interior light
            0x00        // Light is inactive
        ]

        guard let lights = AAAutoAPI.parseBinary(bytes) as? AALights else {
            return XCTFail("Parsed value is not AALights")
        }

        XCTAssertEqual(lights.frontExterior?.value, .activeFullBeam)
        XCTAssertEqual(lights.rearExteriorState?.value, .active)
        XCTAssertEqual(lights.ambientColour?.value, AAColour(red: 1.0, green: 0.0, blue: 0.0))
        XCTAssertEqual(lights.reverseState?.value, .inactive)
        XCTAssertEqual(lights.emergencyBrakeState?.value, .inactive)

        // Fog Lights
        XCTAssertEqual(lights.fogLights?.count, 2)

        if let fogLight = lights.fogLights?.first(where: { $0.value?.location == .front }) {
            XCTAssertEqual(fogLight.value?.state, .inactive)
        }
        else {
            XCTFail("Fog Lights doesn't contain Front light")
        }

        if let fogLight = lights.fogLights?.first(where: { $0.value?.location == .rear }) {
            XCTAssertEqual(fogLight.value?.state, .active)
        }
        else {
            XCTFail("Fog Lights doesn't contain Rear light")
        }

        // Reading Lamps
        XCTAssertEqual(lights.readingLamps?.count, 2)

        if let readingLamp = lights.readingLamps?.first(where: { $0.value?.location == .frontLeft }) {
            XCTAssertEqual(readingLamp.value?.state, .inactive)
        }
        else {
            XCTFail("Reading Lamps doesn't contain Front Left lamp")
        }

        if let readingLamp = lights.readingLamps?.first(where: { $0.value?.location == .frontRight }) {
            XCTAssertEqual(readingLamp.value?.state, .active)
        }
        else {
            XCTFail("Reading Lamps doesn't contain Front Right lamp")
        }

        // Interior Lamps
        XCTAssertEqual(lights.interiorLamps?.count, 2)

        if let interiorLamp = lights.interiorLamps?.first(where: { $0.value?.location == .front  }) {
            XCTAssertEqual(interiorLamp.value?.state, .inactive)
        }
        else {
            XCTFail("Interior Lamps doesn't contain Front lamp")
        }

        if let interiorLamp = lights.interiorLamps?.first(where: { $0.value?.location == .rear  }) {
            XCTAssertEqual(interiorLamp.value?.state, .inactive)
        }
        else {
            XCTFail("Interior Lamps doesn't contain Rear lamp")
        }
    }
}
