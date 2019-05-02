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
//  AARemoteControlTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AARemoteControlTests: XCTestCase {

    static var allTests = [("testControlCommand", testControlCommand),
                           ("testGetState", testGetState),
                           ("testStartControlMode", testStartStopControlMode),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testControlCommand() {
        let bytes: [UInt8] = [
            0x00, 0x27, // MSB, LSB Message Identifier for Remote Control
            0x04,       // Message Type for Control Command

            0x01,       // Property Identifier for Speed
            0x00, 0x04, // Property size is 4 byte
            0x01,       // Data component
            0x00, 0x01, // Data component size is 1 byte
            0x03,       // 3 km/h

            0x02,       // Property Identifier for Angle
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component
            0x00, 0x02, // Data component size is 2 bytes
            0x00, 0x32  // Angle 50 degrees
        ]

        XCTAssertEqual(AARemoteControl.controlCommand(angle: 50, speed: 3).bytes, bytes)
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x27, // MSB, LSB Message Identifier for Remote Control
            0x00        // Message Type for Get Control Mode
        ]

        XCTAssertEqual(AARemoteControl.getControlState.bytes, bytes)
    }

    func testStartStopControlMode() {
        // Start
        let bytes1: [UInt8] = [
            0x00, 0x27, // MSB, LSB Message Identifier for Remote Control
            0x12,       // Message Type for Start-Stop Control Mode

            0x01,       // Property Identifier for Start-Stop Control Mode
            0x00, 0x04, // Property size 4 bytes
            0x01,       // Data component
            0x00, 0x01, // Data component size 1 byte
            0x00        // Start Control
        ]

        XCTAssertEqual(AARemoteControl.startStopControl(.start)?.bytes, bytes1)

        // Stop
        let bytes2: [UInt8] = [
            0x00, 0x27, // MSB, LSB Message Identifier for Remote Control
            0x12,       // Message Type for Start-Stop Control Mode

            0x01,       // Property Identifier for Start-Stop Control Mode
            0x00, 0x04, // Property size 4 bytes
            0x01,       // Data component
            0x00, 0x01, // Data component size 1 byte
            0x01        // Stop Control
        ]

        XCTAssertEqual(AARemoteControl.startStopControl(.stop)?.bytes, bytes2)

        // Failure
        XCTAssertNil(AARemoteControl.startStopControl(.reset))
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x27, // MSB, LSB Message Identifier for Remote Control
            0x01,       // Message Type for Control Mode

            0x01,       // Property Identifier for Mode
            0x00, 0x04, // Property size is 4 byte
            0x01,       // Data component
            0x00, 0x01, // Data component size is 1 byte
            0x02,       // Control Mode Started

            0x02,       // Property Identifier for Angle
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component
            0x00, 0x02, // Data component size is 2 bytes
            0x00, 0x32  // Angle 50 degrees
        ]

        guard let remoteControl = AAAutoAPI.parseBinary(bytes) as? AARemoteControl else {
            return XCTFail("Parsed value is not AARemoteControl")
        }

        XCTAssertEqual(remoteControl.controlMode?.value, .started)
        XCTAssertEqual(remoteControl.angle?.value, 50)
    }
}
