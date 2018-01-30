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
//  MaintenanceTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 29/11/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
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

        guard let maintenance = AutoAPI.parseBinary(bytes) as? Maintenance else {
            return XCTFail("Parsed value is not Maintenance")
        }

        XCTAssertEqual(maintenance.daysToNextService, 501)
        XCTAssertEqual(maintenance.kmToNextService, 3_681)
    }
}
