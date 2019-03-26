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
//  AATrunkAccessTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 27/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AATrunkAccessTests: XCTestCase {

    static var allTests = [("testControl", testControl),
                           ("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testControl() {
        let bytes: [UInt8] = [
            0x00, 0x21, // MSB, LSB Message Identifier for Trunk Access
            0x12,       // Message Type for Open/Close Trunk

            0x01,       // Property Identifier for Lock
            0x00, 0x04, // Property size 4 byte
            0x01,       // Data component
            0x00, 0x01, // Data component size 1 byte
            0x00,       // Unlock

            0x02,       // Property Identifier for Position
            0x00, 0x04, // Property size 4 byte
            0x01,       // Data component
            0x00, 0x01, // Data component size 1 byte
            0x01        // Open
        ]

        XCTAssertEqual(AATrunkAccess.controlTrunk(.unlocked, changePosition: .open).bytes, bytes)
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x21, // MSB, LSB Message Identifier for Trunk Access
            0x00        // Message Type for Get Trunk State
        ]

        XCTAssertEqual(AATrunkAccess.getState.bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x21, // MSB, LSB Message Identifier for Trunk Access
            0x01,       // Message Type for Trunk State

            0x01,       // Property Identifier for Lock
            0x00, 0x04, // Property size 4 byte
            0x01,       // Data component
            0x00, 0x01, // Data component size 1 byte
            0x00,       // Unlocked

            0x02,       // Property Identifier for Position
            0x00, 0x04, // Property size 4 byte
            0x01,       // Data component
            0x00, 0x01, // Data component size 1 byte
            0x01        // Open
        ]

        guard let trunkAccess = AAAutoAPI.parseBinary(bytes) as? AATrunkAccess else {
            return XCTFail("Parsed value is not TrunkAccess")
        }

        XCTAssertEqual(trunkAccess.lock?.value, .unlocked)
        XCTAssertEqual(trunkAccess.position?.value, .open)
    }
}
