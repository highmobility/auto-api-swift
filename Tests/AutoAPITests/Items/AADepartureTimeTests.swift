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
//  AADepartureTimeTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 03/04/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

@testable import AutoAPI
import XCTest


class AADepartureTimeTests: XCTestCase {

    static var allTests = [("testBytes", testBytes),
                           ("testInit", testInit)]


    // MARK: XCTestCase

    func testBytes() {
        let bytes1: [UInt8] = [
            0x01,   // Departure time is active
            0x10,   // at 16h
            0x20    // 32min
        ]

        XCTAssertEqual(AADepartureTime(state: .active, time: AATime(hour: 16, minute: 32)).bytes, bytes1)

        let bytes2: [UInt8] = [
            0x00,   // Departure time is inactive
            0xFF,   // No time set
            0xFF    // No time set
        ]

        XCTAssertEqual(AADepartureTime(state: .inactive, time: nil).bytes, bytes2)
    }

    func testInit() {
        // Successful#1
        let bytes1: [UInt8] = [
            0x01,   // Departure time is active
            0x10,   // at 16h
            0x20    // 32min
        ]

        if let time = AADepartureTime(bytes: bytes1) {
            XCTAssertEqual(time.state, .active)
            XCTAssertEqual(time.time?.hour, 16)
            XCTAssertEqual(time.time?.minute, 32)
        }
        else {
            XCTFail("Failed to initialise AADepartureTime")
        }

        // Successful#2
        let bytes2: [UInt8] = [
            0x00,   // Departure time is inactive
            0xFF,   // No time set
            0xFF    // No time set
        ]

        if let time = AADepartureTime(bytes: bytes2) {
            XCTAssertEqual(time.state, .inactive)
            XCTAssertNil(time.time)
        }

        // Fail#1
        let bytes3: [UInt8] = [
            0x01    // Invalid bytes count
        ]

        XCTAssertNil(AADepartureTime(bytes: bytes3))

        // Fail#2
        let bytes4: [UInt8] = [
            0xF1,   // INVALID state
            0x10,   // at 16h
            0x20    // 32min
        ]

        XCTAssertNil(AADepartureTime(bytes: bytes4))
    }
}
