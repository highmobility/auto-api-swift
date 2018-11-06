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
//  NaviDestinationTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
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

        XCTAssertEqual(AANaviDestination.getNaviDestination, bytes)
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

        let coordinate = AACoordinatea(latitude: 52.520008, longitude: 13.404954)
        let destination = AANaviDestination.Destination(coordinate: coordinate, name: "Berlin")

        XCTAssertEqual(AANaviDestination.setDestination(destination), bytes)
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

        guard let naviDestination = AAAutoAPI.parseBinary(bytes) as? AANaviDestination else {
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
