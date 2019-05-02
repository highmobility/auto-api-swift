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
//  AAVehicleLocationTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 04/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AAVehicleLocationTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x30, // MSB, LSB Message Identifier for Vehicle Location
            0x00        // Message Type for Get Vehicle Location
        ]

        XCTAssertEqual(AAVehicleLocation.getLocation.bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x30, // MSB, LSB Message Identifier for Vehicle Location
            0x01,       // Message Type for Vehicle Location

            0x04,       // Property identifier for Coordinates
            0x00, 0x13, // Property size is 19 bytes
            0x01,       // Data component identifier
            0x00, 0x10, // Data component size is 16 bytes
            0x40, 0x4A, 0x42, 0x8F, 0x9F, 0x44, 0xD4, 0x45, // 52.520008 Latitude in IEE 754 format
            0x40, 0x2A, 0xCF, 0x56, 0x21, 0x74, 0xC4, 0xCE, // 13.404954 Longitude in IEE 754 format

            0x05,       // Property identifier for Heading
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x40, 0x2A, 0xBD, 0x80, 0xC3, 0x08, 0xFE, 0xAC, // 13.370123 Heading

            0x06,       // Property identifier for Altitude
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x40, 0x60, 0xB0, 0x00, 0x00, 0x00, 0x00, 0x00, // 133.5 meters above the WGS 84 reference ellipsoid point
        ]

        guard let vehicleLocation = AAAutoAPI.parseBinary(bytes) as? AAVehicleLocation else {
            return XCTFail("Parsed value is not AAVehicleLocation")
        }

        if let coordinates = vehicleLocation.coordinates?.value {
            XCTAssertEqual(coordinates.latitude, 52.520008, accuracy: 1e-7)
            XCTAssertEqual(coordinates.longitude, 13.404954, accuracy: 1e-7)
        }
        else {
            XCTFail("Vehicle Location doesn't contain Coordinates")
        }

        XCTAssertEqual(vehicleLocation.heading?.value, 13.370123)
        XCTAssertEqual(vehicleLocation.altitude?.value, 133.5)
    }
}
