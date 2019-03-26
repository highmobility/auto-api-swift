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
//  AAFuelingTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AAFuelingTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testState", testState),
                           ("testControlGasFlap", testControlGasFlap)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x40, // MSB, LSB Message Identifier for Fueling
            0x00        // Message Type for Get Gas Flap State
        ]

        XCTAssertEqual(AAFueling.getGasFlapState.bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x40, // MSB, LSB Message Identifier for Fueling
            0x01,       // Message Type for Gas Flap State

            0x02,       // Property identifier for Gas flap lock
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // Gas flap locked

            0x03,       // Property identifier for Gas flap position
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x00        // Gas flap closed
        ]

        guard let fueling = AAAutoAPI.parseBinary(bytes) as? AAFueling else {
            return XCTFail("Parsed value is not AAFueling")
        }

        XCTAssertEqual(fueling.gasFlapLockState?.value, .locked)
        XCTAssertEqual(fueling.gasFlapPosition?.value, .closed)
    }

    func testControlGasFlap() {
        let bytes: [UInt8] = [
            0x00, 0x40, // MSB, LSB Message Identifier for Fueling
            0x12,       // Message Type for Control Gas Flap

            0x02,       // Property Identifier for Gas flap lock
            0x00, 0x04, // Property size 4 byte
            0x01,       // Data component
            0x00, 0x01, // Data component size 1 byte
            0x00,       // Unlock the flap

            0x03,       // Property Identifier for Gas flap position
            0x00, 0x04, // Property size 4 byte
            0x01,       // Data component
            0x00, 0x01, // Data component size 1 byte
            0x01        // Open the flap
        ]

        XCTAssertEqual(AAFueling.controlGasFlap(lockState: .unlocked, position: .open).bytes, bytes)
    }
}
