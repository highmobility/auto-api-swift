//
// AutoAPITests
// Copyright (C) 2019 High-Mobility GmbH
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
//  AANaviDestinationTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AANaviDestinationTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testSetDestination", testSetDestination),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x31, // MSB, LSB Message Identifier for Navi Destination
            0x00        // Message Type for Get Navi Destination
        ]

        XCTAssertEqual(AANaviDestination.getDestination.bytes, bytes)
    }

    func testSetDestination() {
        let bytes: [UInt8] = [
            0x00, 0x31, // MSB, LSB Message Identifier for Navi Destination
            0x12,       // Message Type for Set Destination

            0x07,       // Property identifier for Coordinates
            0x00, 0x13, // Property size is 19 bytes
            0x01,       // Data component identifier
            0x00, 0x10, // Data component size is 16 bytes
            0x40, 0x4A, 0x42, 0x8F, 0x9F, 0x44, 0xD4, 0x45, // 52.520008 Latitude in IEE 754 format
            0x40, 0x2A, 0xCF, 0x56, 0x21, 0x74, 0xC4, 0xCE, // 13.404954 Longitude in IEE 754 format

            0x02,       // Property identifier for Destination name
            0x00, 0x09, // Property size is 9 bytes
            0x01,       // Data component identifier
            0x00, 0x06, // Data component size is 6 bytes
            0x42, 0x65, 0x72, 0x6C, 0x69, 0x6E, // Berlin
        ]

        let coordinates = AACoordinates(latitude: 52.520008, longitude: 13.404954)
        let destination = AANaviDestination.setDestination(coordinates: coordinates, name: "Berlin")

        XCTAssertEqual(destination.bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x31, // MSB, LSB Message Identifier for Navi Destination
            0x01,       // Message Type for Navi Destination

            0x07,       // Property identifier for Coordinates
            0x00, 0x13, // Property size is 19 bytes
            0x01,       // Data component identifier
            0x00, 0x10, // Data component size is 16 bytes
            0x40, 0x4A, 0x42, 0x8F, 0x9F, 0x44, 0xD4, 0x45, // 52.520008 Latitude in IEE 754 format
            0x40, 0x2A, 0xCF, 0x56, 0x21, 0x74, 0xC4, 0xCE, // 13.404954 Longitude in IEE 754 format

            0x02,       // Property identifier for Destination name
            0x00, 0x09, // Property size is 9 bytes
            0x01,       // Data component identifier
            0x00, 0x06, // Data component size is 6 bytes
            0x42, 0x65, 0x72, 0x6C, 0x69, 0x6E, // Berlin
        ]

        guard let naviDestination = AAAutoAPI.parseBinary(bytes) as? AANaviDestination else {
            return XCTFail("Parsed value is not AANaviDestination")
        }

        if let coordinates = naviDestination.coordinates?.value {
            XCTAssertEqual(coordinates.latitude, 52.520008, accuracy: 1e-7)
            XCTAssertEqual(coordinates.longitude, 13.404954, accuracy: 1e-7)
        }
        else {
            XCTFail("NaviDestination Location doesn't contain Coordinate")
        }

        XCTAssertEqual(naviDestination.name?.value, "Berlin")
    }
}
