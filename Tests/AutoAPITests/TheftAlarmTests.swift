//
//  The MIT License
//
//  Copyright (c) 2014- High-Mobility GmbH (https://high-mobility.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//
//  TheftAlarmTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 01/12/2017.
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

        guard let theftAlarm = AAAutoAPI.parseBinary(bytes) as? TheftAlarm else {
            return XCTFail("Parsed value is not TheftAlarm")
        }

        XCTAssertEqual(theftAlarm.state, .armed)
    }
}
