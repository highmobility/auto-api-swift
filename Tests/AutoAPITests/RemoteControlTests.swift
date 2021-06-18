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
//  RemoteControlTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 12/12/2017.
//

import AutoAPI
import XCTest


class RemoteControlTests: XCTestCase {

    static var allTests = [("testControlCommand", testControlCommand),
                           ("testGetState", testGetState),
                           ("testStartControlMode", testStartControlMode),
                           ("testState", testState),
                           ("testStopControlMode", testStopControlMode)]


    // MARK: XCTestCase

    func testControlCommand() {
        let bytes: [UInt8] = [
            0x00, 0x27, // MSB, LSB Message Identifier for Remote Control
            0x04,       // Message Type for Control Command

            0x01,       // Property Identifier for Speed
            0x00, 0x01, // Property size is 1 byte
            0x03,       // 3 km/h

            0x02,       // Property Identifier for Angle
            0x00, 0x02, // Propery size is 2 bytes
            0x00, 0x32  // Angle 50 degrees
        ]

        let control = RemoteControl.Control(speed: 3, angle: 50)

        XCTAssertEqual(RemoteControl.controlCommand(control), bytes)
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x27, // MSB, LSB Message Identifier for Remote Control
            0x00        // Message Type for Get Control Mode
        ]

        XCTAssertEqual(RemoteControl.getControlMode, bytes)
    }

    func testStartControlMode() {
        let bytes: [UInt8] = [
            0x00, 0x27, // MSB, LSB Message Identifier for Remote Control
            0x02        // Message Type for Start Control Mode
        ]

        XCTAssertEqual(RemoteControl.startControlMode, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x27, // MSB, LSB Message Identifier for Remote Control
            0x01,       // Message Type for Control Mode

            0x01,       // Property Identifier for Mode
            0x00, 0x01, // Propert size is 1 byte
            0x02,       // Control Mode Started

            0x02,       // Property Identifier for Angle
            0x00, 0x02, // Propery size is 2 bytes
            0x00, 0x32  // Angle 50 degrees
        ]

        guard let remoteControl = AAAutoAPI.parseBinary(bytes) as? RemoteControl else {
            return XCTFail("Parsed value is not RemoteControl")
        }

        XCTAssertEqual(remoteControl.controlMode, .started)
        XCTAssertEqual(remoteControl.angle, 50)
    }

    func testStopControlMode() {
        let bytes: [UInt8] = [
            0x00, 0x27, // MSB, LSB Message Identifier for Remote Control
            0x03        // Message Type for Stop Control Mode
        ]

        XCTAssertEqual(RemoteControl.stopControlMode, bytes)
    }
}
