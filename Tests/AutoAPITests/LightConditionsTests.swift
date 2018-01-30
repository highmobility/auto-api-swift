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
//  LightConditionsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 07/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class LightConditionsTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x54, // MSB, LSB Message Identifier for Light Conditions
            0x00        // Message Type for Get Light Conditions
        ]

        XCTAssertEqual(LightConditions.getLightConditions, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x54, // MSB, LSB Message Identifier for Light Conditions
            0x01,       // Message Type for Light Conditions State

            0x01,                   // Property Identifier for Outside light
            0x00, 0x04,             // Property size 4 bytes
            0x47, 0xd8, 0xcc, 0x00, // 111_000 lux

            0x02,                   // Property Identifier for Inside light
            0x00, 0x04,             // Property size 4 bytes
            0x3e, 0x80, 0x00, 0x00  // 0.25 lux
        ]

        guard let lightConditions = AutoAPI.parseBinary(bytes) as? LightConditions else {
            return XCTFail("Parsed value is not LightConditions")
        }

        XCTAssertEqual(lightConditions.outsideLight, 111_000)
        XCTAssertEqual(lightConditions.insideLight, 0.25)
    }
}
