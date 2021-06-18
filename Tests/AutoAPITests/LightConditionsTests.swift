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
//  LightConditionsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 07/12/2017.
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

        guard let lightConditions = AAAutoAPI.parseBinary(bytes) as? LightConditions else {
            return XCTFail("Parsed value is not LightConditions")
        }

        XCTAssertEqual(lightConditions.outsideLight, 111_000)
        XCTAssertEqual(lightConditions.insideLight, 0.25)
    }
}
