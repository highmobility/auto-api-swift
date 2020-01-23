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
//  NaviDestinationTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 12/12/2017.
//

import AutoAPI
import XCTest


class NaviDestinationTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testSetDestination", testSetDestination),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x31, // MSB, LSB Message Identifier for Navi Destination
            0x00        // Message Type for Get Navi Destination
        ]

        XCTAssertEqual(NaviDestination.getNaviDestination, bytes)
    }

    func testSetDestination() {
        let bytes: [UInt8] = [
            0x00, 0x31, // MSB, LSB Message Identifier for Navi Destination
            0x02,       // Message Type for Set Destination

            0x01,                   // Property Identifier for Latitude
            0x00, 0x08,             // Property size is 4 bytes
            0x42, 0x52, 0x14, 0x7d, // 52.520008 Latitude in IEE 754 format
            0x41, 0x56, 0x7a, 0xb1, // 13.404954 Longitude in IEE 754 format

            0x02,       // Property Identifier for Destination Name
            0x00, 0x06, // Property size is 6 bytes
            0x42, 0x65, 0x72, 0x6c, 0x69, 0x6e  // Berlin
        ]

        let coordinate = Coordinate(latitude: 52.520008, longitude: 13.404954)
        let destination = NaviDestination.Destination(coordinate: coordinate, name: "Berlin")

        XCTAssertEqual(NaviDestination.setDestination(destination), bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x31, // MSB, LSB Message Identifier for Navi Destination
            0x01,       // Message Type for Navi Destination

            0x01,                   // Property Identifier for Latitude
            0x00, 0x08,             // Property size is 4 bytes
            0x42, 0x52, 0x14, 0x7d, // 52.520008 Latitude in IEE 754 format
            0x41, 0x56, 0x7a, 0xb1, // 13.404954 Longitude in IEE 754 format

            0x02,       // Property Identifier for Destination Name
            0x00, 0x06, // Property size is 6 bytes
            0x42, 0x65, 0x72, 0x6c, 0x69, 0x6e  // Berlin
        ]

        guard let naviDestination = AutoAPI.parseBinary(bytes) as? NaviDestination else {
            return XCTFail("Parsed value is not NaviDestination")
        }

        if let coordinate = naviDestination.coordinate {
            XCTAssertEqual(coordinate.latitude, 52.520008, accuracy: 1e-7)
            XCTAssertEqual(coordinate.longitude, 13.404954, accuracy: 1e-7)
        }
        else {
            XCTFail("NaviDestination Location doesn't contain Coordinate")
        }

        XCTAssertEqual(naviDestination.name, "Berlin")
    }
}
