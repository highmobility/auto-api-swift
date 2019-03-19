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
//  AAPowerTakeOffTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 30/04/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AAPowerTakeOffTests: XCTestCase {
    
    static var allTests = [("testActivate", testActivate),
                           ("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testActivate() {
        let bytes: [UInt8] = [
            0x00, 0x65, // MSB, LSB Message Identifier for Power Take-Off
            0x02,       // Message Type for Control Power Take-Off

            0x01,       // Property Identifier for Power Take-Off
            0x00, 0x04, // Property size 4 byte
            0x01,       // Data component
            0x00, 0x01, // component size 1 byte
            0x01        // Activate power take-off
        ]

        XCTAssertEqual(AAPowerTakeoff.activate(.active).bytes, bytes)
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x65, // MSB, LSB Message Identifier for Power Take-Off
            0x00        // Message Type for Get Power Takeoff State
        ]

        XCTAssertEqual(AAPowerTakeoff.getState.bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x65, // MSB, LSB Message Identifier for Power Take-Off
            0x01,       // Message Type for Power Takeoff State

            0x01,       // Property identifier for Power takeoff
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // Power Take-Off system is active

            0x02,       // Property identifier for Power takeoff engaged
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component
            0x00, 0x01, // Data component size is 1 bytes
            0x01        // At least one Power Take-Off drive is engaged
        ]

        guard let powerTakeOff = AAAutoAPI.parseBinary(bytes) as? AAPowerTakeoff else {
            return XCTFail("Parsed value is not PowerTakeOff")
        }

        XCTAssertEqual(powerTakeOff.activeState?.value, .active)
        XCTAssertEqual(powerTakeOff.engagedState?.value, .active)
    }
}
