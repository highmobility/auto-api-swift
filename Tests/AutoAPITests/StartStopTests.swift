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
//  StartStopTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 24/04/2018.
//

import AutoAPI
import XCTest


class StartStopTests: XCTestCase {
    
    static var allTests = [("testActivate", testActivate),
                           ("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testActivate() {
        let bytes: [UInt8] = [
            0x00, 0x63, // MSB, LSB Message Identifier for Start-Stop
            0x02, // Message Type for Activate/Deactivate Start-Stop

            0x01,       // Property Identifier for Start-Stop
            0x00, 0x01, // Property size 1 byte
            0x00        // Deactivate
        ]

        XCTAssertEqual(StartStop.activateStartStop(false), bytes)
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x63, // MSB, LSB Message Identifier for Start-Stop
            0x00        // Message Type for Get Start Stop State
        ]

        XCTAssertEqual(StartStop.getStartStopState, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x63, // MSB, LSB Message Identifier for Start-Stop
            0x01,       // Message Type for Start Stop State

            0x01,       // Property identifier for Start stop
            0x00, 0x01, // Property size is 1 bytes
            0x01        // Automatic engine start-stop system active
        ]

        guard let startStop = AutoAPI.parseBinary(bytes) as? StartStop else {
            return XCTFail("Parsed value is not StartStop")
        }

        XCTAssertEqual(startStop.isActive, true)
    }
}
