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
//  RooftopControlTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 01/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class RooftopControlTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testControlRooftop", testControlRooftop),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x25, // MSB, LSB Message Identifier for Rooftop Control
            0x00        // Message Type for Get Rooftop State
        ]

        XCTAssertEqual(RooftopControl.getRooftopState, bytes)
    }

    func testControlRooftop() {
        let bytes: [UInt8] = [
            0x00, 0x25, // MSB, LSB Message Identifier for Rooftop Control
            0x02,       // Message Type for Control Rooftop

            0x01,       // Property Identifier for Dimming
            0x00, 0x01, // Property size 1 byte
            0x00,       // Make rooftop transparent

            0x02,       // Property Identifier for Position
            0x00, 0x01, // Property size 1 byte
            0x00        // Close Rooftop
        ]

        let control = RooftopControl.Control(dimming: 0, openClose: 0)

        XCTAssertEqual(RooftopControl.controlRooftop(control), bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x25, // MSB, LSB Message Identifier for Rooftop Control
            0x01,       // Message Type for Rooftop State

            0x01,       // Property Identifier for Dimming
            0x00, 0x01, // Property size 1 byte
            0x64,       // Rooftop is opaque

            0x02,       // Property Identifier for Position
            0x00, 0x01, // Property size 1 byte
            0x00        // Rooftop is fully closed
        ]

        guard let rooftopControl = AutoAPI.parseBinary(bytes) as? RooftopControl else {
            return XCTFail("Parsed value is not RooftopControl")
        }

        XCTAssertEqual(rooftopControl.dimming, 100)
        XCTAssertEqual(rooftopControl.position, 0)
    }
}
