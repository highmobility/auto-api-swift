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
//  SeatsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 07/12/2017.
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
