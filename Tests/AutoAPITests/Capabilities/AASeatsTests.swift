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
//  AASeatsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 07/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AASeatsTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x56, // MSB, LSB Message Identifier for Seats
            0x00        // Message Type for Get Seats State
        ]

        XCTAssertEqual(AASeats.getSeatsState.bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x56, // MSB, LSB Message Identifier for Seats
            0x01,       // Message Type for Seats State

            0x02,       // Property identifier for Persons detected
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x02,       // Rear right seat
            0x01,       // Person detected

            0x02,       // Property identifier for Persons detected
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x03,       // Rear left seat
            0x00,       // Person not detected

            0x03,       // Property identifier for Seatbelts fastened
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x02,       // Rear right seat
            0x01,       // Seatbelt fastened

            0x03,       // Property identifier for Seatbelts fastened
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x03,       // Rear left seat
            0x00,       // Seatbelt not fastened
        ]

        guard let seats = AAAutoAPI.parseBinary(bytes) as? AASeats else {
            return XCTFail("Parsed value is not AASeats")
        }

        // Persons Detected
        XCTAssertEqual(seats.personsDetected?.count, 2)

        if let personDetected = seats.personsDetected?.first(where: { $0.value?.location == .rearRight }) {
            XCTAssertEqual(personDetected.value?.detected, .detected)
        }
        else {
            XCTFail("Persons Detected doesn't contain Rear Right seat")
        }

        if let personDetected = seats.personsDetected?.first(where: { $0.value?.location == .rearLeft }) {
            XCTAssertEqual(personDetected.value?.detected, .notDetected)
        }
        else {
            XCTFail("Persons Detected doesn't contain Rear Left seat")
        }

        // Seatbelts Fastened
        XCTAssertEqual(seats.seatbeltsFastened?.count, 2)

        if let seatbeltFastened = seats.seatbeltsFastened?.first(where: { $0.value?.location == .rearRight }) {
            XCTAssertEqual(seatbeltFastened.value?.fastened, .fastened)
        }
        else {
            XCTFail("Seatbelts Fastened doesn't contain Rear Right seat")
        }

        if let seatbeltFastened = seats.seatbeltsFastened?.first(where: { $0.value?.location == .rearLeft }) {
            XCTAssertEqual(seatbeltFastened.value?.fastened, .notFastened)
        }
        else {
            XCTFail("Seatbelts Fastened doesn't contain Rear Left seat")
        }
    }
}
