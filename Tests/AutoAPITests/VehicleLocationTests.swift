//
// AutoAPITests
// Copyright (C) 2017 High-Mobility GmbH
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
//  VehicleLocationTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 04/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
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

        XCTAssertEqual(VehicleLocation.getState, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x30, // MSB, LSB Message Identifier for Vehicle Location
            0x01,       // Message Type for Vehicle Location

            0x01,                   // Property Identifier for Coordinates
            0x00, 0x08,             // Property size 8 bytes
            0x42, 0x52, 0x14, 0x7d, // 52.520008 Latitude in IEE 754 format
            0x41, 0x56, 0x7a, 0xb1, // 13.404954 Longitude in IEE 754 format

            0x02,                   // Property Identifier for Heading
            0x00, 0x04,             // Property size 4 bytes
            0x42, 0x52, 0x14, 0x7d  // 52.520008 Heading in IEE 754 format
        ]

        guard let vehicleLocation = AutoAPI.parseBinary(bytes) as? VehicleLocation else {
            return XCTFail("Parsed value is not VehicleLocation")
        }

        if let coordinates = vehicleLocation.coordinates {
            XCTAssertEqual(coordinates.latitude, 52.520008, accuracy: 1e-7)
            XCTAssertEqual(coordinates.longitude, 13.404954, accuracy: 1e-7)
        }
        else {
            XCTFail("Vehicle Location doesn't contain Coordinates")
        }

        XCTAssertEqual(vehicleLocation.heading, 52.520008)
    }
}
