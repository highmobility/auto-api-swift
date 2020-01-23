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
//  VehicleLocationTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 04/12/2017.
//

import AutoAPI
import XCTest


class VehicleLocationTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x30, // MSB, LSB Message Identifier for Vehicle Location
            0x00        // Message Type for Get Vehicle Location
        ]

        XCTAssertEqual(VehicleLocation.getVehicleLocation, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x30, // MSB, LSB Message Identifier for Vehicle Location
            0x01,       // Message Type for Vehicle Location

            0x01,                   // Property Identifier for Coordinate
            0x00, 0x08,             // Property size 8 bytes
            0x42, 0x52, 0x14, 0x7d, // 52.520008 Latitude in IEE 754 format
            0x41, 0x56, 0x7a, 0xb1, // 13.404954 Longitude in IEE 754 format

            0x02,                   // Property Identifier for Heading
            0x00, 0x04,             // Property size 4 bytes
            0x42, 0x52, 0x14, 0x7d, // 52.520008 Heading in IEE 754 format

            0x03,                   // Property identifier for Altitude
            0x00, 0x04,             // Property size is 4 bytes
            0x43, 0x05, 0x80, 0x00  // 133.5 meters above the WGS 84 reference ellipsoid point
        ]

        guard let vehicleLocation = AutoAPI.parseBinary(bytes) as? VehicleLocation else {
            return XCTFail("Parsed value is not VehicleLocation")
        }

        if let coordinate = vehicleLocation.coordinate {
            XCTAssertEqual(coordinate.latitude, 52.520008, accuracy: 1e-7)
            XCTAssertEqual(coordinate.longitude, 13.404954, accuracy: 1e-7)
        }
        else {
            XCTFail("Vehicle Location doesn't contain Coordinate")
        }

        XCTAssertEqual(vehicleLocation.heading, 52.520008)
        XCTAssertEqual(vehicleLocation.altitude, 133.5)
    }
}
