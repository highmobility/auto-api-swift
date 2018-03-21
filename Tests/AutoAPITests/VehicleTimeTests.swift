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
//  VehicleTimeTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
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
