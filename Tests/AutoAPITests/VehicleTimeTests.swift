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
//  VehicleTimeTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 12/12/2017.
//

import AutoAPI
import XCTest


class VehicleTimeTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x50, // MSB, LSB Message Identifier for Vehicle Time
            0x00        // Message Type for Get Vehicle Time
        ]

        XCTAssertEqual(VehicleTime.getVehicleTime, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x50, // MSB, LSB Message Identifier for Vehicle Time
            0x01,       // Message Type for Vehicle Time

            0x01,       // Property Identifier for Vehicle Time
            0x00, 0x08, // Property size is 6 bytes
            0x11,       // 2017
            0x01,       // January
            0x0a,       // the 10th
            0x10,       // 16h
            0x20,       // 32min
            0x33,       // 51sec
            0xFF, 0x88  // -120 min UTC time offset
        ]

        guard let vehicleTime = AutoAPI.parseBinary(bytes) as? VehicleTime else {
            return XCTFail("Parsed value is not VehicleTime")
        }

        XCTAssertEqual(vehicleTime.time?.year, 2017)
        XCTAssertEqual(vehicleTime.time?.month, 1)
        XCTAssertEqual(vehicleTime.time?.day, 10)
        XCTAssertEqual(vehicleTime.time?.hour, 16)
        XCTAssertEqual(vehicleTime.time?.minute, 32)
        XCTAssertEqual(vehicleTime.time?.second, 51)
        XCTAssertEqual(vehicleTime.time?.offset, -120)
    }
}
