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
//  OffroadTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 07/12/2017.
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

        XCTAssertEqual(Offroad.getOffroadState, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x52, // MSB, LSB Message Identifier for Offroad
            0x01,       // Message Type for Offroad State

            0x01,       // Property Identifier for Route incline
            0x00, 0x02, // Property size 2 bytes
            0xFF, 0xF6, // -10 degrees incline

            0x02,       // Property Identifier for Wheel suspension
            0x00, 0x01, // Property size 1 byte
            0x32        // 50% wheel suspension level
        ]

        guard let offroad = AAAutoAPI.parseBinary(bytes) as? Offroad else {
            return XCTFail("Parsed value is not Offroad")
        }

        XCTAssertEqual(offroad.routeIncline, -10)
        XCTAssertEqual(offroad.wheelSuspension, 50)
    }
}
