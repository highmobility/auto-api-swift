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
//  DriverFatigueTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 12/12/2017.
//

import AutoAPI
import XCTest


class DriverFatigueTests: XCTestCase {

    static var allTests = [("testDetected", testDetected)]


    // MARK: XCTestCase

    func testDetected() {
        let bytes: [UInt8] = [
            0x00, 0x41, // MSB, LSB Message Identifier for Driver Fatigue
            0x01,       // Message Type for Driver Fatigue Detected

            0x01,       // Property Identifier for Fatigue Level
            0x00, 0x01, // Propert size is 1 byte
            0x00        // Light fatigue of the driver
        ]

        guard let driverFatigue = AAAutoAPI.parseBinary(bytes) as? DriverFatigue else {
            return XCTFail("Parsed value is not DriverFatigue")
        }

        XCTAssertEqual(driverFatigue.fatigueLevel, .light)
    }
}
