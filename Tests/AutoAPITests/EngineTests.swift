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
//  EngineTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 28/11/2017.
//

import AutoAPI
import XCTest


class EngineTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testState", testState),
                           ("testTurnEngine", testTurnEngine)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x35, // MSB, LSB Message Identifier for Engine
            0x00        // Message Type for Get Ignition State
        ]

        XCTAssertEqual(Engine.getIgnitionState, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x35, // MSB, LSB Message Identifier for Engine
            0x01,       // Message Type for Ignition State

            0x01,       // Property identifier for Ignition
            0x00, 0x01, // Property size is 1 bytes
            0x01,       // Engine ignition is ON

            0x02,       // Property identifier for Accessories ignition
            0x00, 0x01, // Property size is 1 bytes
            0x01        // Ignition state is powering on accessories such as radio
        ]

        guard let engine = AAAutoAPI.parseBinary(bytes) as? Engine else {
            return XCTFail("Parsed value is not Engine")
        }

        XCTAssertEqual(engine.isIgnitionOn, true)
        XCTAssertEqual(engine.areAccessoriesPowered, true)
    }

    func testTurnEngine() {
        let bytes: [UInt8] = [
            0x00, 0x35, // MSB, LSB Message Identifier for Engine
            0x02,       // Message Type for Turn Engine On/Off
            0x01        // Engine On
        ]

        XCTAssertEqual(Engine.turnIgnitionOn(true), bytes)
    }
}
