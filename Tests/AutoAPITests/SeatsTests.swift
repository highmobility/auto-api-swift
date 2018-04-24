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
//  SeatsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 07/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class SeatsTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x56, // MSB, LSB Message Identifier for Seats
            0x00        // Message Type for Get Seats State
        ]

        XCTAssertEqual(Seats.getSeatsState, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x56, // MSB, LSB Message Identifier for Seats
            0x01,       // Message Type for Seats State

            0x01,       // Property Identifier for Seat
            0x00, 0x03, // Property size 3 bytes
            0x00,       // Front Left seat
            0x01,       // Person detected
            0x01,       // Seatbelt fastened

            0x01,       // Property Identifier for Seat
            0x00, 0x03, // Property size 3 bytes
            0x01,       // Front Right seat
            0x00,       // No person detected
            0x00        // Seatbelt not fastened
        ]

        guard let seats = AutoAPI.parseBinary(bytes) as? Seats else {
            return XCTFail("Parsed value is not Seats")
        }

        XCTAssertEqual(seats.seats?.count, 2)

        if let frontLeftSeat = seats.seats?.first(where: { $0.position == .frontLeft }) {
            XCTAssertEqual(frontLeftSeat.personDetected, true)
            XCTAssertEqual(frontLeftSeat.seatbeltFastened, true)
        }
        else {
            XCTFail("Seats doesn't contain Front Left Seat")
        }

        if let frontRightSeat = seats.seats?.first(where: { $0.position == .frontRight }) {
            XCTAssertEqual(frontRightSeat.personDetected, false)
            XCTAssertEqual(frontRightSeat.seatbeltFastened, false)
        }
        else {
            XCTFail("Seats doesn't contain Front Right Seat")
        }
    }
}
