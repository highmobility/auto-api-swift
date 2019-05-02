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
//  AAHonkHornFlashLightsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AAHonkHornFlashLightsTests: XCTestCase {

    static var allTests = [("testActivateEmergencyFlasher", testActivateEmergencyFlasher),
                           ("testGetState", testGetState),
                           ("testHonkHornFlashLights", testHonkHornFlashLights),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testActivateEmergencyFlasher() {
        let bytes: [UInt8] = [
            0x00, 0x26, // MSB, LSB Message Identifier for Honk Horns & Flash Lights
            0x13,       // Message Type for Emergency Flasher

            0x01,       // Propery Identifier for Emergency flasher
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01        // Activate
        ]

        XCTAssertEqual(AAHonkHornFlashLights.activateEmergencyFlasher(.active).bytes, bytes)
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x26, // MSB, LSB Message Identifier for Honk Horns & Flash Lights
            0x00        // Message Type for Get Flashers State
        ]

        XCTAssertEqual(AAHonkHornFlashLights.getFlasherState.bytes, bytes)
    }

    func testHonkHornFlashLights() {
        let bytes: [UInt8] = [
            0x00, 0x26, // MSB, LSB Message Identifier for Honk Horns & Flash Lights
            0x12,       // Message Type for Honk Horn & Flash Lights

            0x01,       // Propery Identifier for Honk Horn
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x00,       // Do not Honk

            0x02,       // Propery Identifier for Flash Lights
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x03        // Flash 3 times
        ]

        XCTAssertEqual(AAHonkHornFlashLights.honkHorn(seconds: 0, flashLightsXTimes: 3)?.bytes, bytes)
        XCTAssertNil(AAHonkHornFlashLights.honkHorn(seconds: nil, flashLightsXTimes: nil), "Honk Horn Flash Lights needs at least 1 input")
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x26, // MSB, LSB Message Identifier for Honk Horns & Flash Lights
            0x01,       // Message Type for Flashers State

            0x01,       // Property identifier for Flashers
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x02        // Left flasher active
        ]

        guard let honkHornFlashLights = AAAutoAPI.parseBinary(bytes) as? AAHonkHornFlashLights else {
            return XCTFail("Parsed value is not AAHonkHornFlashLights")
        }

        XCTAssertEqual(honkHornFlashLights.flasherState?.value, .leftFlasherActive)
    }
}
