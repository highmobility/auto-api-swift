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
//  OffroadTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 07/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class OffroadTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x52, // MSB, LSB Message Identifier for Offroad
            0x00        // Message Type for Get Offroad State
        ]

        XCTAssertEqual(Offroad.getState, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x52, // MSB, LSB Message Identifier for Offroad
            0x01,       // Message Type for Offroad State

            0x01,       // Property Identifier for Route incline
            0x00, 0x02, // Property size 2 bytes
            0x00, 0x0A, // 10 degrees incline

            0x02,       // Property Identifier for Wheel suspension
            0x00, 0x01, // Property size 1 byte
            0x32        // 50% wheel suspension level
        ]

        guard let offroad = AutoAPI.parseBinary(bytes) as? Offroad else {
            return XCTFail("Parsed value is not Offroad")
        }

        XCTAssertEqual(offroad.routeIncline, 10)
        XCTAssertEqual(offroad.wheelSuspension, 50)
    }
}
