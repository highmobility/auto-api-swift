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
//  HonkHornFlashFlightsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class HonkHornFlashLightsTests: XCTestCase {

    static var allTests = [("testActivateEmergencyFlasher", testActivateEmergencyFlasher),
                           ("testGetState", testGetState),
                           ("testHonkHornFlashLights", testHonkHornFlashLights),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testActivateEmergencyFlasher() {
        let bytes: [UInt8] = [
            0x00, 0x26, // MSB, LSB Message Identifier for Honk Horns & Flash Lights
            0x03,       // Message Type for Emergency Flasher
            0x01        // Activate
        ]

        XCTAssertEqual(HonkHornFlashFlights.activateEmergencyFlasher(true), bytes)
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x26, // MSB, LSB Message Identifier for Honk Horns & Flash Lights
            0x00        // Message Type for Get Flashers State
        ]

        XCTAssertEqual(HonkHornFlashFlights.getFlasherState, bytes)
    }

    func testHonkHornFlashLights() {
        let bytes: [UInt8] = [
            0x00, 0x26, // MSB, LSB Message Identifier for Honk Horns & Flash Lights
            0x02,       // Message Type for Honk Horn & Flash Lights

            0x01,       // Propery Identifier for Honk Horn
            0x00, 0x01, // Property size is 1 byte
            0x00,       // Do not Honk

            0x02,       // Propery Identifier for Flash Lights
            0x00, 0x01, // Propery size is 1 byte
            0x03        // Flash 3 times
        ]

        let settings = HonkHornFlashFlights.Settings(honkHornSeconds: 0, flashLightsTimes: 3)

        XCTAssertEqual(HonkHornFlashFlights.honkHornFlashLights(settings), bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x26, // MSB, LSB Message Identifier for Honk Horns & Flash Lights
            0x01,       // Message Type for Flashers State

            0x01,       // Property Identifier for Flashers State
            0x00, 0x01, // Property size is 1 byte
            0x02        // Left flasher active
        ]

        guard let honkHornFlashLights = AutoAPI.parseBinary(bytes) as? HonkHornFlashFlights else {
            return XCTFail("Parsed value is not HonkHornFlashFlights")
        }

        XCTAssertEqual(honkHornFlashLights.flasherState, .leftFlasherActive)
    }
}
