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
//  TheftAlarmTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 01/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class TheftAlarmTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testSetTheftAlarm", testSetTheftAlarm),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x46, // MSB, LSB Message Identifier for Theft Alarm
            0x00        // Message Type for Get Theft Alarm State
        ]

        XCTAssertEqual(TheftAlarm.getTheftAlarmState, bytes)
    }

    func testSetTheftAlarm() {
        let bytes: [UInt8] = [
            0x00, 0x46, // MSB, LSB Message Identifier for Theft Alarm
            0x02,       // Message Type for Set Theft Alarm

            0x02  // Trigger alarm
        ]

        XCTAssertEqual(TheftAlarm.setTheftAlarm(.trigger), bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x46, // MSB, LSB Message Identifier for Theft Alarm
            0x01,       // Message Type for Theft Alarm State

            0x01,       // Property Identifier for Theft Alarm
            0x00, 0x01, // Property size 1 byte
            0x01        // Theft alarm armed
        ]

        guard let theftAlarm = AutoAPI.parseBinary(bytes) as? TheftAlarm else {
            return XCTFail("Parsed value is not TheftAlarm")
        }

        XCTAssertEqual(theftAlarm.state, .armed)
    }
}
