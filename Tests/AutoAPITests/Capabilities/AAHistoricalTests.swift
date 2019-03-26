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
//  AAHistoricalTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 26/03/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAHistoricalTests: XCTestCase {

    static var allTests = [("testGetHistoricalStates", testGetHistoricalStates),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetHistoricalStates() {
        let bytes: [UInt8] = [
            0x00, 0x12, // MSB, LSB Message Identifier for Historical
            0x00,       // Message Type for Get Historical States

            0x01,       // Property Identifier for Capability identifier
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component
            0x00, 0x02, // Data component size is 2 bytes
            0x00, 0x20, // Identifier for Door Locks

            0x02,       // Property Identifier for Start date
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component
            0x00, 0x08, // Property size is 8 bytes
            0x00, 0x00, 0x01, 0x69, 0xBA, 0x11, 0x03, 0x58, // 26 March 2019 at 12:54:31 GMT

            0x03,       // Property Identifier for End date
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component
            0x00, 0x08, // Property size is 8 bytes
            0x00, 0x00, 0x01, 0x69, 0xCE, 0xAA, 0x73, 0x58  // 30 March 2019 at 12:54:31 GMT
        ]

        let start = Date(timeIntervalSince1970: 1_553_604_871.0)
        let end = Date(timeIntervalSince1970: 1_553_950_471.0)

        XCTAssertEqual(AAHistorical.getHistoricalStates(for: AADoorLocks.self, startDate: start, endDate: end).bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x12, // MSB, LSB Message Identifier for Historical
            0x01,           // Message Type for Historical States

            0x01,       // Property Identifier for States
            0x00, 0x1C, // Property size 28 bytes
            0x01,       // Data component
            0x00, 0x19, // Data component size 25 bytes
            0x00, 0x20, // Door Locks Identifier
            0x01,       // Message Type for Door Locks
            0x03,       // Property Identifier for Locks
            0x00, 0x05, // Property size 5 byte
            0x01,       // Data component
            0x00, 0x02, // Data component size 2 byte
            0x00,       // Front left door
            0x00,       // Trunk Unlocked
            0xA2,       // Property Identifier for Timestamp (Universal Property)
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component
            0x00, 0x08, // Data component size is 8 bytes
            0x00, 0x00, 0x01, 0x6B, 0x08, 0xCE, 0x5F, 0x58  // 30 May 2019 at 12:54:31 GMT
        ]

        guard let historical = AutoAPI.parseBinary(bytes) as? AAHistorical else {
            return XCTFail("Parsed value is not AAHistorical")
        }

        // States
        XCTAssertEqual(historical.states?.count, 1)

        if let doorLocks = historical.states?.first(where: { $0 is AADoorLocks }) as? AADoorLocks {
            XCTAssertEqual(doorLocks.locks?.count, 1)
            XCTAssertEqual(doorLocks.timestamp, Date(timeIntervalSince1970: 1_559_220_871.0))

            if let lock = doorLocks.locks?.first(where: { $0.value?.location == .frontLeft }) {
                XCTAssertEqual(lock.value?.lock, .unlocked)
            }
            else {
                XCTFail("Door Locks doesn't contain Front Left door")
            }
        }
        else {
            XCTFail("States doesn't contain AADoorLocks")
        }
    }
}
