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
//  CruiseControlTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 24/04/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class CruiseControlTests: XCTestCase {
    
    static var allTests = [("testControl", testControl),
                           ("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testControl() {
        let bytes: [UInt8] = [
            0x00, 0x62, // MSB, LSB Message Identifier for Cruise Control
            0x02,       // Message Type for Control Cruise Control

            0x01,       // Property Identifier for Cruise control
            0x00, 0x01, // Property size 1 byte
            0x01,       // Activate cruise control

            0x02,       // Property Identifier for Target speed
            0x00, 0x02, // Property size 2 byte
            0x00, 0x3C  // Set target speed to 60 km/h
        ]

        let control = AACruiseControl.Control(isActive: true, targetSpeed: 60)

        XCTAssertEqual(AACruiseControl.activateCruiseControl(control), bytes)
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x62, // MSB, LSB Message Identifier for Cruise Control
            0x00        // Message Type for Get Cruise Control State
        ]

        XCTAssertEqual(AACruiseControl.getCruiseControlState, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x62, // MSB, LSB Message Identifier for Cruise Control
            0x01,       // Message Type for Cruise Control State

            0x01,       // Property identifier for Cruise control
            0x00, 0x01, // Property size is 1 bytes
            0x01,       // Cruise control is active

            0x02,       // Property identifier for Limiter
            0x00, 0x01, // Property size is 1 bytes
            0x01,       // Higher speed requested by the limiter

            0x03,       // Property identifier for Target speed
            0x00, 0x02, // Property size is 2 bytes
            0x00, 0x3C, // The target speed is set to 60km/h

            0x04,       // Property identifier for Acc
            0x00, 0x01, // Property size is 1 bytes
            0x00,       // Adaptive Cruise Control is inactive

            0x05,       // Property identifier for Acc target speed
            0x00, 0x02, // Property size is 2 bytes
            0x00, 0x3C  // The Adaptive Cruise Control target speed is set to 60km/h
        ]

        guard let cruiseControl = AAAutoAPI.parseBinary(bytes) as? AACruiseControl else {
            return XCTFail("Parsed value is not CruiseControl")
        }

        XCTAssertEqual(cruiseControl.isActive, true)
        XCTAssertEqual(cruiseControl.limiter, .higherSpeedRequested)
        XCTAssertEqual(cruiseControl.targetSpeed, 60)
        XCTAssertEqual(cruiseControl.isAdaptiveActive, false)
        XCTAssertEqual(cruiseControl.adaptiveTargetSpeed, 60)
    }
}
