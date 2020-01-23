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
//  HonkHornFlashFlightsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 12/12/2017.
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
