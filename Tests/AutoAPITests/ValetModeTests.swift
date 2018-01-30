//
// AutoAPITests
// Copyright (C) 2017 High-Mobility GmbH
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
//  ValetModeTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class ValetModeTests: XCTestCase {

    static var allTests = [("testActivateValetMode", testActivateValetMode),
                           ("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testActivateValetMode() {
        let bytes: [UInt8] = [
            0x00, 0x28, // MSB, LSB Message Identifier for Valet Mode
            0x02,       // Message Type for Activate/Deactivate Valet Mode
            0x01        // Activate
        ]

        XCTAssertEqual(ValetMode.activateValetMode(true), bytes)
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x28, // MSB, LSB Message Identifier for Valet Mode
            0x00        // Message Type for Get Valet Mode
        ]

        XCTAssertEqual(ValetMode.getValetMode, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x28, // MSB, LSB Message Identifier for Valet Mode
            0x01,       // Message Type for Valet Mode

            0x01,       // Property Identifier for Valet Mode
            0x00, 0x01, // Property size is 1 byte
            0x01        // Activated
        ]

        guard let valetMode = AutoAPI.parseBinary(bytes) as? ValetMode else {
            return XCTFail("Parsed value is not ValetMode")
        }

        XCTAssertEqual(valetMode.isActive, true)
    }
}
