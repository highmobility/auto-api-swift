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
//  AAValetModeTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AAValetModeTests: XCTestCase {

    static var allTests = [("testActivateValetMode", testActivateValetMode),
                           ("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testActivateValetMode() {
        let bytes: [UInt8] = [
            0x00, 0x28, // MSB, LSB Message Identifier for Valet Mode
            0x12,       // Message Type for Activate/Deactivate Valet Mode

            0x01,       // Property Identifier for Valet mode
            0x00, 0x04, // Property size 4 bytes
            0x01,       // Data component
            0x00, 0x01, // Data component size 1 byte
            0x01        // Activate
        ]

        XCTAssertEqual(AAValetMode.activate(.active).bytes, bytes)
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x28, // MSB, LSB Message Identifier for Valet Mode
            0x00        // Message Type for Get Valet Mode
        ]

        XCTAssertEqual(AAValetMode.getState.bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x28, // MSB, LSB Message Identifier for Valet Mode
            0x01,       // Message Type for Valet Mode

            0x01,       // Property Identifier for Valet Mode
            0x00, 0x04, // Property size is 4 byte
            0x01,       // Data component
            0x00, 0x01, // Data component size is 1 byte
            0x01        // Activated
        ]

        guard let valetMode = AAAutoAPI.parseBinary(bytes) as? AAValetMode else {
            return XCTFail("Parsed value is not ValetMode")
        }

        XCTAssertEqual(valetMode.state?.value, .active)
    }
}
