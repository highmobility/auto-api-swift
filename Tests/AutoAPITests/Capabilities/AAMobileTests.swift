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
//  AAMobileTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 19/03/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAMobileTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x66, // MSB, LSB Message Identifier for Mobile
            0x00        // Message Type for Get Mobile State
        ]

        XCTAssertEqual(AAMobile.getConnectionState.bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x66, // MSB, LSB Message Identifier for Mobile
            0x01,       // Message Type for Mobile State

            0x01,       // Property identifier for Connection
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01        // A mobile phone is connected
        ]

        guard let mobile = AutoAPI.parseBinary(bytes) as? AAMobile else {
            return XCTFail("Parsed value is not AAMobile")
        }

        XCTAssertEqual(mobile.connected?.value, .connected)
    }
}
