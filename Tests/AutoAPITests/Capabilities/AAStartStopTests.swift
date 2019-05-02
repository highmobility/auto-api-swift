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
//  AAStartStopTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 24/04/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AAStartStopTests: XCTestCase {
    
    static var allTests = [("testActivate", testActivate),
                           ("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testActivate() {
        let bytes: [UInt8] = [
            0x00, 0x63, // MSB, LSB Message Identifier for Start-Stop
            0x12, // Message Type for Activate/Deactivate Start-Stop

            0x01,       // Property Identifier for Start-Stop
            0x00, 0x04, // Property size 4 byte
            0x01,       // Data component
            0x00, 0x01, // Data component size 1 byte
            0x00        // Deactivate
        ]

        XCTAssertEqual(AAStartStop.activate(.inactive).bytes, bytes)
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x63, // MSB, LSB Message Identifier for Start-Stop
            0x00        // Message Type for Get Start Stop State
        ]

        XCTAssertEqual(AAStartStop.getState.bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x63, // MSB, LSB Message Identifier for Start-Stop
            0x01,       // Message Type for Start Stop State

            0x01,       // Property identifier for Start stop
            0x00, 0x04, // Property size 4 byte
            0x01,       // Data component
            0x00, 0x01, // Data component size 1 byte
            0x01        // Automatic engine start-stop system active
        ]

        guard let startStop = AAAutoAPI.parseBinary(bytes) as? AAStartStop else {
            return XCTFail("Parsed value is not StartStop")
        }

        XCTAssertEqual(startStop.activeState?.value, .active)
    }
}
