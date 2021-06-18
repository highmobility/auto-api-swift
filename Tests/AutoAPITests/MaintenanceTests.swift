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
//  MaintenanceTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 29/11/2017.
//

import AutoAPI
import XCTest


class MaintenanceTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x34, // MSB, LSB Message Identifier for Maintenance
            0x00        // Message Type for Get Maintenance State
        ]

        XCTAssertEqual(Maintenance.getMaintenanceState, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x34, // MSB, LSB Message Identifier for Maintenance
            0x01,       // Message Type for Maintenance State

            0x01,       // Property Identifier for Days to next service
            0x00, 0x02, // Property size 2 bytes
            0x01, 0xF5, // 501 days until servicing

            0x02,               // Property Identifier for Kilometers to next service
            0x00, 0x03,         // Property size 3 bytes
            0x00, 0x0E, 0x61    // 3'681 km until servicing
        ]

        guard let maintenance = AAAutoAPI.parseBinary(bytes) as? Maintenance else {
            return XCTFail("Parsed value is not Maintenance")
        }

        XCTAssertEqual(maintenance.daysToNextService, 501)
        XCTAssertEqual(maintenance.kmToNextService, 3_681)
    }
}
