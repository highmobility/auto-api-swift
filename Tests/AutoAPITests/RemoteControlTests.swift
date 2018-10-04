//
// AutoAPITests
// Copyright (C) 2018 High-Mobility GmbH
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
//  RemoteControlTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
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

        let control = AARemoteControl.Control(speed: 3, angle: 50)

        XCTAssertEqual(AARemoteControl.controlCommand(control), bytes)
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x27, // MSB, LSB Message Identifier for Remote Control
            0x00        // Message Type for Get Control Mode
        ]

        XCTAssertEqual(AARemoteControl.getControlMode, bytes)
    }

    func testStartControlMode() {
        let bytes: [UInt8] = [
            0x00, 0x27, // MSB, LSB Message Identifier for Remote Control
            0x02        // Message Type for Start Control Mode
        ]

        XCTAssertEqual(AARemoteControl.startControlMode, bytes)
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

        guard let remoteControl = AAAutoAPI.parseBinary(bytes) as? AARemoteControl else {
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

        XCTAssertEqual(AARemoteControl.stopControlMode, bytes)
    }
}
