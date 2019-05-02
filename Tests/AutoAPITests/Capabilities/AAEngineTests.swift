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
//  AAEngineTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 28/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AAEngineTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testState", testState),
                           ("testTurnEngine", testTurnEngine)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x35, // MSB, LSB Message Identifier for Engine
            0x00        // Message Type for Get Ignition State
        ]

        XCTAssertEqual(AAEngine.getEngineState.bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x35, // MSB, LSB Message Identifier for Engine
            0x01,       // Message Type for Ignition State

            0x01,       // Property identifier for Ignition
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // Engine ignition is ON

            0x02,       // Property identifier for Accessories ignition
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component
            0x00, 0x01, // Data component size is 1 bytes
            0x01        // Ignition state is powering on accessories such as radio
        ]

        guard let engine = AAAutoAPI.parseBinary(bytes) as? AAEngine else {
            return XCTFail("Parsed value is not AAEngine")
        }

        XCTAssertEqual(engine.ignitionState?.value, .active)
        XCTAssertEqual(engine.accessoriesPoweredState?.value, .active)
    }

    func testTurnEngine() {
        let bytes: [UInt8] = [
            0x00, 0x35, // MSB, LSB Message Identifier for Engine
            0x12,       // Message Type for Turn Engine On/Off

            0x01,       // Property Identifier for Ignition
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component
            0x00, 0x01, // Data component size is 1 bytes
            0x01        // Engine On
        ]

        XCTAssertEqual(AAEngine.turnIgnitionOnOff(.active).bytes, bytes)
    }
}
